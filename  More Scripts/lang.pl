#!/usr/bin/perl -l
use utf8;
use open qw(:std :utf8);

sub eng {
	# 94 total possible chars
	print(chr) for 32 .. 126;
}

sub kor {
	# 11272 total possible chars
	print(chr) for 32 .. 64;
	print(chr) for 91 .. 96;
	print(chr) for 123 .. 126;
	print(chr) for 12593 .. 12642;
	print(chr) for 44032 .. 55215;
}

sub rus {
	# 103 total possible chars
	print(chr) for 32 .. 64;
	print(chr) for 91 .. 96;
	print(chr) for 123 .. 126;
	print(chr) for 1040 .. 1103;
}

sub cj {
	# 1078 total chars
	print(chr) for 32 .. 64;
	print(chr) for 91 .. 96;
	print(chr) for 123 .. 126;
	print(chr) for 19968 .. 21006;
}

&eng	if $ARGV[0] eq 'eng';
&kor	if $ARGV[0] eq 'kor';
&rus	if $ARGV[0] eq 'rus';
&cj	if $ARGV[0] eq 'cj';

die "Usage: $0 [eng|kor|rus|cj]\n"
	if $ARGV[0] =~ /\-\-?(?:h(?:elp))/ or !@ARGV;

