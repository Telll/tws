package TWS::Controller::Session;
use Mojo::Base 'Mojolicious::Controller';

sub login {
	my $self	= shift;

	my $data	= $self->req->json	// {};

	my $user	= $data->{user_name}	// return $self->render(status => 400, json => {error => "Please provide username."});

	my $password	= $data->{password}	// return $self->render(status => 400, json => {error => "Please provide password."});

	my $user = $self->resultset("User")->authenticate($user, $password);
	$self->stash->{user} = $user;

	if(not $self->stash->{device}) {
		$self->stash->{device} = $user->create_related(devices => {model => 1})
	}

	my $auth = $user->generate_token;
	$self->stash->{device}->create_related(auths => {auth_key => $auth});
	return $self->render(status => 401, json => {error => "Incorrect username or password."}) if not defined $auth;

	$self->render(json => {auth_key => $auth});
}

sub logout {
	my $self	= shift;
	my $auth_key	= $self->req->headers->header("X-Auth-Key");

	my $deleted = 0;
	if(my $auth = $self->validate_auth_key($auth_key)) {
		$auth->update({logout => \"now()"});
		$deleted = 1;
	}
	return $self->render(json => {logout => \$deleted});
}

sub verify {
	my $self = shift;

	my $auth_key		= $self->req->headers->header("X-Auth-Key");
	if(not $auth_key) {
		$auth_key = $self->stash->{auth_key};
	}
	my $authenticated	= $self->validate_auth_key($auth_key);
	if(not $authenticated) {
		$self->render(status => 401, json => {error => "Invalid auth key."});
		return undef;
	}
	return $authenticated
}

42
