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

=head2 id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
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

  data_type: 'text'
  is_nullable: 1

=head2 player

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 image

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "url",
  { data_type => "text", is_nullable => 1 },
  "player",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "image",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<title>

=over 4

=item * L</title>

=back

=cut

__PACKAGE__->add_unique_constraint("title", ["title"]);

=head1 RELATIONS

=head2 redirects

Type: has_many

Related object: L<TWS::Schema::Result::Redirect>

=cut

__PACKAGE__->has_many(
  "redirects",
  "TWS::Schema::Result::Redirect",
  { "foreign.movie" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 trackmotions

Type: has_many

Related object: L<TWS::Schema::Result::Trackmotion>

=cut

__PACKAGE__->has_many(
  "trackmotions",
  "TWS::Schema::Result::Trackmotion",
  { "foreign.movie" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-12-30 03:38:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:h+oZXaYpbY6tYV9tRiN5qA


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub data {
	my $self = shift;

	{
		id		=> $self->id,
		category	=> "NYI",
		title		=> $self->title,
		description	=> $self->description,
		url		=> $self->url,
		image		=> $self->image,
		cript		=> "NYI",
		author		=> "NYI",
		media		=> {_ => "NYI"},
		player		=> {_ => "NYI"},
	}
}

1;

__DATA__

@@ movie.schema.json
{
        "title": "Movie",
        "type": "object",
        "properties": {
                "title": {
                        "type":		"string",
			"maxLength":	45
                },
                "description": {
                        "type":		"string",
			"maxLength":	255
                }
        },
        "required": ["title"]
}
