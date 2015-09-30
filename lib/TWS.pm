package TWS;
use Mojo::Base 'Mojolicious';
use TWS::Schema;
use TWS::Routes;
use TWS::Helpers;
use TWS::Minion::Email;
use Mojo::EventEmitter;
use Mojo::Util qw/dumper/;

has schema => sub {
	my $self = shift;
	my $db = $self->config->{db};
	TWS::Schema->connect($db->{connect_string}, $db->{user}, $db->{password});
};

has delimiter => sub {
	"$///" . ("-" x 10) . "//";
};

has events => sub {
	Mojo::EventEmitter->new
};

sub startup {
	my $self = shift;

	my $cmds = $self->plugin(CommandWS => {path => "/ws"});
	my $authenticated = $cmds
		->type("SUBSCRIBE")
		->schema({
			type		=> "object",
			required	=> [qw/auth_key api_key/],
			properties	=> {
				auth_key	=> {type => "string"},
				api_key		=> {type => "string"},
			}
		})
		->conditional(sub {shift()->validate_api_key(shift()->data->{api_key})})
		->conditional(sub {shift()->validate_auth_key(shift()->data->{auth_key})})
	;
	$authenticated
		->command(photolink => sub {
			shift()->subscribe_photolink(shift())
		})
	;
	$authenticated
		->schema({
			type		=> "object",
			required	=> [qw/movie_id/],
			properties	=> {
				movie_id	=> {type => "integer"},
			}
		})
		->command(trackmotion => sub {
			shift()->subscribe_trackmotion(shift())
		})
	;

	$self->plugin(SecureCORS => {
		"cors.origin"		=> "*",
		"cors.credentials"	=> 0,
		"cors.headers"		=> "X-API-Key, X-Auth-Key",
		"cors.expose"		=> "X-API-Key, X-Auth-Key",
		"cors.methods"		=> "GET, POST, PUT, DELETE, OPTIONS",
	});

	$self->plugin("CORS");
	$self->plugin("JSON::Validator", auto_validate => "render");

	$self->hook(before_dispatch => sub {
		my $c = shift;
		$c->res->headers->header( 'Access-Control-Allow-Headers' => 'Content-Type, Authorization, X-Requested-With, X-API-Key, X-Auth-Key' );
	});

	$self->plugin(JSONConfig => {
		file	=> $self->home->rel_dir("tws.json"),
		default => {
			minion_backend	=> {File => "/tmp/bla.db"},
			email		=> {
				template	=> "email.mt",
				from		=> 'test@telll.com',
				subject		=> "Telll - photolinks",
			},
		},
	});
	$self->plugin(Minion => $self->config->{minion_backend});

	TWS::Helpers::create_helpers($self);

	$self->minion->add_task(email => \&TWS::Minion::Email::send_mail);

	#$self->mode('production');

	# Router
	my $r = $self->routes;
	TWS::Routes::create_routes($r);
}

42
