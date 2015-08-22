package TWS::Routes;

sub create_routes {
	my $r = shift;

	my $api = $r->under("/")->to(
		"api#validate",
		"cors.origin"		=> "*",
		"cors.credentials"	=> 1,
		"cors.headers"		=> "X-API-Key, X-Auth-Key",
		"cors.expose"		=> "X-API-Key, X-Auth-Key",
	);

	$api->post("/login")->to("session#login");
	$api->cors("/login");

	my $app = $api->under("/app")->to("session#verify");
	my $appcors = $api->under("/app");

	#$app->websocket("/photolink/:api_key/:auth_key")->to("photolink#wsconnect");
	#$appcors->cors("/photolink/:api_key/:auth_key");

	$app->post("/user")->to("user#create");
	$appcors->cors("/user")->to(
		"cors.methods"	=> "POST",
		"cors.headers"	=> "X-API-Key, X-Auth-Key, X-Device-ID",
	);

	$app->get("/photolink/lp")->to("photolink#longpolling");
	$appcors->cors("/photolink/lp")->to(
		"cors.methods"	=> "GET",
		"cors.headers"	=> "X-API-Key, X-Auth-Key, X-Device-ID",
	);

	$app->post("/photolink/send/:movie_id/:plid")->to("photolink#send_pl");
	$appcors->cors("/photolink/send/:movie_id/:plid")->to(
		"cors.methods"	=> "POST",
		"cors.headers"	=> "X-API-Key, X-Auth-Key, X-Device-ID",
	);

	$app->post("/movie")->to("movie#create");
	$appcors->cors("/movie")->to(
		"cors.methods"	=> "POST",
		"cors.headers"	=> "X-API-Key, X-Auth-Key, X-Device-ID",
	);

	my $player = $app->under("/player");
	$player->get("/movie/:movie_id")->to("movie#data");
	$appcors->under("/player")->cors("/movie/:movie_id")->to(
		"cors.methods"	=> "GET",
		"cors.headers"	=> "X-API-Key, X-Auth-Key, X-Device-ID",
	);
}

42
