use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('TWS');

$t->post_ok('/login',
	{"X-API-Key" => "1234"},
	json => {
		"user_name"	=> "smokemachine",
		"password"	=> "12345",
		"model"		=> "iPad",
	}
)
	->status_is(200)
	->json_like("/auth_key"	=> qr/^[\da-f]{40}$/)
	->json_like("/device"	=> qr/^\d+$/)
;

my $token = $t->tx->res->json->{auth_key};

$t->post_ok('/app/photolink',
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	},
	json => {
		mediatype	=> 'sDpoU7FhjCVcUKgdr7DKyHlXeKEMJKhA',
		title		=> 'Re tukeku go at.',
		thumb		=> 'http://rutek.edu/isunop.jpg',
		description	=> 'Vudcu vol dafegjoz giwu bakodaj tapagzaz emi ru ep jagud so alavun palgoin uvoru zop.'
	}
)
	->status_is(400)
	->json_is("/errors/0/message"	=> "Missing property.")
	->json_is("/errors/0/path"	=> "/movie")
;

$t->post_ok('/app/photolink',
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	},
	json => {
		mediatype	=> 'sDpoU7FhjCVcUKgdr7DKyHlXeKEMJKhA',
		movie		=> 0,
		thumb		=> 'http://rutek.edu/isunop.jpg',
		description	=> 'Vudcu vol dafegjoz giwu bakodaj tapagzaz emi ru ep jagud so alavun palgoin uvoru zop.'
	}
)
	->status_is(400)
	->json_is("/errors/0/message"	=> "Missing property.")
	->json_is("/errors/0/path"	=> "/title")
;

$t->post_ok('/app/photolink',
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	},
	json => {
		mediatype	=> 'sDpoU7FhjCVcUKgdr7DKyHlXeKEMJKhA',
		movie		=> 0,
		title		=> 'Re tukeku go at.',
		thumb		=> 'http://rutek.edu/isunop.jpg',
	}
)
	->status_is(400)
	->json_is("/errors/0/message"	=> "Missing property.")
	->json_is("/errors/0/path"	=> "/description")
;

$t->post_ok('/app/photolink',
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	},
	json => {
		mediatype	=> 'sDpoU7FhjCVcUKgdr7DKyHlXeKEMJKhA',
		movie		=> 'str',
		title		=> 'Re tukeku go at.',
		thumb		=> 'http://rutek.edu/isunop.jpg',
		description	=> 'Vudcu vol dafegjoz giwu bakodaj tapagzaz emi ru ep jagud so alavun palgoin uvoru zop.'
	}
)
	->status_is(400)
	->json_is("/errors/0/message"	=> "Expected integer - got string.")
	->json_is("/errors/0/path"	=> "/movie")
;

$t->post_ok('/app/photolink',
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	},
	json => {
		mediatype	=> 'sDpoU7FhjCVcUKgdr7DKyHlXeKEMJKhA',
		movie		=> 0,
		title		=> 'x' x 100,
		thumb		=> 'http://rutek.edu/isunop.jpg',
		description	=> 'Vudcu vol dafegjoz giwu bakodaj tapagzaz emi ru ep jagud so alavun palgoin uvoru zop.'
	}
)
	->status_is(400)
	->json_is("/errors/0/message"	=> "String is too long: 100/45.")
	->json_is("/errors/0/path"	=> "/title")
;

$t->post_ok('/app/photolink',
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	},
	json => {
		mediatype	=> 'sDpoU7FhjCVcUKgdr7DKyHlXeKEMJKhA',
		movie		=> 0,
		title		=> 'Re tukeku go at.',
		thumb		=> 'http://rutek.edu/isunop.jpg',
		description	=> 'x' x 500,
	}
)
	->status_is(400)
	->json_is("/errors/0/message"	=> "String is too long: 500/255.")
	->json_is("/errors/0/path"	=> "/description")
;

$t->post_ok('/app/photolink',
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	},
	json => {
		mediatype	=> 'x' x 50,
		movie		=> 0,
		title		=> 'Re tukeku go at.',
		thumb		=> 'http://rutek.edu/isunop.jpg',
		description	=> 'Vudcu vol dafegjoz giwu bakodaj tapagzaz emi ru ep jagud so alavun palgoin uvoru zop.'
	}
)
	->status_is(400)
	->json_is("/errors/0/message"	=> "String is too long: 50/45.")
	->json_is("/errors/0/path"	=> "/mediatype")
;

$t->post_ok('/app/photolink',
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	},
	json => {
		mediatype	=> 'sDpoU7FhjCVcUKgdr7DKyHlXeKEMJKhA',
		movie		=> 0,
		title		=> 'Re tukeku go at.',
		thumb		=> 'x' x 500,
		description	=> 'Vudcu vol dafegjoz giwu bakodaj tapagzaz emi ru ep jagud so alavun palgoin uvoru zop.'
	}
)
	->status_is(400)
	->json_is("/errors/0/message"	=> "String is too long: 500/255.")
	->json_is("/errors/0/path"	=> "/thumb")
;

my $pl = {
	mediatype	=> 'sDpoU7FhjCVcUKgdr7DKyHlXeKEMJKhA',
	movie		=> 0,
	title		=> 'Re tukeku go at.',
	thumb		=> 'http://rutek.edu/isunop.jpg',
	description	=> 'Vudcu vol dafegjoz giwu bakodaj tapagzaz emi ru ep jagud so alavun palgoin uvoru zop.'
};

$t->post_ok('/app/photolink',
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	},
	json => $pl,
)
	->status_is(200)
	->json_has("/id"	=> qr/^\d+$/)
	->json_is("/created"	=> 1)
;

my $plid = $t->tx->res->json->{id};

$t->get_ok("/app/photolink/$plid",
	{
		"X-Auth-Key"	=> "c6d55a1fedffc7aac357e521f8668a8ce820eb87",
		"X-API-Key"	=> "123",
	}
)
	->status_is(200)
	->json_has('/sponsor')
	->json_has('/category')
	->json_is('/thumb' => $pl->{thumb})
	->json_has('/id' => qr/^\d+$/)
	->json_has('/role')
	->json_is('/description' => $pl->{description})
	->json_has('/media/type')
	->json_has('/media/url')
	->json_is('/title' => $pl->{title})
;

$t->post_ok("/app/photolink/$plid/track_motion",
	{
		"X-Auth-Key"	=> "c6d55a1fedffc7aac357e521f8668a8ce820eb87",
		"X-API-Key"	=> "123",
	},
	json => [
		{
			x	=> "str",
			y	=> 2.0,
			t	=> 1
		},
		{
			x	=> 2.0,
			y	=> 3.0,
			t	=> 1.1
		}
	]
)
	->status_is(400)
	->json_is('/errors/0/path' => '/0/x')
	->json_is('/errors/0/message' => 'Expected number - got string.')
;

$t->post_ok("/app/photolink/$plid/track_motion",
	{
		"X-Auth-Key"	=> "c6d55a1fedffc7aac357e521f8668a8ce820eb87",
		"X-API-Key"	=> "123",
	},
	json => [
		{
			x	=> 1.0,
			y	=> 2.0,
			t	=> 1
		},
		{
			x	=> 2.0,
			y	=> 3.0,
			t	=> 1.1
		}
	]
)
	->status_is(200)
	->json_is('/created' => '1')
	->json_has('/id' => qr/^\d+$/)
;

done_testing();
