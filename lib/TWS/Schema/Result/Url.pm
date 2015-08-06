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

=cut

__PACKAGE__->add_columns(
  "idurls",
  { data_type => "integer", is_nullable => 0 },
  "href",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "value",
  { data_type => "decimal", is_nullable => 1, size => [2, 0] },
);

=head1 PRIMARY KEY

=over 4

=item * L</idurls>

=back

=cut

__PACKAGE__->set_primary_key("idurls");

=head1 RELATIONS

=head2 photolinks

Type: has_many

Related object: L<TWS::Schema::Result::Photolink>

=cut

__PACKAGE__->has_many(
  "photolinks",
  "TWS::Schema::Result::Photolink",
  { "foreign.urls_idurls" => "self.idurls" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-01 00:27:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1WAIoBfVrFBS2g8k0QhF2w


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub data {
	my $self	= shift;
	{
		title	=> "NYI",
		rel 	=> "NYI",
		href	=> $self->value,
	}
}
1;
