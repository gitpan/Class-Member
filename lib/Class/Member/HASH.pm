package Class::Member::HASH;

use strict;
our $VERSION='1.2a';

use Carp 'confess';

sub import {
  my $pack=shift;
  ($pack)=caller;

  my $getset=sub : lvalue {
    my $I=shift;
    my $what=shift;
    unless( UNIVERSAL::isa( $I, 'HASH' ) ) {
      confess "$pack\::$what must be called as instance method\n";
    }
    $what=$pack.'::'.$what;
    if( $#_>=0 ) {
      $I->{$what}=shift;
    }
    $I->{$what};
  };

  foreach my $name (@_) {
    no strict 'refs';
    *{$pack.'::'.$name}=sub:lvalue {my $I=shift; &{$getset}( $I, $name, @_ );};
  }
}

1;

__END__

=head1 NAME

Class::Member::HASH - A module to make the module developement easier

=head1 SYNOPSIS

 package MyModule;
 use Class::Member::HASH qw/member_A member_B/;

=head1 DESCRIPTION

See L<Class::Member>.

=head1 AUTHOR

Torsten Förtsch E<lt>Torsten.Foertsch@gmx.netE<gt>

=head1 COPYRIGHT

Copyright 2003 Torsten Förtsch.

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
