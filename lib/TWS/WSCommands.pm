package TWS::WSCommands;
use Mojo::JSON qw/encode_json/;

sub new {
	my $class = shift;

	bless {
		clients	=> {},
	}, $class;
}

sub add {
	my $self	= shift;
	my $user	= shift;
	my $tx		= shift;

	push @{ $self->{clients}{$user->email} }, {user => $user, tx => $tx}
}

sub send_clients {
	my $self	= shift;
	my $email	= shift;
	my $data	= shift;

	for my $client(@{ $self->{clients}{$email} }) {
		$client->{tx}->write_chunk(encode_json($data) . $/);
	}
}

sub photolink {
	my $self	= shift;
	my $email	= shift;
	my $photolink	= shift;

	$self->send_clients($email => $photolink)
}

42
