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
		movie		=> 0,
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
		movie		=> 0,
		title		=> 'x' x 100,
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
		description	=> 'Vudcu vol dafegjoz giwu bakodaj tapagzaz emi ru ep jagud so alavun palgoin uvoru zop.'
	}
)
	->status_is(400)
	->json_is("/errors/0/message"	=> "String is too long: 50/45.")
	->json_is("/errors/0/path"	=> "/mediatype")
;

my $pl = {
	mediatype	=> 'sDpoU7FhjCVcUKgdr7DKyHlXeKEMJKhA',
	title		=> 'Re tukeku go at.',
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
		"X-Auth-Key"	=> $token,
		"X-API-Key"	=> "123",
	}
)
	->status_is(200)
	->json_has('/sponsor')
	->json_has('/category')
	->json_has('/id' => qr/^\d+$/)
	->json_has('/role')
	->json_is('/description' => $pl->{description})
	->json_is('/title' => $pl->{title})
;

$t->post_ok("/app/photolink/$plid/track_motion",
	{
		"X-Auth-Key"	=> $token,
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
		"X-Auth-Key"	=> $token,
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

my $tid = $t->tx->res->json->{id};

$t->get_ok("/app/track_motion/$tid?include=photolink",
	{
		"X-Auth-Key"	=> $token,
		"X-API-Key"	=> "123",
	}
)
	->status_is(200)
	->json_is('/photolink/sponsor' => 'NYI')
	->json_is('/photolink/role' => 'NYI')
	->json_is('/photolink/category' => 'NYI')
	->json_is('/photolink/title' => 'Re tukeku go at.')
	->json_is('/photolink/description' => 'Vudcu vol dafegjoz giwu bakodaj tapagzaz emi ru ep jagud so alavun palgoin uvoru zop.')
	->json_is('/photolink/id' => $plid)
	->json_is('/points/0/x' => 1)
	->json_is('/points/0/y' => 2)
	->json_is('/points/0/t' => 1)
	->json_is('/points/1/x' => 2)
	->json_is('/points/1/y' => 3)
	->json_is('/points/1/t' => 1.1)
;

done_testing();
