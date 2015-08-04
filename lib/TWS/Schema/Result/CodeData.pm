use utf8;
package TWS::Schema::Result::CodeData;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::CodeData

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

=head1 TABLE: C<code_data>

=cut

__PACKAGE__->table("code_data");

=head1 ACCESSORS

=head2 idcode_data

  data_type: 'integer'
  is_nullable: 0

=head2 datatype

  data_type: 'varchar'
  is_nullable: 0
  size: 45

=head2 dataid

  data_type: 'integer'
  is_nullable: 0

=head2 components_idcomponents

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "idcode_data",
  { data_type => "integer", is_nullable => 0 },
  "datatype",
  { data_type => "varchar", is_nullable => 0, size => 45 },
  "dataid",
  { data_type => "integer", is_nullable => 0 },
  "components_idcomponents",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</idcode_data>

=item * L</components_idcomponents>

=back

=cut

__PACKAGE__->set_primary_key("idcode_data", "components_idcomponents");

=head1 RELATIONS

=head2 components_idcomponent

Type: belongs_to

Related object: L<TWS::Schema::Result::Component>

=cut

__PACKAGE__->belongs_to(
  "components_idcomponent",
  "TWS::Schema::Result::Component",
  { idcomponents => "components_idcomponents" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-01 00:27:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0l1w5Jg+mttq5QRI9HfUaQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
