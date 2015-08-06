use utf8;
package TWS::Schema::Result::Photolink;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::Photolink

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

=head1 TABLE: C<photolinks>

=cut

__PACKAGE__->table("photolinks");

=head1 ACCESSORS

=head2 idphotolinks

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

=head2 mediatype

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 url

  data_type: 'integer'
  is_nullable: 1

=head2 urls_idurls

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 movies_idmovies

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "idphotolinks",
  { data_type => "integer", is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "mediatype",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "url",
  { data_type => "integer", is_nullable => 1 },
  "urls_idurls",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "movies_idmovies",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</idphotolinks>

=item * L</movies_idmovies>

=back

=cut

__PACKAGE__->set_primary_key("idphotolinks", "movies_idmovies");

=head1 RELATIONS

=head2 clicks

Type: has_many

Related object: L<TWS::Schema::Result::Click>

=cut

__PACKAGE__->has_many(
  "clicks",
  "TWS::Schema::Result::Click",
  { "foreign.photolinks_idphotolinks" => "self.idphotolinks" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 movies_idmovy

Type: belongs_to

Related object: L<TWS::Schema::Result::Movy>

=cut

__PACKAGE__->belongs_to(
  "movies_idmovy",
  "TWS::Schema::Result::Movy",
  { idmovies => "movies_idmovies" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 trackmotions

Type: has_many

Related object: L<TWS::Schema::Result::Trackmotion>

=cut

__PACKAGE__->has_many(
  "trackmotions",
  "TWS::Schema::Result::Trackmotion",
  { "foreign.photolinks_idphotolinks" => "self.idphotolinks" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 urls_idurl

Type: belongs_to

Related object: L<TWS::Schema::Result::Url>

=cut

__PACKAGE__->belongs_to(
  "urls_idurl",
  "TWS::Schema::Result::Url",
  { idurls => "urls_idurls" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-01 00:27:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:V1gTBZo8M2kWrY0sUqbgZQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub link { shift()->urls_idurl }

sub data {
	my $self	= shift;

	{
		id		=> $self->idphotolinks,
		category	=> "NYI",
		title		=> $self->title,
		description	=> $self->description,
		role		=> "NYI",
		sponsor		=> "NYI",
		media		=> {
			type		=> "jpg",
			url		=> "http://www.telll.me/images/necklace.jpg"
		},
		link		=> $self->link->data
	}
}

1;