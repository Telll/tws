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
	my $cb = $self->events->on($self->stash->{user}->email => sub { $self->write_chunk(pop . $delimiter) });
	$self->on(finish => sub { shift->events->unsubscribe($self->stash->{user}->email => $cb) });
}

sub send_pl {
	my $self	= shift;
	my $movie_id	= $self->stash->{movie_id};
	my $plid	= $self->stash->{plid};
	my $extradata	= $self->req->json->{extradata};

	my $pl = $self->get_photolink($movie_id, $plid);
	$pl->{extradata} = $extradata;
	my $res = Mojo::JSON->true;
	if(not $pl) {
		$res = Mojo::JSON->false;
	} else {
		$self->events->emit($self->stash->{user}->email => encode_json $pl);
		$self->minion->enqueue(email => [$self->stash->{user}->email, $pl]);
	}
	$self->render(json => {sent => $res})
}

42
