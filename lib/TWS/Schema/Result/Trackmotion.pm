use utf8;
package TWS::Schema::Result::Trackmotion;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::Trackmotion

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

=head1 TABLE: C<trackmotions>

=cut

__PACKAGE__->table("trackmotions");

=head1 ACCESSORS

=head2 photolink

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "photolink",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
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

=head2 points

Type: has_many

Related object: L<TWS::Schema::Result::Point>

=cut

__PACKAGE__->has_many(
  "points",
  "TWS::Schema::Result::Point",
  { "foreign.trackmotion" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-09-03 01:56:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wvwy4uLMwlNTQUjK8oYhyQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub data {
	my $self = shift;

	{
		points		=> [ map {$_->data} $self->points ],
		photolink	=> $self->photolink->id
	}
}

1;
