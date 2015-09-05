use utf8;
package TWS::Schema::Result::DevicePhotolink;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::DevicePhotolink

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

=head1 TABLE: C<device_photolinks>

=cut

__PACKAGE__->table("device_photolinks");

=head1 ACCESSORS

=head2 photolink

  data_type: 'bigint'
  default_value: 0
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 device

  data_type: 'bigint'
  default_value: 0
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 sent

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "photolink",
  {
    data_type => "bigint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "device",
  {
    data_type => "bigint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "sent",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</photolink>

=item * L</device>

=back

=cut

__PACKAGE__->set_primary_key("photolink", "device");

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

=head2 photolink

Type: belongs_to

Related object: L<TWS::Schema::Result::Photolink>

=cut

__PACKAGE__->belongs_to(
  "photolink",
  "TWS::Schema::Result::Photolink",
  { id => "photolink" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-30 04:37:17
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qO6Ya9D+hkHwgY5Uh8vOlQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
