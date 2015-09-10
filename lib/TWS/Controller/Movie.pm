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

	my $movie = $self->resultset("Movy")->update_or_create($data);
	return $self->render(json => {created => \1, id => $movie->id}, status => 201) if defined $movie;
	$self->render(json => {created => \0}, status => 201)

}

sub del {
	my $self	= shift;

	if($self->stash->{got_movie}) {
		my $deleted = (delete $self->stash->{got_movie})->delete;
		$self->render(json => {deleted => $deleted ? \1 : \0})
	}
}

sub get {
	my $self	= shift;

	$self->stash->{got_movie} = $self->resultset("Movy")->find($self->stash->{movie_id});
	return $self->render(json => $self->stash->{got_movie}->data) if $self->stash->{got_movie};
	$self->render(json => {error => [{message => "Movie not found"}]}, status => 404);
	undef
}

sub photolinks {
	my $self	= shift;
	my $movie	= $self->stash->{got_movie};
	$self->render(json => {photolinks => [map {$_->data} $movie ? $movie->photolinks->all : ()]})
}

42
