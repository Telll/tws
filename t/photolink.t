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
		description	=> 'Vudcu vol dafegjoz giwu bakodaj tapagzaz emi ru ep jagud so alavun palgoin uvoru zop.'
	}
)
	->status_is(200)
	->json_has("/id"	=> qr/^\d+$/)
	->json_is("/created"	=> 1)
;

done_testing();
