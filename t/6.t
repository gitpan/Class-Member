use strict;
use Test::More tests=>4;

package My::New::Package;
use Class::Member::GLOB qw/member_A member_B  -CLASS_MEMBERS -NEW -INIT=initx/;

sub initx {
  $_[0]->member_A=42;
}

package main;

my $o=My::New::Package->new(member_B=>43);
ok( $o->member_A==42, 'member_A==42' );
ok( $o->member_B==43, 'member_B==43' );

$o->member_B++;
$o=$o->new(member_A=>12);
ok( $o->member_A==42, 'member_A==42' );
ok( $o->member_B==44, 'member_B==44' );

# Local Variables:
# mode: cperl
# End:
