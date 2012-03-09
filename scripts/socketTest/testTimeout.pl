#!/usr/bin/perl
use strict;
use IO::Socket;
use Time::localtime;

my ($remote_host, $remote_port) = @ARGV;

my $socket = IO::Socket::INET->new(PeerAddr => $remote_host,
                                   PeerPort => $remote_port,
                                   Proto    => "tcp",
                                   Type     => SOCK_STREAM,
                                   Timeout  => 3)
        or die "Couldn't connect to $remote_host:$remote_port : $@\n";

my $data = "";

logger("Opening socket to $remote_host:$remote_port - Entering read.\n");

$socket->read($data, 1024);

logger("Socket to $remote_host:$remote_port closed\n");

sub logger {
	my $date = `date`;
	$date =~ s/\n//gi;
	print "$date: ";
	print @_;
}