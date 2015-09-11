use utf8;
package TWS::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TWS::Schema::Result::User

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

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 username

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 create_time

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 1

=head2 id

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 salt

  data_type: 'char'
  is_nullable: 0
  size: 15

=head2 counter

  data_type: 'integer'
  default_value: 1024
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "username",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "create_time",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 1,
  },
  "id",
  {
    data_type => "bigint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "salt",
  { data_type => "char", is_nullable => 0, size => 15 },
  "counter",
  { data_type => "integer", default_value => 1024, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<username>

=over 4

=item * L</username>

=back

=cut

__PACKAGE__->add_unique_constraint("username", ["username"]);

=head1 RELATIONS

=head2 clicks

Type: has_many

Related object: L<TWS::Schema::Result::Click>

=cut

__PACKAGE__->has_many(
  "clicks",
  "TWS::Schema::Result::Click",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 devices

Type: has_many

Related object: L<TWS::Schema::Result::Device>

=cut

__PACKAGE__->has_many(
  "devices",
  "TWS::Schema::Result::Device",
  { "foreign.user" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-30 02:39:46
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cmkutPTlcUYp2mBBR0uFng


# You can replace this text with custom code or comments, and it will be preserved on regeneration

use Mojo::Util qw(sha1_sum);
my $counter;

sub generate_token {
	my $self	= shift;
	return sha1_sum join " ", localtime time, $self, $$, $counter++, map {int rand() * 10000} 0 .. rand() * 10;
}

sub data {
	my $self = shift;
	{
		username	=> $self->username,
		email		=> $self->email,
	}
}

sub photolinks {
	my $self = shift;
	map {$_->photolink} $self->search_related("devices")->search_related("clicks")->all
}

1;

__DATA__

@@ user.schema.json
{
        "title": "User",
        "type": "object",
        "properties": {
                "username": {
                        "type":		"string",
			"minLength":	3,
			"maxLength":	255
                },
                "email": {
                        "type":		"string",
			"format":	"email"
                },
                "password": {
                        "type":		"string",
			"minLength":	5
                }
        },
        "required": ["username", "email", "password"]
}
