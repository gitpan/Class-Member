#!/bin/bash

(perldoc -tU ./lib/Class/Member.pm
 perldoc -tU $0
) >README

exit 0

=head1 INSTALLATION

 perl Makefile.PL
 make
 make test
 make install

=head1 DEPENDENCIES

None.

=cut