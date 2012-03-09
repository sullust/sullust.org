#!/usr/bin/perl -w
use strict;
use Socket;

my $time = time();
print $time."\n";

#my ($remote_host, $remote_port) = @ARGV;

#my $socket = IO::Socket::INET->new(PeerAddr => $remote_host,
#				   PeerPort => $remote_port,
#				   Proto    => "tcp",
#				   Type     => SOCK_STREAM)
#	or die "Couldn't connect to $remote_host:$remote_port : $@\n";
# create the socket, connect to the port

my $server = "127.0.0.1";
my $port = 6193;

socket(SOCKET,PF_INET,SOCK_STREAM,(getprotobyname('tcp'))[2])
   or die "Can't create a socket $!\n";

connect( SOCKET, pack( 'Sn4x8', AF_INET, $port, $server ))
       or die "Can't connect to port $port! \n";

#close($socket);
