package TWS;
use Mojo::Base 'Mojolicious';
use TWS::Schema;
use TWS::Routes;
use TWS::Helpers;
use TWS::Minion::Email;
use Mojo::EventEmitter;
use Mojo::Util qw/dumper/;
use Mojo::mysql;
use Mojo::JSON qw/encode_json/;

has schema => sub {
	my $self = shift;
	my $db = $self->config->{db};
	TWS::Schema->connect("dbi:$db->{type}:database=$db->{database}", $db->{user}, $db->{password});
};

has mysql => sub {
	my $self = shift;
	my $db = $self->config->{db};
	Mojo::mysql->new("mysql://$db->{user}:$db->{password}\@/$db->{database}")
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
	my $api = $cmds->conditional(sub {shift()->validate_api_key(shift()->data->{api_key})});
	$api
		->type("REQUEST")
		->schema({
			type		=> "object",
			required	=> [qw/user_name password/],
			oneOf		=> [
				{required => [qw/device/]},
				{required => [qw/model/]}
			],
			properties	=> {
				user_name	=> {type => "string"},
				password	=> {type => "string"},
				device		=> {type => "integer"},
				model		=> {enum => [qw/iPad iPhone/]}
			}
		})
		->command(login => sub {
			my $self	= shift;
			my $cmd		= shift;

			print "login <",  "-" x 30, $/;

			my $user_name	= $cmd->data->{user_name};
			my $password	= $cmd->data->{password};
			my $device	= $cmd->data->{device};
			my $model	= $cmd->data->{model};
			my $dev_obj;

			my $user = $self->resultset("User")->authenticate($user_name, $password);
			return $cmd->error("Wrong user_name or password") unless $user;
			my $auth = $user->generate_token;
			if(defined $device) {
				$dev_obj = $self->resultset("Device")->find($device);
			} elsif(defined $model) {
				my $dev_model = $self->resultset("DeviceModel")->find({name => $model});
				$dev_obj = $user->create_related(devices => {model => $dev_model->id})
			}
			$dev_obj->create_related(auths => {auth_key => $auth});
			$cmd->reply({auth_key => $auth, device => $dev_obj->id});
		})
	;
	my $authenticated = $api
		->schema({
			type		=> "object",
			required	=> [qw/auth_key api_key/],
			properties	=> {
				auth_key	=> {type => "string"},
				api_key		=> {type => "string"},
			}
		})
		->conditional(sub {
			my $self	= shift;
			my $cmd		= shift;
			$cmd->{stash}{auth} = $self->validate_auth_key($cmd->data->{auth_key})})
	;
	$authenticated
		->type("SUBSCRIBE")
		->command(photolink => sub {
			shift()->subscribe_photolink(shift())
		})
	;
	$authenticated
		->type("SUBSCRIBE")
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
	$authenticated
		->type("REQUEST")
		->command(logout => sub{
			my $self	= shift;
			my $cmd		= shift;
			$cmd->{stash}{auth}->update({logout => \"now()"});
			$cmd->reply(\1);
		})
	;
	$authenticated
		->type("REQUEST")
		->schema({
			type		=> "object",
			required	=> [qw/trackmotion/],
			properties	=> {
				trackmotion	=> {type => "integer"},
				extra_data	=> {}
			}
		})
		->command(click_trackmotion => sub{
			my $self	= shift;
			my $cmd		= shift;
			$self->app->mysql->pubsub->notify("click " . $cmd->{stash}{auth}->device->user->id => encode_json {
				trackmotion	=> $cmd->data->{trackmotion},
				extra_data	=> $cmd->data->{extra_data}
			});
		})
	;
	$authenticated
		->type("REQUEST")
		->command(movies => sub{
			my $self	= shift;
			my $cmd		= shift;
			$cmd->reply({movies => [map {$_->data} $self->resultset("Movy")->all]});
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
