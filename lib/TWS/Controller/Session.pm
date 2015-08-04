package TWS::Controller::Session;
use Mojo::Base 'Mojolicious::Controller';

sub login {
	print"login$/";
	my $self	= shift;

	my $data	= $self->req->json
		// {};

	my $user	= $data->{user_name}
		// return $self->render(status => 400, json => {error => "Please provide username."});

	my $password	= $data->{password}
		// return $self->render(status => 400, json => {error => "Please provide password."});

	my $auth = $self->user_login($user, $password);
	use Data::Dumper; print Dumper $auth;
	return $self->render(status => 401, json => {error => "Incorrect username or password."}) if not defined $auth;

	$self->render(json => {auth_key => $auth->auth_key});
}

sub verify {
	my $self = shift;

	my $auth_key		= $self->req->headers->header("X-Auth-Key");
	my $authenticated	= $self->validate_auth_key($auth_key);
	if(not $authenticated) {
		print "not authenticated$/";
		$self->render(status => 401, json => {error => "Invalid auth key."});
		return undef;
	}
	return $authenticated
}

42
