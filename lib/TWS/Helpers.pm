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

		my $auth = $self->resultset("Auth")->find({auth_key => $key, logout => undef});
		if($auth) {
			$self->stash->{device}	= $auth->device;
			$self->stash->{user}	= $self->stash->{device}->user;
			return $auth;
		}
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
}

42
