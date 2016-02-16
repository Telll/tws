package TWS::Controller::Photolink;
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

	my $photolink = $self->resultset("Photolink")->create($data);
	$self->render(json => {created => $photolink->id ? \1 : \0, id => $photolink->id})
}

sub get {
	my $self	= shift;

	$self->stash->{got_photolink} = $self->resultset("Photolink")->find($self->stash->{photolink_id});
	if(defined $self->stash->{got_photolink}) {
		$self->render(json => $self->stash->{got_photolink}->data);
		return 1;
	}
	$self->render(json => {error => [{message => "Photolink not found"}]}, status => 404);
	undef
}

sub delete {
	my $self = shift;

	my $deleted = $self->stash->{got_photolink}->delete;
	$self->render(json => {deleted => !!$deleted})
}

sub follow {
	my $self = shift;

	my $link = $self->stash->{got_photolink}->{link};
	$self->render(json => {redirect => $link})
}

42
