#!/usr/bin/perl -w

# Author: stuartaroth@gmail.com

use Getopt::Std;
use IO::Socket;
use strict;

sub print_usage {
	print "Usage: nagios_update_passive.pl \n\t -n [nagios server] \n\t -p [udp port] \n\t -h [nagios host] \n\t -s [nagios service] \n\t -a [alarm severity] \n\t -m [alarm message]\n";
}

my($sock, $msg, $port, $ipaddr, $hishost, 
   $MAXLEN, $PORTNO, $TIMEOUT);

our($opt_n, $opt_p, $opt_h, $opt_s, $opt_a, $opt_m);
getopts("n:p:h:s:a:m:");

$MAXLEN  = 1024;
$PORTNO  = $opt_p;
$TIMEOUT = 5;

$sock = IO::Socket::INET->new(Proto     => 'udp',
                              PeerPort  => $PORTNO,
                              PeerAddr  => $opt_n)
    or die "Creating socket: $!\n";


if( !( $opt_n && $opt_p &&  $opt_h && $opt_s && $opt_m ) && ( $opt_a == 0 || $opt_a == 1 ||$opt_a == 2 ||$opt_a == 3 )) {
    &print_usage;
    exit(1);
}

$msg = "$opt_h;$opt_s;$opt_a;$opt_m";

$sock->send($msg) or die "send: $!";

eval {
    local $SIG{ALRM} = sub { die "alarm time out" };
    alarm $TIMEOUT;
    $sock->recv($msg, $MAXLEN)      or die "recv: $!";
    alarm 0;
    1;  # return value from eval on normalcy
} or die "recv from $opt_n timed out after $TIMEOUT seconds.\n";

print "Server responded $msg\n";

