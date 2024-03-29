package TWS::Controller::Session;
use Mojo::Base 'Mojolicious::Controller';

sub login {
	my $self	= shift;

	my $data	= $self->req->json	// {};

	my $user_name	= $data->{user_name}	// return $self->render(status => 400, json => {error => "Please provide username."});

	my $password	= $data->{password}	// return $self->render(status => 400, json => {error => "Please provide password."});

	my $model	= $data->{model};

	if(not defined $model and not exists $self->stash->{device_id}) {
		return $self->render(status => 400, json => {error => "Please provide a model name."});
	}

	my $user = $self->resultset("User")->authenticate($user_name, $password);
	return $self->render(status => 401, json => {error => "Incorrect username or password."}) if not defined $user;

	$self->stash->{user} = $user;

	if($self->stash->{device_id}) {
		$self->stash->{device} = $self->resultset("Device")->find($self->stash->{device_id})
	} elsif(not $self->stash->{device}) {
		my $dev_model = $self->resultset("DeviceModel")->find({name => $model}) if defined $model;
		if(not $dev_model or not defined $dev_model->id) {
			$self->render(json => {error => qq/Device model not found/}, status => 400);
			return
		}
		$self->stash->{device} = $user->create_related(devices => {model => $dev_model->id})
	}

	my $auth = $user->generate_token;
	$self->stash->{device}->create_related(auths => {auth_key => $auth});

	$self->render(json => {auth_key => $auth, device => $self->stash->{device}->id});
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
	my $self	= shift;
	my $auth_key	= shift // $self->req->headers->header("X-Auth-Key");

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
