package Class::Member;

use strict;
our $VERSION='1.2a';

use Carp 'confess';

sub import {
  my $pack=shift;
  ($pack)=caller;

  my $getset_hash=sub : lvalue {
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

  my $getset_glob=sub : lvalue {
    my $I=shift;
    my $what=shift;
    unless( UNIVERSAL::isa( $I, 'GLOB' ) ) {
      confess "$pack\::$what must be called as instance method\n";
    }
    $what=$pack.'::'.$what;
    if( $#_>=0 ) {
      ${*$I}{$what}=shift;
    }
    ${*$I}{$what};
  };

  my $getset=sub : lvalue {
    my $I=shift;
    my $name=shift;

    if( UNIVERSAL::isa( $I, 'HASH' ) ) {
      no strict 'refs';
      *{$pack.'::'.$name}=sub:lvalue {
	my $I=shift;
	&{$getset_hash}( $I, $name, @_ );
      };
    } elsif( UNIVERSAL::isa( $I, 'GLOB' ) ) {
      no strict 'refs';
      *{$pack.'::'.$name}=sub:lvalue {
	my $I=shift;
	&{$getset_glob}( $I, $name, @_ );
      };
    } else {
      confess "$pack\::$name must be called as instance method\n";
    }
    $I->$name(@_);
  };

  foreach my $name (@_) {
    no strict 'refs';
    *{$pack.'::'.$name}=sub:lvalue {my $I=shift; &{$getset}( $I, $name, @_ );};
  }
}

1;				# make require fail

__END__

=head1 NAME

Class::Member - A set of modules to make the module developement easier

=head1 SYNOPSIS

 package MyModule;
 use Class::Member::HASH qw/member_A member_B/;
 
 or
 
 package MyModule;
 use Class::Member::GLOB qw/member_A member_B/;
 
 or
 
 package MyModule;
 use Class::Member qw/member_A member_B/;
 
 or
 
 package MyModule;
 use Class::Member::Dynamic qw/member_A member_B/;

=head1 DESCRIPTION

Perl class instances are mostly blessed HASHes or GLOBs and store member
variables either as C<$self-E<gt>{membername}> or
C<${*$self}{membername}> respectively.

This is very error prone when you start to develope derived classes based
on such modules. The developer of the derived class must watch the
member variables of the base class to avoid name conflicts.

To avoid that C<Class::Member::XXX> stores member variables in its own
namespace prepending the package name to the variable name, e.g.

 package My::New::Module;

 use Class::Member::HASH qw/member_A memberB/;

will store C<member_A> as C<$self-E<gt>{'My::New::Module::member_A'}>.

To make access to these members easier it exports access functions into
the callers namespace. To access C<member_A> you simply call.

 $self->member_A;		# read access
 $self->member_A($new_value);	# write access
 $self->member_A=$new_value;	# write access (used as lvalue)

C<Class::Member::HASH> and C<Class::Member::GLOB> are used if your objects
are HASH or GLOB references. But sometimes you do not know whether your
instances are GLOBs or HASHes (Consider developement of derived classes where
the base class is likely to be changed.). In this case use C<Class::Member>
and the methods are defined at compile time to handle each type of objects,
GLOBs and HASHes. But the first access to a method redefines it according
to the actual object type. Thus, the first access will last slightly longer
but all subsequent calls are executed at the same speed as
C<Class::Member::GLOB> or C<Class::Member::HASH>.

C<Class::Member::Dynamic> is used if your objects can be GLOBs and HASHes at
the same time. The actual type is determined at each access and the
appropriate action is taken.

=head1 AUTHOR

Torsten Förtsch E<lt>Torsten.Foertsch@gmx.netE<gt>

=head1 SEE ALSO

L<Class::Member::HASH>, L<Class::Member::GLOB>, L<Class::Member::Dynamic>

=head1 COPYRIGHT

Copyright 2003 Torsten Förtsch.

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
