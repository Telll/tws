use utf8;
package TWS::Schema::Result::Auth;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::Auth

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

=head1 TABLE: C<auth>

=cut

__PACKAGE__->table("auth");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 auth_key

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 login

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 device

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 logout

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "auth_key",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "login",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "device",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "logout",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=item * L</auth_key>

=back

=cut

__PACKAGE__->set_primary_key("id", "auth_key");

=head1 UNIQUE CONSTRAINTS

=head2 C<id>

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->add_unique_constraint("id", ["id"]);

=head1 RELATIONS

=head2 device

Type: belongs_to

Related object: L<TWS::Schema::Result::Device>

=cut

__PACKAGE__->belongs_to(
  "device",
  "TWS::Schema::Result::Device",
  { id => "device" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-30 03:38:38
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iXUFppk7MYshPVacSxXn3Q

# You can replace this text with custom code or comments, and it will be preserved on regeneration

1;
