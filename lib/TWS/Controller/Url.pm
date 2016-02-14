package TWS::Controller::Url;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::JSON qw(decode_json encode_json);

use TWS::Controller::Api;
use TWS::Controller::Session;

my $delimiter = "$///" . ("-" x 10) . "//";

my $api		= TWS::Controller::Api->new;
my $session	= TWS::Controller::Session->new;

sub create {
	my $self	= shift;
	my $data	= $self->req->json;

	my $url = $self->stash->{got_photolink}->create_related(urls => $data);
	warn "url: $url; url id: ", $url->{id}, $/;
	$self->render(json => {created => $url->{id} ? \1 : \0, photolink_id => $self->stash->{got_photolink}->{id}, id => $url->{id}})
}

sub get {
	my $self	= shift;

	$self->stash->{got_url} = $self->stash->{got_photolink}->find_related($self->stash->{url});
	if(defined $self->stash->{got_url}) {
		$self->render(json => $self->stash->{got_url}->data);
		return 1;
	}
	$self->render(json => {error => [{message => "Url not found"}]}, status => 404);
	undef
}

sub delete {
	my $self = shift;

	my $deleted = $self->stash->{got_url}->delete;
	$self->render(json => {deleted => $deleted ? \1 : \0})
}

42
