package TWS::Controller::Device;
use Mojo::Base 'Mojolicious::Controller';

sub create {
	my $self	= shift;
	my $data	= $self->req->json;

	my $device = $self->create_device($data);
	$self->render(json => {sent => $device->id ? \1 : \0})
}

sub get {
	my $self	= shift;

	$self->stash->{got_device} = $self->resultset("Device")->find($self->stash->{device_id});
	if($self->stash->{got_device}) {
		$self->render(json => $self->stash->{got_device}->data);
		return 1
	}
	$self->render(json => {error => [{message => "Device not found"}]}, status => 404);
	undef
}

sub photolinks {
	my $self	= shift;

	$self->render(json => {photolinks => [map {$_->photolink->data} $self->stash->{got_device}->device_photolinks]})
}

42
