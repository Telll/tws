use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('TWS');

## Login with model
### No model
$t->post_ok('/login',
	{"X-API-Key" => "1234"},
	json => {
		"user_name"	=> "smokemachine",
		"password"	=> "12345",
	}
)
	->status_is(400)
	->json_is("/error"	=> "Please provide a model name.")
;

## No user_name
$t->post_ok('/login',
	{"X-API-Key" => "1234"},
	json => {
		"password"	=> "12345",
		"model"		=> "iPad",
	}
)
	->status_is(400)
	->json_is("/error"	=> "Please provide username.")
;

## No password
$t->post_ok('/login',
	{"X-API-Key" => "1234"},
	json => {
		"user_name"	=> "smokemachine",
		"model"		=> "iPad",
	}
)
	->status_is(400)
	->json_is("/error"	=> "Please provide password.")
;

### Invalid model
$t->post_ok('/login',
	{"X-API-Key" => "1234"},
	json => {
		"user_name"	=> "smokemachine",
		"password"	=> "12345",
		"model"		=> "invalid",
	}
)
	->status_is(400)
	->json_is("/error"	=> "Device model not found")
;

## Wrong user_name
$t->post_ok('/login',
	{"X-API-Key" => "1234"},
	json => {
		"user_name"	=> "inexistent",
		"password"	=> "12345",
		"model"		=> "iPad",
	}
)
	->status_is(401)
	->json_is("/error"	=> "Incorrect username or password.")
;

## Wrong password
$t->post_ok('/login',
	{"X-API-Key" => "1234"},
	json => {
		"user_name"	=> "smokemachine",
		"password"	=> "wrong",
		"model"		=> "iPad",
	}
)
	->status_is(401)
	->json_is("/error"	=> "Incorrect username or password.")
;


## Login device id
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
my $device = $t->tx->res->json->{device};

$t->post_ok("/login/$device",
	{"X-API-Key" => "1234"},
	json => {
		"password"	=> "12345",
	}
)
	->status_is(400)
	->json_is("/error"	=> "Please provide username.")
;

$t->post_ok("/login/$device",
	{"X-API-Key" => "1234"},
	json => {
		"user_name"	=> "smokemachine",
	}
)
	->status_is(400)
	->json_is("/error"	=> "Please provide password.")
;

$t->post_ok("/login/$device",
	{"X-API-Key" => "1234"},
	json => {
		"user_name"	=> "inextistent",
		"password"	=> "12345",
	}
)
	->status_is(401)
	->json_is("/error"	=> "Incorrect username or password.")
;

$t->post_ok("/login/$device",
	{"X-API-Key" => "1234"},
	json => {
		"user_name"	=> "smokemachine",
		"password"	=> "wrong",
	}
)
	->status_is(401)
	->json_is("/error"	=> "Incorrect username or password.")
;

$t->post_ok("/login/$device",
	{"X-API-Key" => "1234"},
	json => {
		"user_name"	=> "smokemachine",
		"password"	=> "12345",
	}
)
	->status_is(200)
	->json_like("/auth_key"	=> qr/^[\da-f]{40}$/)
	->json_is("/device"	=> $device)
;

done_testing();
