use utf8;
package TWS::Schema::Result::MojoPubsubNotify;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::MojoPubsubNotify

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

=head1 TABLE: C<mojo_pubsub_notify>

=cut

__PACKAGE__->table("mojo_pubsub_notify");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 channel

  data_type: 'varchar'
  is_nullable: 0
  size: 64

=head2 payload

  data_type: 'text'
  is_nullable: 1

=head2 ts

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "channel",
  { data_type => "varchar", is_nullable => 0, size => 64 },
  "payload",
  { data_type => "text", is_nullable => 1 },
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


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-11-28 23:28:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zplhInJQO+nT67P3pbnSAw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
