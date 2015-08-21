use utf8;
package TWS::Schema::Result::Thumb;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::Thumb

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

=head1 TABLE: C<thumbs>

=cut

__PACKAGE__->table("thumbs");

=head1 ACCESSORS

=head2 idthumbs

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 path

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "idthumbs",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "path",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</idthumbs>

=back

=cut

__PACKAGE__->set_primary_key("idthumbs");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-15 01:05:22
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UQvYkhwVCiGarV/RICZ4+Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
