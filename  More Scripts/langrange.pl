#!/usr/bin/perl -l
die "usage: $0 <from> <to> <left|right>\n"
	unless @ARGV || @ARGV > 3;

($from, $to, $pos, $int) = @ARGV;

die "from > to\n" if $from > $to;

while (1) {
	$x = ($to - $from) / 2;
	last if $from == $from + $x;

	print "$from .. " . ($from + $x) . " .. $to";

	if ($pos eq "left") {
		$to = $from + $x;
	} else {
		$from = $from + $x;
	}
}
