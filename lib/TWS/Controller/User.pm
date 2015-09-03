package TWS::Controller::User;
use Mojo::Base 'Mojolicious::Controller';

sub create {
	my $self	= shift;
	my $data	= $self->req->json;

	my $userrs	= $self->resultset("User");
	if(exists $data->{password}) {
		$data->{salt}		= $userrs->generate_salt;
		$data->{counter}	= 1024;
		$data->{password}	= $userrs->hashfy_password($data->{password}, $data->{counter}, $data->{salt});
	}
	my $user = $userrs->update_or_create($data);
	$self->render(json => {created => $user->id ? \1 : \0, id => $user->id}, status => 201)
}

sub del {
	my $self	= shift;

	if($self->stash->{got_user}) {
		my $deleted = (delete $self->stash->{got_user})->delete;
		$self->render(json => {deleted => $deleted ? \1 : \0})
	}
}

sub get {
	my $self	= shift;

	$self->stash->{got_user} = $self->resultset("User")->find($self->stash->{user_id});
	if($self->stash->{got_user}) {
		$self->render(json => $self->stash->{got_user}->data);
		return 1
	}
	$self->render(json => {error => [{message => "User not found"}]}, status => 404);
	undef
}

sub photolinks {
	my $self	= shift;

	$self->render(json => {photolinks => [map {$_->data} $self->stash->{got_user}->photolinks]})
}

42
