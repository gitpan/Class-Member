use strict;
use Test::Simple tests=>2;

ok( !eval( 'use Class::Member qw/member_A member_B/;' ) );

ok( $@=~m!^Please use either Class::Member::HASH or Class::Member::GLOB at (?:.*?)/Class/Member\.pm line! );

# Local Variables:
# mode: cperl
# End:
