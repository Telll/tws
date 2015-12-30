use utf8;
package TWS::Schema::Result::MojoPubsubSubscribe;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::MojoPubsubSubscribe

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

=head1 TABLE: C<mojo_pubsub_subscribe>

=cut

__PACKAGE__->table("mojo_pubsub_subscribe");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 pid

  data_type: 'integer'
  is_nullable: 0

=head2 channel

  data_type: 'varchar'
  is_nullable: 0
  size: 64

=head2 ts

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "pid",
  { data_type => "integer", is_nullable => 0 },
  "channel",
  { data_type => "varchar", is_nullable => 0, size => 64 },
  "ts",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<subs_idx>

=over 4

=item * L</pid>

=item * L</channel>

=back

=cut

__PACKAGE__->add_unique_constraint("subs_idx", ["pid", "channel"]);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-11-28 23:28:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7AZQOBRYV5F+oX2Ufbj28Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
