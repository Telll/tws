use utf8;
package TWS::Schema::Result::Provider;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::Provider

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

=head1 TABLE: C<providers>

=cut

__PACKAGE__->table("providers");

=head1 ACCESSORS

=head2 idproviders

  data_type: 'integer'
  is_nullable: 0

=head2 level

  data_type: 'integer'
  is_nullable: 1

=head2 avatar

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "idproviders",
  { data_type => "integer", is_nullable => 0 },
  "level",
  { data_type => "integer", is_nullable => 1 },
  "avatar",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</idproviders>

=back

=cut

__PACKAGE__->set_primary_key("idproviders");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-01 04:41:38
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7V5e4pnWGUJsx0Sp5WVDeQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
