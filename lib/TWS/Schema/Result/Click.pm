use utf8;
package TWS::Schema::Result::Click;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::Click

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

=head1 TABLE: C<clicks>

=cut

__PACKAGE__->table("clicks");

=head1 ACCESSORS

=head2 idclicks

  data_type: 'integer'
  is_nullable: 0

=head2 value

  data_type: 'decimal'
  is_nullable: 1
  size: [2,0]

=head2 photolinks_idphotolinks

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 devices_iddevices

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 time

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "idclicks",
  { data_type => "integer", is_nullable => 0 },
  "value",
  { data_type => "decimal", is_nullable => 1, size => [2, 0] },
  "photolinks_idphotolinks",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "devices_iddevices",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "time",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</idclicks>

=back

=cut

__PACKAGE__->set_primary_key("idclicks");

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

=head2 photolinks_idphotolink

Type: belongs_to

Related object: L<TWS::Schema::Result::Photolink>

=cut

__PACKAGE__->belongs_to(
  "photolinks_idphotolink",
  "TWS::Schema::Result::Photolink",
  { idphotolinks => "photolinks_idphotolinks" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-01 00:27:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CRF3KyQS7acsDGcQZrt8IQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
