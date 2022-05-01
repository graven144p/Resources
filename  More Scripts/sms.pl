#!/usr/bin/perl -CA -w
#
###############################################################################
# SMS Sender (or flooder ^_^) for Moldcell and Orange mobile operators.       #
#                                                                             #
# You can connect via proxy to bypass restriction «5 sms per 24 hours» of     #
# Orange operator.                                                            #
#                                                                             #
# Best practice is configure TOR to change automatic new IP every one         #
# (as example) minute:                                                        #
#                                                                             #
# --- Put this three lines to your `torrc` file ---                           #
#                                                                             #
# CircuitBuildTimeout 10                                                      #
# LearnCircuitBuildTimeout 0                                                  #
# MaxCircuitDirtiness 10                                                      #
#                                                                             #
# --- restart TOR and use "socks://127.0.0.1:9150" as proxy server ---        #
#                                                                             #
# This program depends on Imagemagick and Tesseract to crack the captcha.     #
#                                                                             #
# Good luck and remember: don't be evil! :)                                   #
#                                                                             #
# contacts: chinarulezzz, <alexandr.savca89@gmail.com>                        #
#                                                                             #
###############################################################################

$|++;                   # autoflush stdout for verbose mode

use strict;
use utf8;

use POSIX 'locale_h';   # import LC_ALL constant

setlocale LC_ALL, "";   # for locale-defined formatting

use Getopt::Std;
use List::Util 'shuffle';
use WWW::Mechanize;

BEGIN {
    $SIG{__DIE__} = sub { print "@_\nTry '$0 -h' for help\n" and exit };
}

my $version = "0.2.4";

my $help = << "EOH";
Usage: $0 [OPTIONS...] "MESSAGE"
Version: $version

Options:
  -f <name>             Sender name in latin encoding
  -t <phone number>     Recipient phone number
  -l <log file>         Save server response to log file
  -p <proxies file>     Each connection will be done via random proxy
  -v                    Print all information
  -h                    Print this help and exit
  MESSAGE               SMS Text
EOH

use vars qw( $opt_f $opt_t $opt_l $opt_p $opt_v $opt_h $opt_m );

getopts ('f:t:l:p:vh') or die "Invalid command line arguments.\n";

do { print $help and exit } if $opt_h;

