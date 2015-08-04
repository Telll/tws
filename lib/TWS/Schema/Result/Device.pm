use utf8;
package TWS::Schema::Result::Device;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::Device

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

=head1 TABLE: C<devices>

=cut

__PACKAGE__->table("devices");

=head1 ACCESSORS

=head2 iddevices

  data_type: 'integer'
  is_nullable: 0

=head2 os

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 model

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 number

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 cache

  data_type: 'blob'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "iddevices",
  { data_type => "integer", is_nullable => 0 },
  "os",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "model",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "number",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "cache",
  { data_type => "blob", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</iddevices>

=back

=cut

__PACKAGE__->set_primary_key("iddevices");

=head1 RELATIONS

=head2 clicks

Type: has_many

Related object: L<TWS::Schema::Result::Click>

=cut

__PACKAGE__->has_many(
  "clicks",
  "TWS::Schema::Result::Click",
  { "foreign.devices_iddevices" => "self.iddevices" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_has_devices

Type: has_many

Related object: L<TWS::Schema::Result::UsersHasDevice>

=cut

__PACKAGE__->has_many(
  "users_has_devices",
  "TWS::Schema::Result::UsersHasDevice",
  { "foreign.devices_iddevices" => "self.iddevices" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_idusers

Type: many_to_many

Composing rels: L</users_has_devices> -> users_iduser

=cut

__PACKAGE__->many_to_many("users_idusers", "users_has_devices", "users_iduser");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-01 00:27:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:W+dmd2YDQET4ADaWKmw1dw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
