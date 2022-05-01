#!/usr/bin/perl -w
# connect and send commands to remote ip:port.
# the tor network is used for anonymity.
#
# usage: perl eript.pl <ip> <port>
#
# by nobot (use for educational purposes ...)

use strict;
use Net::SOCKS;

my ($sock, $conn, $pid);

# setup tor connection (defaults are used)
$sock = new Net::SOCKS
      (socks_addr       => '127.0.0.1',
                 socks_port       => 9050,
        protocol_version => 4 ) || die "$!\n";

$conn = $sock->connect
      (peer_addr => $ARGV[0],
            peer_port => $ARGV[1]) || die "$!\n";

print "port $ARGV[1] is open\n";

$conn->autoflush(1);

$pid = fork();
if ($pid) {
   while(<$conn>) {
      print $_;
   }
   kill("TERM" => $pid)
} else {
       print ">> ";
   while(<STDIN>) {
      print $conn "$_\n";
   }
}
$conn->close();
$sock->close(); 