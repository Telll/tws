package TWS::Controller::User;
use Mojo::Base 'Mojolicious::Controller';

sub create {
	my $self	= shift;
	my $data	= $self->req->json;

	my $user = $self->create_user($data);
	$self->render(json => {sent => $user->id ? \1 : \0})
}

42
