package TWS::Controller::TrackMotion;
use Mojo::Base 'Mojolicious::Controller';

sub create {
	my $self	= shift;
	my $data	= $self->req->json;

	my $track_motion = $self->stash->{got_photolink}->create_related(trackmotions => {});
	for my $point(@$data) {
		$track_motion->create_related(points => $point)
	}
	$self->render(json => {created => $track_motion->id ? \1 : \0, id => $track_motion->id})
}

sub get {
	my $self	= shift;

	$self->stash->{got_track_motion} = $self->resultset("Trackmotion")->find($self->stash->{track_motion_id});
	if($self->stash->{got_track_motion}) {
		$self->render(json => $self->stash->{got_track_motion}->data($self->req->query_params->every_param("include")));
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
	$track->create_related(points => $data);
	my $movie_id = $track->photolink->movie->id;

	$self->app->events->emit("trackmotion $movie_id" => $track_id);
}

42
