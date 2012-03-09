#!/usr/bin/perl -w
use strict;

use IO::Socket;
my ($remote_host, $remote_port) = @ARGV;

my $socket = IO::Socket::INET->new(PeerAddr => $remote_host,
                                   PeerPort => $remote_port,
                                   Proto    => "tcp",
                                   Type     => SOCK_STREAM,
                                   Timeout  => 1)
        or die "Couldn't connect to $remote_host:$remote_port : $@\n";
close($socket);
