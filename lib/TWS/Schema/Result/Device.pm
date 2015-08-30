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

=head2 id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 os

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

=head2 model

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 user

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "os",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "number",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "cache",
  { data_type => "blob", is_nullable => 1 },
  "model",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "user",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 auths

Type: has_many

Related object: L<TWS::Schema::Result::Auth>

=cut

__PACKAGE__->has_many(
  "auths",
  "TWS::Schema::Result::Auth",
  { "foreign.device" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 clicks

Type: has_many

Related object: L<TWS::Schema::Result::Click>

=cut

__PACKAGE__->has_many(
  "clicks",
  "TWS::Schema::Result::Click",
  { "foreign.device" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 device_photolinks

Type: has_many

Related object: L<TWS::Schema::Result::DevicePhotolink>

=cut

__PACKAGE__->has_many(
  "device_photolinks",
  "TWS::Schema::Result::DevicePhotolink",
  { "foreign.device" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 model

Type: belongs_to

Related object: L<TWS::Schema::Result::DeviceModel>

=cut

__PACKAGE__->belongs_to(
  "model",
  "TWS::Schema::Result::DeviceModel",
  { id => "model" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 user

Type: belongs_to

Related object: L<TWS::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "TWS::Schema::Result::User",
  { id => "user" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-30 04:37:17
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4X73nxKeJ6iWao7B3G+42A


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub data {
	my $self = shift;
	{
		name	=> $self->model->name,
	}
}
1;

__DATA__

@@ device.schema.json
{
        "title": "Device",
        "type": "object",
        "properties": {
                "name": {
                        "type":		"string",
			"minLength":	3
                }
        },
        "required": ["name"]
}
