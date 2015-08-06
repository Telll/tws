use utf8;
package TWS::Schema::Result::Point;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::Point

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

=head1 TABLE: C<points>

=cut

__PACKAGE__->table("points");

=head1 ACCESSORS

=head2 idpaths

  data_type: 'integer'
  is_nullable: 0

=head2 x

  data_type: 'integer'
  is_nullable: 1

=head2 y

  data_type: 'integer'
  is_nullable: 1

=head2 t

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 idtrackmotions

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "idpaths",
  { data_type => "integer", is_nullable => 0 },
  "x",
  { data_type => "integer", is_nullable => 1 },
  "y",
  { data_type => "integer", is_nullable => 1 },
  "t",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "idtrackmotions",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</idpaths>

=back

=cut

__PACKAGE__->set_primary_key("idpaths");

=head1 RELATIONS

=head2 idtrackmotion

Type: belongs_to

Related object: L<TWS::Schema::Result::Trackmotion>

=cut

__PACKAGE__->belongs_to(
  "idtrackmotion",
  "TWS::Schema::Result::Trackmotion",
  { idtrackmotions => "idtrackmotions" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-01 00:27:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:D09ewYWvgjGxGKyPmn4p4A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
