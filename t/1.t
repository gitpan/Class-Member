use strict;
use Test::Simple tests=>6;

package My::New::Package;
use Class::Member::HASH qw/member_A member_B/;
use Symbol qw/gensym/;

sub new {
  bless {}=>shift;
}

package main;

my $o=My::New::Package->new;

$o->member_A='A';
ok( $o->member_A eq 'A' );

$o->member_A('B');
ok( $o->member_A eq 'B' );

$o->member_B=1;
ok( $o->member_B==1 );

$o->member_B(2);
ok( $o->member_B==2 );

ok( !eval {My::New::Package->member_A} );

ok( $@=~/^My::New::Package::member_A must be called as instance method/ );

# Local Variables:
# mode: cperl
# End:
