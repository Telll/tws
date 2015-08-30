package TWS::Controller::Photolink;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::JSON qw(decode_json encode_json);
use TWS::WSCommands;

my $delimiter = "$///" . ("-" x 10) . "//";

my $clients = TWS::WSCommands->new($delimiter);

sub connectws {
	my $self	= shift;
	$clients->add($self->stash->{user}, $self);

	$self->on(message => sub {
		my $self	= shift;
		my $msg		= shift;

		my $cmd = decode_json $msg;
	});
}

sub longpolling {
	my $self	= shift;
	
	$self->write_chunk;

	$self->inactivity_timeout(3600);
	my $device	= $self->stash->{device};
	my $photolinkrs	= $self->resultset("Photolink");
	my $c = $self;
	my $cb = $self->app->events->on($self->stash->{user}->email => sub {
		my $self		= shift;
		my $movie_id		= shift;
		my $photolink_id	= shift;
		my $extradata		= shift;

		my $photolink = $photolinkrs->find({id => $photolink_id, movie => $movie_id});
		if($photolink) {
			$device->update_or_create_related(device_photolinks => {photolink => $photolink_id});
			my $pldata = $photolink->data;
			$pldata->{extradata} = $extradata;
			$c->write_chunk(encode_json($pldata) . $delimiter);
		}
	});
	$self->on(finish => sub { shift->app->events->unsubscribe($self->stash->{user}->email => $cb) });
}

sub send_pl {
	my $self	= shift;
	my $movie_id	= $self->stash->{movie_id};
	my $plid	= $self->stash->{plid};
	my $json	= $self->req->json;
	my $extradata	= $json->{extradata} if $json;

	$self->app->events->emit($self->stash->{user}->email => $movie_id, $plid, $extradata);
	$self->render(json => {sent => \1})
}

42
