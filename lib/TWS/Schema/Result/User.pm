use utf8;
package TWS::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::User

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 username

  data_type: 'varchar'
  is_nullable: 0
  size: 16

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 create_time

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 1

=head2 idusers

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "username",
  { data_type => "varchar", is_nullable => 0, size => 16 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "create_time",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 1,
  },
  "idusers",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</idusers>

=back

=cut

__PACKAGE__->set_primary_key("idusers");

=head1 RELATIONS

=head2 users_has_devices

Type: has_many

Related object: L<TWS::Schema::Result::UsersHasDevice>

=cut

__PACKAGE__->has_many(
  "users_has_devices",
  "TWS::Schema::Result::UsersHasDevice",
  { "foreign.users_idusers" => "self.idusers" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 devices_iddevices

Type: many_to_many

Composing rels: L</users_has_devices> -> devices_iddevice

=cut

__PACKAGE__->many_to_many("devices_iddevices", "users_has_devices", "devices_iddevice");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-01 04:41:38
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qYztLEGG1AXNdlTVXcjeOA


# You can replace this text with custom code or comments, and it will be preserved on regeneration

__PACKAGE__->has_many(auths => "TWS::Schema::Result::Auth", "users_idusers");

use Digest::SHA1  qw(sha1_hex);
my $counter;

sub _login {
	my $self = shift;
	my $seed = join " ", localtime time, $self, $$, $counter++, map {int rand() * 10000} 0 .. rand() * 10;
	$self->create_related(auths => {auth_key => sha1_hex $seed})
}

1;
