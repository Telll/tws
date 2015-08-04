package TWS;
use Mojo::Base 'Mojolicious';
use TWS::Schema;

has schema => sub {
	TWS::Schema->connect('dbi:mysql:database=tws', 'root', '2c%jjTELLL9*8g)');
};

sub startup {
	my $self = shift;

	#$self->mode('production');

	# helpers

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

		return !!$key
	});

	$self->helper(user_login => sub {
		my $self	= shift;
		my $username	= shift;
		my $password	= shift;

		my $user = $self->resultset("User")->find({username => $username, password => $password});
		$user->_login if $user
	});


	$self->helper("get_movie_data" => sub {
		my $self	= shift;
		my $movie_id	= shift;

		my $movie = $self->resultset("Movy")->find($movie_id);
		return $movie->movie_data if $movie;
	});

	# Router
	my $r = $self->routes;

	# Normal route to controller
	my $root = $r->under('/')->to('api#validate');

	$root->post('/login')->to('session#login');

	my $app = $root->under('/app')->to('session#verify');
	$app->websocket('/photolink')->to('photolink#connect');
	my $player = $app->under('/player');
	$player->get("/movie/:movie_id")->to('movie#detail');
}

42
