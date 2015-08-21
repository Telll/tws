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
  size: 255

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

=head2 id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 salt

  data_type: 'char'
  is_nullable: 0
  size: 15

=head2 counter

  data_type: 'integer'
  default_value: 1024
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "username",
  { data_type => "varchar", is_nullable => 0, size => 255 },
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
  "id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "salt",
  { data_type => "char", is_nullable => 0, size => 15 },
  "counter",
  { data_type => "integer", default_value => 1024, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<username>

=over 4

=item * L</username>

=back

=cut

__PACKAGE__->add_unique_constraint("username", ["username"]);

=head1 RELATIONS

=head2 auths

Type: has_many

Related object: L<TWS::Schema::Result::Auth>

=cut

__PACKAGE__->has_many(
  "auths",
  "TWS::Schema::Result::Auth",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_has_devices

Type: has_many

Related object: L<TWS::Schema::Result::UsersHasDevice>

=cut

__PACKAGE__->has_many(
  "users_has_devices",
  "TWS::Schema::Result::UsersHasDevice",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 devices

Type: many_to_many

Composing rels: L</users_has_devices> -> device

=cut

__PACKAGE__->many_to_many("devices", "users_has_devices", "device");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-21 03:41:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wcbRT1okEyju0PJyKuAKEg


# You can replace this text with custom code or comments, and it will be preserved on regeneration

use Digest::SHA1  qw(sha1_hex);
my $counter;

sub _login {
	my $self = shift;
	my $seed = join " ", localtime time, $self, $$, $counter++, map {int rand() * 10000} 0 .. rand() * 10;
	$self->create_related(auths => {auth_key => sha1_hex $seed})
}

1;
