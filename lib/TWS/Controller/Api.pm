package TWS::Controller::Api;
use Mojo::Base 'Mojolicious::Controller';

sub validate {
	my $self	= shift;
	my $api_key	= $self->req->headers->header("X-API-Key");
	my $device_id	= $self->req->headers->header("X-Device-ID");

	return 1 if $self->tx->req->method eq "OPTIONS";

	$self->stash->{device} = $self->resultset("Device")->find($device_id);

	if(not $api_key) {
		$api_key = $self->stash->{api_key};
	}
	if(not defined $api_key) {
		$self->render(status => 403, json => {error => "API key is missing."});
	} elsif(not $self->validate_api_key($api_key)) {
		$self->render(status => 401, json => {error => "Invalid API key."});
	} else {
		$self->stash->{api_key} = $api_key;
		return 1
	}
	return undef;
}

42
