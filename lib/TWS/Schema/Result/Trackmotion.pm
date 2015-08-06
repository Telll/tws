use utf8;
package TWS::Schema::Result::Trackmotion;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::Trackmotion

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

=head1 TABLE: C<trackmotions>

=cut

__PACKAGE__->table("trackmotions");

=head1 ACCESSORS

=head2 photolinks_idphotolinks

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 idtrackmotions

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "photolinks_idphotolinks",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "idtrackmotions",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</idtrackmotions>

=back

=cut

__PACKAGE__->set_primary_key("idtrackmotions");

=head1 RELATIONS

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

=head2 points

Type: has_many

Related object: L<TWS::Schema::Result::Point>

=cut

__PACKAGE__->has_many(
  "points",
  "TWS::Schema::Result::Point",
  { "foreign.idtrackmotions" => "self.idtrackmotions" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-01 00:27:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ckH0HKj385ZkG6jGulmvWg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
