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

=head2 movie

  data_type: 'bigint'
  extra: {unsigned => 1}
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
  "movie",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
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

=head2 device_photolinks

Type: has_many

Related object: L<TWS::Schema::Result::DevicePhotolink>

=cut

__PACKAGE__->has_many(
  "device_photolinks",
  "TWS::Schema::Result::DevicePhotolink",
  { "foreign.photolink" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 movie

Type: belongs_to

Related object: L<TWS::Schema::Result::Movy>

=cut

__PACKAGE__->belongs_to(
  "movie",
  "TWS::Schema::Result::Movy",
  { id => "movie" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
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


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-30 04:37:17
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2UvnhvJTcu0PnjjyWQD7jw


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub links { shift()->urls }

sub click {
	my $self	= shift;
	my $device	= shift;

	return if not $device;
	$self->create_related(clicks => {device => $device->id})
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
