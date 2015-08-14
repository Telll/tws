package TWS;
use Mojo::Base 'Mojolicious';
use TWS::Schema;
use Mojo::EventEmitter;

has schema => sub {
	my $self = shift;
	my $db = $self->config->{db};
	TWS::Schema->connect($db->{connect_string}, $db->{user}, $db->{password});
};

has delimiter => sub {
	"$///" . ("-" x 10) . "//";
};

sub startup {
	my $self = shift;

	$self->plugin(SecureCORS => {
		"cors.origin"		=> "*",
		"cors.credentials"	=> 0,
		"cors.headers"		=> "X-API-Key, X-Auth-Key",
		"cors.expose"		=> "X-API-Key, X-Auth-Key",
		"cors.methods"		=> "GET, POST, PUT, DELETE, OPTIONS",
	});

	$self->plugin("CORS");

	$self->hook( before_dispatch => sub {
			my $c = shift;
			$c->res->headers->header( 'Access-Control-Allow-Headers' => 'Content-Type, Authorization, X-Requested-With, X-API-Key, X-Auth-Key' );
		}
	);

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

	$self->minion->add_task(email => sub {
		#use Mojo::Template;
		#use Data::Dumper;
		#use Net::AWS::SES;

		#my $job		= shift;
		#my $email	= shift;
		#my $photolink	= shift;

		#print "Processing email: $email, ", Dumper $photolink;
		#my $mt = Mojo::Template->new;
		#my $output = $mt->render_file($self->config->{email}->{template}, $email, $photolink);
		#print $output, $/;

		#my $aws		= $self->config->{aws};
		#my $email_conf	= $self->config->{email};
		#my $ses = Net::AWS::SES->new(access_key => $aws->{access_key}, secret_key => $aws->{secret_key});
		#my $r = $ses->send(
		#	From    => $email_conf->{from},
		#	To      => $email,
		#	Subject => $email_conf->{subject},
		#	Body    => $output,
		#);
		#if (not $r->is_success) {
		#	$job->app->log->debug("error: $@");
		#	$job->finish({ status => "error", msg => $@});
		#}
		#else {
		#	$job->finish({ status => "success", msg => "Mail to $email sent"});
		#}
	});

	#$self->mode('production');

	# helpers

	$self->helper(events => sub { state $events = Mojo::EventEmitter->new });
	$self->helper(delimiter => sub {$self->app->delimiter});
	$self->helper(db => sub { $self->app->schema });
	$self->helper(resultset => sub { shift()->db->resultset(shift) });

	$self->helper(validate_api_key => sub {
		my $self	= shift;
		my $key		= shift;

		return !!$key
	});

	$self->helper(validate_auth_key => sub {
		my $self	= shift;
		my $key		= shift;

		my $auth = $self->resultset("Auth")->find({auth_key => $key});
		if($auth) {
			$self->stash->{user} = $auth->user;
			return 1;
		}
	});

	$self->helper(user_login => sub {
		my $self	= shift;
		my $username	= shift;
		my $password	= shift;

		my $user = $self->resultset("User")->find({username => $username, password => $password});
		$self->stash->{user} = $user;
		$user->_login if $user
	});


	$self->helper("get_movie_data" => sub {
		my $self	= shift;
		my $movie_id	= shift;

		my $movie = $self->resultset("Movy")->find($movie_id);
		return $movie->movie_data if $movie;
	});

	$self->helper("get_photolink" => sub {
		my $self	= shift;
		my $movie_id	= shift;
		my $plid	= shift;

		my $photolink = $self->resultset("Photolink")->find({movies_idmovies => $movie_id, idphotolinks => $plid});
		return $photolink->data if $photolink;
	});

	# Router
	my $r = $self->routes;

	# Normal route to controller
	my $api = $r->under("/")->to(
		"api#validate",
		"cors.origin"		=> "*",
		"cors.credentials"	=> 1,
		"cors.headers"		=> "X-API-Key, X-Auth-Key",
		"cors.expose"		=> "X-API-Key, X-Auth-Key",
	);

	$api->post("/login")->to("session#login");
	$api->cors("/login");

	my $app = $api->under("/app")->to("session#verify");
	my $appcors = $api->under("/app");

	$app->websocket("/photolink/:api_key/:auth_key")->to("photolink#wsconnect");
	$appcors->cors("/photolink/:api_key/:auth_key");

	$app->get("/photolink/lp")->to("photolink#longpolling");
	$appcors->cors("/photolink/lp")->to(
		"cors.methods"	=> "GET",
		"cors.headers"	=> "X-API-Key, X-Auth-Key",
	);

	$app->post("/photolink/send/:movie_id/:plid")->to("photolink#send_pl");
	$appcors->cors("/photolink/send/:movie_id/:plid")->to(
		"cors.methods"	=> "POST",
		"cors.headers"	=> "X-API-Key, X-Auth-Key",
	);

	my $player = $app->under("/player");
	$player->get("/movie/:movie_id")->to("movie#detail");
	$appcors->under("/player")->cors("/movie/:movie_id")->to(
		"cors.methods"	=> "GET",
		"cors.headers"	=> "X-API-Key, X-Auth-Key",
	);
}

42
