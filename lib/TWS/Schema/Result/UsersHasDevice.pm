use utf8;
package TWS::Schema::Result::UsersHasDevice;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::UsersHasDevice

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

=head1 TABLE: C<users_has_devices>

=cut

__PACKAGE__->table("users_has_devices");

=head1 ACCESSORS

=head2 users_idusers

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 devices_iddevices

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "users_idusers",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "devices_iddevices",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</users_idusers>

=item * L</devices_iddevices>

=back

=cut

__PACKAGE__->set_primary_key("users_idusers", "devices_iddevices");

=head1 RELATIONS

=head2 devices_iddevice

Type: belongs_to

Related object: L<TWS::Schema::Result::Device>

=cut

__PACKAGE__->belongs_to(
  "devices_iddevice",
  "TWS::Schema::Result::Device",
  { iddevices => "devices_iddevices" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 users_iduser

Type: belongs_to

Related object: L<TWS::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "users_iduser",
  "TWS::Schema::Result::User",
  { idusers => "users_idusers" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-01 00:27:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wM+CyoGj413yKvB2ARwkQA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
