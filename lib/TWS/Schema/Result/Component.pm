use utf8;
package TWS::Schema::Result::Component;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::Component

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

=head1 TABLE: C<components>

=cut

__PACKAGE__->table("components");

=head1 ACCESSORS

=head2 idcomponents

  data_type: 'integer'
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 href

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 doc

  data_type: 'longtext'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "idcomponents",
  { data_type => "integer", is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "href",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "doc",
  { data_type => "longtext", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</idcomponents>

=back

=cut

__PACKAGE__->set_primary_key("idcomponents");

=head1 RELATIONS

=head2 code_datas

Type: has_many

Related object: L<TWS::Schema::Result::CodeData>

=cut

__PACKAGE__->has_many(
  "code_datas",
  "TWS::Schema::Result::CodeData",
  { "foreign.components_idcomponents" => "self.idcomponents" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-01 00:27:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sI+lpmxibXNROUnA9s4wLw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
