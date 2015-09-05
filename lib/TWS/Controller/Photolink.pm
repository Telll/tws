package TWS::Controller::Photolink;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::JSON qw(decode_json encode_json);
use TWS::WSCommands;

my $delimiter = "$///" . ("-" x 10) . "//";

my $clients = TWS::WSCommands->new($delimiter);

sub connectws {
	my $self	= shift;
	$clients->add($self->stash->{user}, $self);

	$self->on(message => sub {
		my $self	= shift;
		my $msg		= shift;

		my $cmd = decode_json $msg;
	});
}

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

sub longpolling {
	my $self	= shift;
	
	$self->write_chunk;

	$self->inactivity_timeout(3600);
	my $device	= $self->stash->{device};
	my $photolinkrs	= $self->resultset("Photolink");
	my $c = $self;
	my $cb = $self->app->events->on($self->stash->{user}->id => sub {
		my $self	= shift;
		my $photolink	= shift;
		my $extradata	= shift;

		if($photolink) {
			$device->update_or_create_related(device_photolinks => {photolink => $photolink->id});
			my $pldata = $photolink->data;
			$pldata->{extradata} = $extradata;
			$c->write_chunk(encode_json($pldata) . $delimiter);
		}
	});
	$self->on(finish => sub { shift->app->events->unsubscribe($self->stash->{user}->id => $cb) });
}

sub click {
	my $self	= shift;
	my $photolink	= $self->stash->{got_photolink};
	my $json	= $self->req->json;
	my $extradata	= $json->{extradata} if $json;

	$self->app->events->emit($self->stash->{user}->id => $photolink, $extradata);
	$self->render(json => {sent => \1})
}

42
