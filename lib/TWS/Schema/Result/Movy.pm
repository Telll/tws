use utf8;
package TWS::Schema::Result::Movy;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::Movy

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

=head1 TABLE: C<movies>

=cut

__PACKAGE__->table("movies");

=head1 ACCESSORS

=head2 idmovies

  data_type: 'integer'
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 description

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 url

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 player

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "idmovies",
  { data_type => "integer", is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "url",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "player",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);

=head1 PRIMARY KEY

=over 4

=item * L</idmovies>

=back

=cut

__PACKAGE__->set_primary_key("idmovies");

=head1 RELATIONS

=head2 photolinks

Type: has_many

Related object: L<TWS::Schema::Result::Photolink>

=cut

__PACKAGE__->has_many(
  "photolinks",
  "TWS::Schema::Result::Photolink",
  { "foreign.movies_idmovies" => "self.idmovies" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-01 00:27:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hkP3QkIGifBBY3X8qFPegQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub movie_data {
	my $self = shift;

	{
		id		=> $self->id,
		title		=> $self->title,
		description	=> $self->description,
	}
}

1;
