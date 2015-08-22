package TWS::Controller::Movie;
use Mojo::Base 'Mojolicious::Controller';

sub data {
	my $self	= shift;
	my $movie_id	= $self->param("movie_id");

	my $movie = $self->get_movie($movie_id);
	$self->render(json => {data => [defined $movie ? $movie->data : undef], code => ["NYI"]});
}

sub create {
	my $self	= shift;
	my $data	= $self->req->json;

	my $movie = $self->create_movie($data);
	$self->render(json => {sent => (defined $movie and $movie->id ? \1 : \0)})
}

42
