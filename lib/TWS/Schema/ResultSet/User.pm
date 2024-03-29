package TWS::Schema::ResultSet::User;

use strict;
use warnings;
use Digest::SHA1  qw(sha1_hex);

use base 'DBIx::Class::ResultSet';

sub authenticate {
	my $self	= shift;
	my $user	= shift;
	my $password	= shift;

	my $user_obj	= $self->find({username => $user, active => 1});
	return if not defined $user_obj or not $user_obj->active;
	my $hpwd	= $self->hashfy_password($password, $user_obj->counter, $user_obj->salt);
	return $user_obj if $hpwd eq $user_obj->password;
	undef
}

sub hashfy_password {
	my $self	= shift;
	my $password	= shift;
	my $counter	= shift;
	my $salt	= shift;

	my $pass = $password . $salt;
	$pass = sha1_hex $pass for 1 .. $counter;
	$pass
}

sub generate_salt {
	join "", map { $a = "a"; $a++ for 1 .. rand() * 25; $a} 0 .. 14
}

42
