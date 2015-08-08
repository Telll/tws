package TWS;
use Mojo::Base 'Mojolicious';
use TWS::Schema;

has schema => sub {
	TWS::Schema->connect('dbi:mysql:database=tws', 'root', '2c%jjTELLL9*8g)');
};

sub startup {
	my $self = shift;

	$self->plugin(Minion => {File => "/tmp/bla.db"});

	my $delimiter = "$///" . ("-" x 10) . "//";

	$self->minion->add_task(email => sub {
		use Mojo::Template;
		use Email::Sender::Simple qw(sendmail);
		use Email::Simple;
		use Email::Simple::Creator;
		use Email::Sender::Transport::SMTP::TLS;
		use Data::Dumper;

		my $job		= shift;
		my $email	= shift;
		my $photolink	= shift;

		print "Processing email: $email, ", Dumper $photolink;
		my $mt = Mojo::Template->new;
		my $output = $mt->render_file("email.mt", $email, $photolink);
		print $output, $/;

		my $mail = Email::Simple->create(
			header => [
				To     => $email,
				From    => 'test@telll.com',
				Subject => "Telll - photolinks",
			],
			body => $output,
		);
		#my $transport = Email::Sender::Transport::SMTP::TLS->new({
		#		host => app->config->{smtp_host},
		#		port => app->config->{smtp_port},
		#		username => app->config->{smtp_user},
		#		password => app->config->{smtp_pass},
		#		timeout => 10,
		#	});

		eval {
			#sendmail($mail, {transport => $transport });
		};
		if ($@) {
			$job->app->log->debug("error: $@");
			$job->finish({ status => "error", msg => $@});
		}
		else {
			$job->finish({ status => "success", msg => "Mail to $email sent"});
		}
	});

	#$self->mode('production');

	# helpers

	$self->helper(delimiter => sub {$delimiter});
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
	my $root = $r->under('/')->to('api#validate');

	$root->post('/login')->to('session#login');

	my $app = $root->under('/app')->to('session#verify');
	$app->websocket('/photolink/:api_key/:auth_key')->to('photolink#wsconnect');
	$app->get('/photolink/lp')->to('photolink#longpolling');
	$app->post('/photolink/send/:movie_id/:plid')->to('photolink#send_pl');
	my $player = $app->under('/player');
	$player->get("/movie/:movie_id")->to('movie#detail');
}

42
