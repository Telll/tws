use utf8;
package TWS::Schema::Result::Auth;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::Auth

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

=head1 TABLE: C<auth>

=cut

__PACKAGE__->table("auth");

=head1 ACCESSORS

=head2 idauth

  data_type: 'integer'
  is_nullable: 0

=head2 auth_key

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 time

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 users_idusers

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "idauth",
  { data_type => "integer", is_nullable => 0 },
  "auth_key",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "time",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  "users_idusers",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</idauth>

=item * L</auth_key>

=back

=cut

__PACKAGE__->set_primary_key("idauth", "auth_key");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-01 04:41:38
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:BDVfbSEggHJTbql05HBO9w

__PACKAGE__->belongs_to(users_idusers => "TWS::Schema::Result::User");

# You can replace this text with custom code or comments, and it will be preserved on regeneration

__PACKAGE__->belongs_to(users_idusers => "TWS::Schema::Result::User");

sub user {
	shift()->users_idusers
}

1;
