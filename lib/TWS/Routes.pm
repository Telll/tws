package TWS::Routes;

sub create_routes {
	my $r = shift;
	#$r->websocket("/ws")->to("web_socket#ws");


	my $api = $r->under("/")->to(
		"api#validate",
		"cors.origin"		=> "*",
		"cors.credentials"	=> 1,
		"cors.headers"		=> "X-API-Key, X-Auth-Key",
		"cors.expose"		=> "X-API-Key, X-Auth-Key",
	);

	$api->post("/login" => [model => [qw/iPad iPhone/]])->to("session#login");
	$api->cors("/login" => [model => [qw/ipad iphone/]]);
	$api->post("/login/:device_id")->to("session#login");
	$api->cors("/login/:device_id");

	$api->delete("/login")->to("session#logout");
	$api->cors("/login");

	my $app = $api->under("/app")->to("session#verify");
	my $appcors = $api->under("/app");

	$app->post("/user")->to("user#create", "json.validator.schema" => "data://TWS::Schema::Result::User/user.schema.json");
	$appcors->cors("/user")->to(
		"cors.methods"	=> "POST",
		"cors.headers"	=> "X-API-Key, X-Auth-Key, X-Device-ID",
	);

	my $get_user = $app->under("/user/:user_id")->to("user#get");
	$get_user->get("/");
	$get_user->cors("/")->to(
		"cors.methods"	=> "get",
		"cors.headers"	=> "X-API-Key, X-Auth-Key, X-Device-ID",
	);

	$get_user->post("/")->to("user#create", "json.validator.schema" => "data://TWS::Schema::Result::User/user_edit.schema.json");
	$get_user->cors("/")->to(
		"cors.methods"	=> "post",
		"cors.headers"	=> "X-API-Key, X-Auth-Key, X-Device-ID",
	);

	$get_user->delete("/")->to("user#del");
	$get_user->cors("/")->to(
		"cors.methods"	=> "delete",
		"cors.headers"	=> "X-API-Key, X-Auth-Key, X-Device-ID",
	);

	$get_user->get("/photolinks")->to(action => "photolinks");
	$get_user->cors("/photolinks")->to(
		"cors.methods"	=> "get",
		"cors.headers"	=> "X-API-Key, X-Auth-Key, X-Device-ID",
	);

	$app->post("/device")->to("device#create", "json.validator.schema" => "data://TWS::Schema::Result::Device/device.schema.json");
	$appcors->cors("/device")->to(
		"cors.methods"	=> "POST",
		"cors.headers"	=> "X-API-Key, X-Auth-Key, X-Device-ID",
	);

	my $get_device = $app->under("/device/:device_id")->to("device#get");
	$get_device->get("/");
	$get_device->cors("/")->to(
		"cors.methods"	=> "get",
		"cors.headers"	=> "X-API-Key, X-Auth-Key, X-Device-ID",
	);

	$get_device->get("/photolinks")->to(action => "photolinks");
	$get_device->cors("/photolinks")->to(
		"cors.methods"	=> "get",
		"cors.headers"	=> "X-API-Key, X-Auth-Key, X-Device-ID",
	);

	$app->get("/photolink/lp")->to("photolink#longpolling");
	$appcors->cors("/photolink/lp")->to(
		"cors.methods"	=> "GET",
		"cors.headers"	=> "X-API-Key, X-Auth-Key, X-Device-ID",
	);

	my $movies = $app->any("/movie");
	$movies->get->to("movie#list");
	$movies->post->to("movie#create", "json.validator.schema" => "data://TWS::Schema::Result::Movy/movie.schema.json");
	$appcors->cors("/movie")->to(
		"cors.methods"	=> "post, get",
		"cors.headers"	=> "X-API-Key, X-Auth-Key, X-Device-ID",
	);

	my $get_movies = $app->under("/movie/:movie_id")->to("movie#get");
	$get_movies->delete("/")->to("movie#del");
	$get_movies->get("/");
	my $cors_movies = $appcors->cors("/movie/:movie_id")->to(
		"cors.methods"	=> "get, delete",
		"cors.headers"	=> "X-API-Key, X-Auth-Key, X-Device-ID",
	);

	$app->post("/photolink/")->to("photolink#create", "json.validator.schema" => "data://TWS::Schema::Result::Photolink/photolink.schema.json");
	my $get_pl = $app->under("/photolink/:photolink_id")->to("photolink#get");
	$get_pl->get("/");
	$get_pl->get("/follow")->to("photolink#follow");

	$get_pl->post("/track_motion")->to("track_motion#create", "json.validator.schema" => "data://TWS::Schema::Result::Trackmotion/trackmotion.schema.json");
	my $get_track_motion = $app->under("/track_motion/:track_motion_id")->to("track_motion#get");
	$get_track_motion->delete("/")->to("track_motion#del");
	$get_track_motion->get("/");
	$get_track_motion->post("/click")->to("track_motion#click");
	$get_track_motion->cors("/click")->to(
		"cors.methods"	=> "POST",
		"cors.headers"	=> "X-API-Key, X-Auth-Key",
	);
	my $cors_track_motion = $get_track_motion->cors("/")->to(
		"cors.methods"	=> "GET",
		"cors.headers"	=> "X-API-Key, X-Auth-Key",
	);
	$get_track_motion->post("/point")->to("track_motion#add_point", "json.validator.schema" => "data://TWS::Schema::Result::Point/point.schema.json");
	$get_track_motion->cors("/point")->to(
		"cors.methods"	=> "POST",
		"cors.headers"	=> "X-API-Key, X-Auth-Key",
	);

	$get_movies->get("/photolinks")->to(action => "photolinks");
	$get_movies->cors("/photolinks")->to(
		"cors.methods"	=> "GET",
		"cors.headers"	=> "X-API-Key, X-Auth-Key",
	);

	my $player = $app->under("/player");
	$player->get("/movie/:movie_id")->to("movie#data");
	$appcors->under("/player")->cors("/movie/:movie_id")->to(
		"cors.methods"	=> "GET",
		"cors.headers"	=> "X-API-Key, X-Auth-Key, X-Device-ID",
	);
}

42
