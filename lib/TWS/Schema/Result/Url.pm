use utf8;
package TWS::Schema::Result::Url;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::Url

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

=head1 TABLE: C<urls>

=cut

__PACKAGE__->table("urls");

=head1 ACCESSORS

=head2 idurls

  data_type: 'integer'
  is_nullable: 0

=head2 href

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 value

  data_type: 'decimal'
  is_nullable: 1
  size: [2,0]

=head2 description

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 photolinks_idphotolinks

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "idurls",
  { data_type => "integer", is_nullable => 0 },
  "href",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "value",
  { data_type => "decimal", is_nullable => 1, size => [2, 0] },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "photolinks_idphotolinks",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);

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


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-15 03:09:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:u0UIb+qVnlnjgPkbMxtLcA


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub photolink {
	shift()->photolinks_idphotolinks
}

sub data {
	my $self	= shift;
	{
		title		=> $self->title,
		description	=> $self->description,
		rel 		=> "NYI",
		url		=> $self->value,
	}
}
1;
