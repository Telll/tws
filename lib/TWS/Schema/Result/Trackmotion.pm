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

=head2 thumb

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 movie

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_foreign_key: 1
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
  "thumb",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "movie",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
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


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-09-23 02:12:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RVSXFz6ApmbomOB5d9iYKw


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub redirect {
	my $self	= shift;
	my $user	= shift;

	$self->photolink->create_related(redirects => {user => $user->id, movie => $self->movie->id, redirect_to => $self->photolink->href, price => 100})
}

sub data {
	my $self	= shift;
	my @include	= @_;
	my $show_pl	= map {(split /\./, $_, 2)[1]} grep {/^photolink\b/} @include if @include;

	{
		points		=> [ map {$_->data} $self->points ],
		photolink	=> (defined $show_pl ? $self->photolink->data($show_pl) : $self->photolink->id)
	}
}

1;


__DATA__

@@ trackmotion.schema.json

{
	"title": "Track Motion",
	"type": "object",
	"required": ["movie"],
	"properties": {
		"movie": {
			"title":	"Movie ID",
			"type":		"integer",
			"minimum":	0
		},
		"points": {
			"type": "array",
			"items": {
				"title": "point",
				"type": "object",
				"required": ["x", "y", "t"],
				"properties": {
					"x":	{
						"type":	"number",
						"minimum": 0
					},
					"y":	{
						"type":	"number",
						"minimum": 0
					},
					"z":	{
						"type":	"number",
						"minimum": 0
					},
					"t":	{
						"type":	"number",
						"minimum": 0
					}
				}
			}
		}
	}
}
