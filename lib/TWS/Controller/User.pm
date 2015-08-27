package TWS::Controller::User;
use Mojo::Base 'Mojolicious::Controller';

sub create {
	my $self	= shift;
	my $data	= $self->req->json;

	my $user = $self->create_user($data);
	$self->render(json => {sent => $user->id ? \1 : \0})
}

sub get {
	my $self	= shift;

	$self->stash->{got_user} = $self->resultset("User")->find($self->stash->{user_id});
	return $self->render(json => $self->stash->{got_user}->data) if $self->stash->{got_user};
	$self->render(json => {error => [{message => "User not found"}]}, status => 404);
}

42
