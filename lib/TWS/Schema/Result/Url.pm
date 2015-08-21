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

=head2 id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
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

=head2 photolink

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "href",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "value",
  { data_type => "decimal", is_nullable => 1, size => [2, 0] },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "photolink",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<id>

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->add_unique_constraint("id", ["id"]);

=head1 RELATIONS

=head2 photolink

Type: belongs_to

Related object: L<TWS::Schema::Result::Photolink>

=cut

__PACKAGE__->belongs_to(
  "photolink",
  "TWS::Schema::Result::Photolink",
  { id => "photolink" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-20 02:43:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FnDrn+XSDVTPACDvYLR/FA


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub data {
	my $self	= shift;
	{
		title		=> $self->title,
		description	=> $self->description,
		rel 		=> "NYI",
		url		=> $self->href,
	}
}
1;
