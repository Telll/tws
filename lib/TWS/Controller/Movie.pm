package TWS::Controller::Movie;
use Mojo::Base 'Mojolicious::Controller';

sub detail {
	my $self	= shift;
	my $movie_id	= $self->param("movie_id");

	my $movie_data = $self->get_movie_data($movie_id);
	$self->render(json => $movie_data);
}

42
