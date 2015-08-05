package TWS::Controller::Photolink;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::JSON qw(decode_json);
use TWS::WSCommands;

my $clients = TWS::WSCommands->new;

sub connectws {
	my $self	= shift;
	$clients->add($self->stash->{user}, $self->tx);

	$self->on(message => sub {
		my $self	= shift;
		my $msg		= shift;

		my $cmd = decode_json $msg;
	});
}

sub longpolling {
	my $self	= shift;
	#Mojo::IOLoop->stream($self->tx->connection)->timeout(30);
	$clients->add($self->stash->{user}, $self->tx);
	my $id = Mojo::IOLoop->recurring(5 => sub {
		$self->write_chunk("alive?$/");
	});

	$self->on(finish => sub { Mojo::IOLoop->remove($id) });
}

sub send_pl {
	my $self	= shift;
	my $msg		= $self->req->json;

	$clients->photolink($msg);
	$self->render(json => {sent => "OK"})
}

42
