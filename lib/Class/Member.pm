package Class::Member;

use strict;
use vars qw/$VERSION $only_version/;
$VERSION='1.1';

BEGIN {
  die "Please use either Class::Member::HASH or Class::Member::GLOB"
    unless( $only_version );
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

=head1 DESCRIPTION

C<Class::Member> is not a useable perl module by its own. It is a set of
2 modules to make access to class member variables easier and less error
prone.

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
 $self->member_A=$new_value;	# write access

=head1 AUTHOR

Torsten Förtsch E<lt>Torsten.Foertsch@gmx.netE<gt>

=head1 SEE ALSO

L<Class::Member::HASH>, L<Class::Member::GLOB>

=head1 COPYRIGHT

Copyright 2003 Torsten Förtsch.

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
