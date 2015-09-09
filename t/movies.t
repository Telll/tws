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

my $movie = {
	"title"		=> "Teste sjNHTFnmi2AEkp37rijy0DURfan80c81",
	"description"	=> "WteILQMl0ejlvGlgSB2OfBOiUUEfKEHwcpCMtCMiFI1u0ebaUIveejP5F7fAw6xcN1SnqHjLsDifi3mB",
};

$t->post_ok('/app/movie',
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	},
	json => $movie,
)
	->status_is(201)
	->json_is("/created"	=> 1)
	->json_like("/id"	=> qr/^\d+$/)
;

my $movie_id = $t->tx->res->json->{id};

$t->get_ok("/app/movie/$movie_id",
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	}
)
	->status_is(200)
	->json_is("/title" => $movie->{title})
	->json_is("/description" => $movie->{description})
;

$t->delete_ok("/app/movie/$movie_id",
	{
		"X-API-Key"	=> "1234",
		"X-Auth-Key"	=> $token,
	}
)
	->status_is(200)
	->json_is("/deleted" => 1)
;

#$t->get_ok("/app/movie/$movie_id/photolinks",
#	{
#		"X-API-Key"	=> "1234",
#		"X-Auth-Key"	=> $token,
#	}
#)

$movie_id = 0;
$t->get_ok("/app/movie/$movie_id/photolinks",
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