# suppress unimportant information of error messages
sub errmsg { lc shift =~ s/at .* line \d+\.//r }

#
# check requirements for phone number
#

if ($opt_t)
{
    die "Phone number should contain 8 digits\n"
        if $opt_t !~ /^\d{8}$/;

    die "This is not valid Orange/Moldcell phone number\n"
        if $opt_t !~ /^(6|7)\d{7}$/;
}
else
{
    die "Recipient phone number must be specified\n";
}

# orange phone number starts with 6
my $is_orange_number = substr ($opt_t, 0, 1) eq 6;

#
# check requirements for sender
#

if ($opt_f)
{
    my $length = $is_orange_number ? 6 : 9;

    die "Length of sender name should be less than $length latin characters\n"
        if length $opt_f > $length or $opt_f !~ /[A-Za-z0-9]/;
}
else
{
    die "The sender name must be specified.\n";
}

#
# check requirements for message
#

if (@ARGV == 1)
{
    $opt_m = shift;
    my $length;

    if ($opt_m =~ /[[:ascii:]]/)
    # Contains ASCII only
    {
        $length = $is_orange_number ? 137 : 140;
    }
    else
    # Contains non-ASCII
    {
        $length = $is_orange_number ? 59 : 69;
    }

    die "Message length should be less than $length characters\n"
        if length $opt_m > $length;

}
else
{
    die "Message must be specified\n";
}


#
# check proxy option
#

my @proxies;

if ($opt_p)
{
    print "[#] get proxies from file\n" if $opt_v;

    open my $fh, $opt_p
        or die " |--> can't open $opt_p: $!\n";

    while (<$fh>)
    {
        push (@proxies, s/\R//gr)       # chomp \r\n
            unless /^#/ or not length;  # skip comments and empty lines
    }
    close $fh;
}

#
# connect to websms service center, break the captcha and send sms
#

{
    #
    # create a new browser
    #
    # NOTE
    #   * add timeout option?

    my $mech = WWW::Mechanize->new (timeout => 5);

    #
    # proxy settings
    #

    if ($opt_p)
    {
        my $proxy = shuffle @proxies;
        $mech->proxy ([qw(http https)] => $proxy);

        print "[|] use proxy connection: $proxy\n" if $opt_v;
    }
    else
    {
        print "[|] use direct connection\n" if $opt_v;
    }

    #
    # set "referer" http header field, to confirm that we are human
    #

    $mech->add_header (Referer => $is_orange_number ? 'http://www.orange.md'
                                                    : 'http://www.moldcell.md/sendsms');

    #
    # get page
    #

    print "[|] trying to connect\n" if $opt_v;

    eval
    {
        $mech->get ($is_orange_number ? 'https://www.orangetext.md'
                                      : 'http://www.moldcell.md/sendsms')
    };

    if ($@) # could not get
    {
        print ' |--> ', errmsg ($@) if $opt_v;
        redo;
    }

    #
    # find captcha
    #

    print "[|] search captcha image\n" if $opt_v;

    my $img_obj //= $mech->find_image (url_regex => $is_orange_number
                                                  ? qr/CaptchaImage\.axd/
                                                  : qr/captcha/i);

    if (!$img_obj) # can't find
    {
        print " |--> failed\n" if $opt_v;
        redo;
    }

    #
    # download captcha
    #

    print "[|] download\n" if $opt_v;

    my $captcha = 'captcha'. ($is_orange_number ? '.jpg' : '.png');

    eval { $mech->get ($img_obj->url, ':content_file' => $captcha) };

    if ($@) # can't download
    {
        print ' |--> ', errmsg ($@) if $opt_v;
        redo;
    }

    #
    # crack captcha
    #

    print "[|] crack captcha\n" if $opt_v;

    my $convert; # imagemagick command

    if ($is_orange_number)
    {
        $convert = << "EOC";

            /usr/bin/convert 
                -morphology thicken:1 '1x3:-1,0,1' 
                -morphology close rectangle:2x1 
                -threshold 67% 
            $captcha captcha 

EOC
    }
    else
    {
        $convert = << "EOC";

            /usr/bin/convert 
                -auto-gamma 
                -morphology thicken:3 '3x1>:1,0,1' 
                -morphology close rectangle:1x2 
            $captcha captcha 

EOC
    }

    # convert multi line command into one line
    $convert =~ s/[\r\n]//g;
    $convert =~ s/\s+/ /g;

    # tesseract OCR engine command
    my $tesseract = "/usr/bin/tesseract captcha captcha";

    # process the captcha
    system "$convert && $tesseract >/dev/null 2>&1"; # suppress stdout

    #
    # read processed captcha
    #

    $captcha = do { open FH, 'captcha.txt'; <FH> };

    if (!$captcha)
    {
        print " |--> empty captcha\n";
        redo;
    }

    #
    # some fixes to raise the percentage of recognition
    #

    local $_ = $captcha;

    if ($is_orange_number)
    {
        s/[\r\n]//g;
        tr/ //d;
        tr/;,.=_//d;
        tr/-//d;
        tr/—//d;
        tr/\’\‘"'//d;

        s/D/p/g;

        s/\$/s/g;

        s/¢/c/g;
        s/<:/c/g;

        s/€/e/g;
        s/é/e/g;

        s/G/6/g;

        s/O/0/ig; # 1/56 vs 1/10
        s/\(\)/0/g;

        s/\)</x/g;
        s/>\(/x/g;
        s/></x/g;
        s/\)\(/x/g;

        s|\\/|v|g;
        s|\\I|v|g;
        s/\\\(/v/g;
        s|\\l|v|g;

        s/\|</k/g;
        s/!</k/g;
        s/I</k/g;

        s!\)/!y!g;
        s!\)’!y!g;
        s/\)!/y/g;
        s/¥/y/g;

        if (length > 5)
        {
            s/(rn|nr|rr)/m/g;
            s/rI/n/g;
            s/r\\/n/g;

            s/C\|/q/g;
            s/CI/q/g;
            s/Cl/q/g;

            s/vv/w/gi;
        }

        tr/:*//d;
        $captcha = lc $_;
    }
    else
    {
        tr/ //d;
        tr/`'"_//d;

        s/[\r\n]//g;
        s/é/E/g;
        s/5/S/g;
        tr/°0/O/;
        tr/‘l1\\|/I/;
        s/\)\(/X/g;
        s/></X/g;
        s/¥/Y/g;

        $captcha = uc $_;
    }

    # check some captcha requirements
    if (length $captcha != 5 || $captcha =~ /[^a-zA-Z0-9]/)
    {
        print " |--> invalid captcha: $captcha\n" if $opt_v;
        redo;
    }

    # ok, captcha possibly breaked
    print " |--> $captcha\n" if $opt_v;

    # now, return to sms-send form
    $mech->back;

    #
    # and POST data to the server
    #

    print "[|] send data to server\n" if $opt_v;

    if ($is_orange_number)
    {
        $mech->form_name('ctl00');
        $mech->field( 'edtFrom'      => $opt_f    );
        $mech->field( 'edtMsisdn'    => "0$opt_t" );
        $mech->field( 'edtMsg'       => $opt_m    );
        $mech->field( 'edRandNumber' => $captcha  );
    }
    else
    {
        $mech->form_id('websms-main-form');
        $mech->field( 'phone'            => $opt_t   );
        $mech->field( 'name'             => $opt_f   );
        $mech->field( 'message'          => $opt_m   );
        $mech->field( 'captcha_response' => $captcha );
    }

    eval { $mech->click };

    if ($@) # can't send
    {
        print ' |--> ', errmsg ($@) if $opt_v;
        redo;
    }

    #
    # if log option is enabled then save response from server to log file
    #

    if ($opt_l)
    {
        open  LOG, "> $opt_l";
        print LOG  $mech->content;
        close LOG;
    }

    #
    # analyze response
    #

    local $_ = $mech->content;

    if ($is_orange_number)
    {
        if (/ati depasit numarul maximal de mesaje/)
        {
            print " |--> you can send only 5 messages per day from this ip\n"
                if $opt_v;
            redo;
        }

        if (/ati introdus codul din imagine incorect/)
        {
            print " |--> the captcha was incorrect\n" if $opt_v;
            redo;
        }

        goto DONE if /a fost expediat cu succes/;
    }
    else
    {
        if (/a dezactivat primirea mesajelor de pe web/)
        {
            print " |--> the recipient has deactivated this service\n"
                if $opt_v;
            redo;
        }

        goto DONE if /Mesajul Dvs. a fost expediat/;
    }

    #
    # when success
    #

  DONE:

    print "[!] that's all folks!\n" if $opt_v;

    # remove all temporary files
    unlink glob 'captcha*';
}

# EOF
