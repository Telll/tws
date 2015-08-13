package TWS::WSCommands;
use Mojo::JSON qw/encode_json/;

sub new {
	my $class	= shift;
	my $delimiter	= shift;

	bless {
		clients	=> {},
		delimiter => $delimiter,
	}, $class;
}

sub add {
	my $self	= shift;
	my $user	= shift;
	my $tx		= shift;

	$tx->kept_alive(1);
	print "Adding: ", $tx->remote_address, $/;
	push @{ $self->{clients}{$user->email} }, {user => $user, tx => $tx}
}

sub remove {
	my $self	= shift;
	my $user	= shift;
	my $tx		= shift;

	$self->{clients}{$user->email} = [ grep {$_->{tx} eq $tx} @{ $self->{clients}{$user->email} } ]
}

sub send_clients {
	my $self	= shift;
	my $email	= shift;
	my $data	= shift;

	print "clients: @{ $self->{clients}{$email} }$/";
	for my $client(@{ $self->{clients}{$email} }) {
		if(not $client->{tx}->is_finished) {
			my $msg = encode_json($data);
			print "sending: ", $client->{tx}->remote_address, ", $msg$/";
			$client->{tx}->res->content->write_chunk($msg . $self->{delimiter});
		} else {
			$self->remove($email, $client->{tx})
		}
	}
}

sub photolink {
	my $self	= shift;
	my $email	= shift;
	my $photolink	= shift;

	$self->send_clients($email => $photolink)
}

42
