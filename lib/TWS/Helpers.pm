package TWS::Helpers;
use Mojo::Util qw/dumper/;
use Mojo::JSON qw/decode_json/;

sub create_helpers {
	my $tws = shift;

	$tws->helper(delimiter	=> sub { shift()->app->delimiter});
	$tws->helper(db		=> sub { shift()->app->schema });
	$tws->helper(resultset	=> sub { shift()->db->resultset(shift) });

	$tws->helper(validate_api_key => sub {
		print "validate_api_key(@_)$/";
		my $self	= shift;
		my $key		= shift;

		return !!$key
	});

	$tws->helper(validate_auth_key => sub {
		print "validate_auth_key(@_)$/";
		my $self	= shift;
		my $key		= shift;

		my $auth = $self->resultset("Auth")->find({auth_key => $key, logout => undef});
		if($auth) {
			$self->stash->{device}	= $auth->device;
			$self->stash->{user}	= $self->stash->{device}->user;
			return $auth if $self->stash->{user}->active;
		}
	});

	$tws->helper(get_movie => sub {
		my $self	= shift;
		my $id		= shift;

		my $movie = $self->resultset("Movy")->find($id);
		return $movie if $movie;
		undef
	});

	$tws->helper(create_movie => sub {
		my $self	= shift;
		my $data	= shift;

		my $movie	= $self->resultset("Movy");
		$movie->update_or_create($data);
	});

	$tws->helper(subscribe_photolink => sub {
		print "subscribe_photolink(@_)$/";
		my $c		= shift;
		my $msg		= shift;

		my $device = $c->stash->{device};
		$c->inactivity_timeout(36000);
		my $event = "click " . $c->stash->{user}->id;
		my $cb = $c->app->mysql->pubsub->listen($event => sub {
			my $self	= shift;
			my $data	= decode_json shift;
			$c->app->log->debug("received pl: ", dumper $data);
			my $track_id	= $data->{trackmotion};
			my $extra_data	= $data->{extra_data};
			my $trackmotion = $c->resultset("Trackmotion")->find($track_id);

			if($trackmotion) {
				$c->app->log->debug("sending tm");
				$device->update_or_create_related(device_photolinks => {photolink => $trackmotion->photolink->id});
				$msg = $msg->reply({
					extra_data	=> $extra_data,
					photolink	=> $trackmotion->photolink->data,
					thumb		=> $trackmotion->thumb,
					movie_id	=> $trackmotion->movie->id
				});
			}
		});
		$c->on(finish => sub { shift->app->mysql->pubsub->unlisten($event => $cb) });
	});

	$tws->helper(subscribe_trackmotion => sub {
		my $c		= shift;
		my $msg		= shift;

		$c->inactivity_timeout(36000);
		my $movie_id = $msg->data->{movie_id};
		my $event = "new_point $movie_id";
		my $cb = $c->app->mysql->pubsub->listen($event => sub {
			my $self	= shift;
			my $track_id	= shift;
			my $trackmotion	= $c->resultset("Trackmotion")->find($track_id);

			if($trackmotion) {
				$msg = $msg->reply({trackmotion => $trackmotion->data});
			}
		});
		$c->on(finish => sub { shift->app->mysql->pubsub->unlisten($event => $cb) });
		# Emit every existent track for that movie
	});
}

42
