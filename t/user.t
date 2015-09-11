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

$t->post_ok('/app/user',
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	},
	json => {
		"username"	=> "smokemachine",
		"password"	=> "12345",
	},
)
	->status_is(400)
	->json_is("/errors/0/path"	=> "/email")
	->json_is("/errors/0/message"	=> "Missing property.")
;

$t->post_ok('/app/user',
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	},
	json => {
		"username"	=> "smokemachine",
		"email"		=> "a\@b.com",
	},
)
	->status_is(400)
	->json_is("/errors/0/path"	=> "/password")
	->json_is("/errors/0/message"	=> "Missing property.")
;

$t->post_ok('/app/user',
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	},
	json => {
		"username"	=> "invalid" . "x" x 500,
		"email"		=> "a\@b.com",
		"password"	=> "12345",
	},
)
	->status_is(400)
	->json_is("/errors/0/path"	=> "/username")
	->json_is("/errors/0/message"	=> "String is too long: 507/255.")
;

$t->post_ok('/app/user',
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	},
	json => {
		"username"	=> "smokemachine",
		"email"		=> "invalid",
		"password"	=> "12345",
	},
)
	->status_is(400)
	->json_is("/errors/0/path"	=> "/email")
	->json_is("/errors/0/message"	=> "Does not match email format.")
;

my $user = {
	"username"	=> "user001",
	"email"		=> "user001\@example.com",
	"password"	=> "12345",
};

$t->post_ok('/app/user',
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	},
	json => $user
)
	->status_is(201)
	->json_is("/created"	=> 1)
	->json_like("/id"	=> qr/^\d+$/)
;

my $user_id = $t->tx->res->json->{id};

$t->get_ok("/app/user/$user_id",
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	}
)
	->status_is(200)
	->json_is("/username" => $user->{username})
	->json_is("/email" => $user->{email})
;

$t->delete_ok("/app/user/$user_id",
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	}
)
	->status_is(200)
	->json_is("/deleted" => 1)
;

#$t->get_ok("/app/user/$user_id/photolinks",
#	{
#		"X-API-Key"	=> "1234",
#		"X-Auth-Key"	=> $token,
#	}
#)

$user_id = 27;
$t->get_ok("/app/user/$user_id/photolinks",
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	}
)
	->status_is(200)
	->json_has("/photolinks/0/role")
	->json_has("/photolinks/0/media")
	->json_has("/photolinks/0/media/url")
	->json_has("/photolinks/0/media/type")
	->json_has("/photolinks/0/sponsor")
	->json_has("/photolinks/0/category")
	->json_has("/photolinks/0/thumb")
	->json_has("/photolinks/0/id")
	->json_has("/photolinks/0/description")
	->json_has("/photolinks/0/title")
;

done_testing();
