#!/usr/bin/perl
use utf8;
use open qw(:std :utf8);
die "usage: $0 [num...]\n" unless @ARGV;
print(chr) for @ARGV;
print "\n";
