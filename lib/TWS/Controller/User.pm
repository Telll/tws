package TWS::Controller::User;
use Mojo::Base 'Mojolicious::Controller';

sub create {
	my $self	= shift;
	my $data	= $self->req->json;

	if(exists $self->stash->{user_id}) {
		$data->{id} = $self->stash->{user_id};
	}

	my $userrs	= $self->resultset("User");
	if(exists $data->{password}) {
		$data->{salt}		= $userrs->generate_salt;
		$data->{counter}	= 1024;
		$data->{password}	= $userrs->hashfy_password($data->{password}, $data->{counter}, $data->{salt});
		$data->{active}		= 1
	}
	my $user = $userrs->update_or_create($data);
	$self->render(json => {created => $user->id ? \1 : \0, id => $user->id}, status => 201)
}

sub del {
	my $self	= shift;

	if($self->stash->{got_user}) {
		my $deleted = (delete $self->stash->{got_user})->update({active => 0});
		$self->render(json => {deleted => $deleted ? \1 : \0})
	}
}

sub get {
	my $self	= shift;

	if($self->stash->{user_id} eq "self") {
		$self->stash->{got_user} = $self->stash->{user};
		$self->stash->{user_id} = $self->stash->{user}->id;
	} else {
		$self->stash->{got_user} = $self->resultset("User")->find({id => $self->stash->{user_id}, active => 1});
	}
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
