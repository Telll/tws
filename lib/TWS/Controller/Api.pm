package TWS::Controller::Api;
use Mojo::Base 'Mojolicious::Controller';

sub validate {
	my $self	= shift;
	my $api_key	= shift // $self->req->headers->header("X-API-Key");

	return 1 if defined $self->tx and $self->tx->req->method eq "OPTIONS";

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
