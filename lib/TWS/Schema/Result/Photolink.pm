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

=head2 mediatype

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 movies_idmovies

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 thumb

  data_type: 'varchar'
  is_nullable: 1
  size: 255

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
  "mediatype",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "movies_idmovies",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "thumb",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 clicks

Type: has_many

Related object: L<TWS::Schema::Result::Click>

=cut

__PACKAGE__->has_many(
  "clicks",
  "TWS::Schema::Result::Click",
  { "foreign.photolink" => "self.id" },
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

=head2 urls

Type: has_many

Related object: L<TWS::Schema::Result::Url>

=cut

__PACKAGE__->has_many(
  "urls",
  "TWS::Schema::Result::Url",
  { "foreign.photolink" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-20 02:32:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:g/zJc3BUFhwtFTtwDDTujA


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub links { shift()->urls }

sub click {
	my $self = shift;
	$self->create_related(clicks => {devices_iddevices => 0})
}

sub data {
	my $self	= shift;

	{
		id		=> $self->id,
		category	=> "NYI",
		title		=> $self->title,
		description	=> $self->description,
		thumb		=> $self->thumb,
		role		=> "NYI",
		sponsor		=> "NYI",
		media		=> {
			type		=> "jpg",
			url		=> $self->thumb,
		},
		link		=> [ map {$_->data} $self->links->all ]
	}
}

1;
