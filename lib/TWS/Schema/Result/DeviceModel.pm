use utf8;
package TWS::Schema::Result::DeviceModel;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::DeviceModel

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

=head1 TABLE: C<device_models>

=cut

__PACKAGE__->table("device_models");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 50 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<name>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("name", ["name"]);

=head1 RELATIONS

=head2 devices

Type: has_many

Related object: L<TWS::Schema::Result::Device>

=cut

__PACKAGE__->has_many(
  "devices",
  "TWS::Schema::Result::Device",
  { "foreign.model" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-30 01:44:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:VvB4mDBOM0xqfem8A+IxGg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
