package TWS::Controller::TrackMotion;
use Mojo::Base 'Mojolicious::Controller';

sub create {
	my $self	= shift;
	my $data	= $self->req->json;

	my $track_motion = $self->stash->{got_photolink}->create_related(trackmotions => {movie => $data->{movie}});
	for my $point(@{ $data->{points} }) {
		$track_motion->create_related(points => $point)
	}
	$self->render(json => {created => $track_motion->id ? \1 : \0, id => $track_motion->id})
}

sub get {
	my $self	= shift;

	$self->stash->{got_track_motion} = $self->resultset("Trackmotion")->find($self->stash->{track_motion_id});
	if($self->stash->{got_track_motion}) {
		$self->render(json => $self->stash->{got_track_motion}->data(@{ $self->req->query_params->every_param("include") }, qw/points/));
		return 1
	}
	$self->render(json => {error => [{message => "TrackMotion not found"}]}, status => 404);
	undef
}

sub add_point {
	my $self	= shift;
	my $track_id	= $self->stash->{track_motion_id};
	my $data	= $self->req->json;

	my $track = $self->resultset("Trackmotion")->find($track_id);
	my $point = $track->create_related(points => $data);
	my $movie_id = $track->movie->id;

	$self->app->events->emit("new_point $movie_id" => $track_id);
	$self->render(json => {created => \1, id => $point->id})
}

sub click {
	my $self		= shift;
	my $track_motion	= $self->stash->{got_track_motion};
	my $json		= $self->req->json;

	$self->app->events->emit("click " . $self->stash->{user}->id => $track_motion);
	$self->render(json => {sent => \1})
}

42
