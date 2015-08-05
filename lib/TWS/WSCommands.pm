package TWS::WSCommands;

sub new {
	my $class = shift;

	bless {
		clients	=> {},
	}, $class;
}

sub add {
	my $self	= shift;
	my $user	= shift;
	my $client	= shift;

	push @{ $self->{clients}{$user->email} }, {user => $user, client => $client, meth => ($client->isa("Mojo::Transaction::WebSocket") ? "send" : "write_chunk")}
}

sub send_clients {
	my $self	= shift;
	my $email	= shift;

	for my $client(@{ $self->{clients}{$email} }) {
		my $meth = $client->{meth};
		$client->{client}->$meth(@_)
	}
}

sub photolink {
	my $self	= shift;
	my $email	= shift;
	my $photolink	= shift;

	$self->send_clients($email => $photolink)
}

42
