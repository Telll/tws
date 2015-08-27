package TWS::Helpers;

sub create_helpers {
	my $tws = shift;

	$tws->helper(delimiter	=> sub { shift()->app->delimiter});
	$tws->helper(db		=> sub { shift()->app->schema });
	$tws->helper(resultset	=> sub { shift()->db->resultset(shift) });

	$tws->helper(validate_api_key => sub {
		my $self	= shift;
		my $key		= shift;

		return !!$key
	});

	$tws->helper(validate_auth_key => sub {
		my $self	= shift;
		my $key		= shift;

		my $auth = $self->resultset("Auth")->find({auth_key => $key});
		if($auth) {
			$self->stash->{user} = $auth->user;
			return 1;
		}
	});

	$tws->helper(user_login => sub {
		my $self	= shift;
		my $username	= shift;
		my $password	= shift;

		my $user = $self->resultset("User")->authenticate($username, $password);
		$self->stash->{user} = $user;
		return $user->_login if $user;
		undef
	});

	$tws->helper(get_movie => sub {
		my $self	= shift;
		my $id		= shift;

		my $movie = $self->resultset("Movy")->find($id);
		return $movie if $movie;
		undef
	});

	$tws->helper(create_movie => sub {
		my $self	= shift;
		my $data	= shift;

		my $movie	= $self->resultset("Movy");
		$movie->update_or_create($data);
	});

	$tws->helper(create_user => sub {
		my $self	= shift;
		my $data	= shift;

		my $user	= $self->resultset("User");
		if(exists $data->{password}) {
			$data->{salt}		= $user->generate_salt;
			$data->{counter}	= 1024;
			$data->{password}	= $user->hashfy_password($data->{password}, $data->{counter}, $data->{salt});
		}
		$user->update_or_create($data);
	});

	$tws->helper("get_photolink" => sub {
		my $self	= shift;
		my $movie_id	= shift;
		my $plid	= shift;

		$self->resultset("Photolink")->find({movies_idmovies => $movie_id, id => $plid});
	});
}

42
