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

=head2 id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 x

  data_type: 'integer'
  is_nullable: 1

=head2 y

  data_type: 'integer'
  is_nullable: 1

=head2 t

  data_type: 'double precision'
  is_nullable: 0

=head2 trackmotion

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
  "x",
  { data_type => "integer", is_nullable => 1 },
  "y",
  { data_type => "integer", is_nullable => 1 },
  "t",
  { data_type => "double precision", is_nullable => 0 },
  "trackmotion",
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

=head2 trackmotion

Type: belongs_to

Related object: L<TWS::Schema::Result::Trackmotion>

=cut

__PACKAGE__->belongs_to(
  "trackmotion",
  "TWS::Schema::Result::Trackmotion",
  { id => "trackmotion" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-09-05 03:03:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ZIiD4n8YZzQS4R/cpIw2/g


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub data {
	my $self = shift;
	{
		x	=> $self->x,
		y	=> $self->y,
		t	=> $self->t,
	}
}

1;

__DATA__

@@point.schema.json

{
	"title": "Point",
	"type": "object",
	"required": ["x", "y", "t"],
	"properties": {
		"x":	{
			"type":	"number",
			"minimum": 0
		},
		"y":	{
			"type":	"number",
			"minimum": 0
		},
		"z":	{
			"type":	"number",
			"minimum": 0
		},
		"t":	{
			"type":	"number",
			"minimum": 0
		}
	}
}
