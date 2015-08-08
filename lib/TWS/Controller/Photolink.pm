package TWS::Controller::Photolink;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::JSON qw(decode_json);
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

	#Mojo::IOLoop->stream($self->tx->connection)->timeout(30);

	$clients->add($self->stash->{user}, $self);
	my $id = Mojo::IOLoop->recurring(10 => sub {
		$self->write_chunk("alive?$delimiter");
	});

	$self->on(finish => sub {
		Mojo::IOLoop->remove($id);
		$clients->remove($self->stash->{user}, $self)
	});
}

sub send_pl {
	my $self	= shift;
	my $movie_id	= $self->stash->{movie_id};
	my $plid	= $self->stash->{plid};


	my $pl = $self->get_photolink($movie_id, $plid);
	my $res = Mojo::JSON->true;
	if(not $pl) {
		$res = Mojo::JSON->false;
	} else {
		$clients->photolink($self->stash->{user}->email, $pl);
		$self->minion->enqueue(email => [$self->stash->{user}->email, $pl]);
	}
	$self->render(json => {sent => $res})
}

42
