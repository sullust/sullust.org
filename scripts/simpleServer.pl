#!/usr/bin/perl -w

#additional header for sockets handling
use IO::Socket;
#used for the function gethostbyaddr
use Net::hostent;

#you have to specify the port number after the perl command
my $port=shift || die "Usage server.pl <port>\n";

####
#creation of the socket called $server:
#Proto= protocol to use
#LocalPort = service name or port number to be the server
#ports < 1024 under linux are restricted to the superuser
#Listen = number of pending connections, SOMAXCON is
#a special symbol for the system maximum
#Reuse = restart the server manually
####

my $server = IO::Socket::INET->new( Proto => 'tcp',
LocalPort => $port,
Listen => SOMAXCONN,
Reuse => 1);

die "can't setup server" unless $server;
print "[Server $0 is running]\n";

####
#the server waits for a client to connect
#and accept it with $server->accept
#you can telnet to the port you want to test it
####

while ($client = $server->accept()) {

 $client->autoflush(1);

#welcome

 print $client "Welcome to $0\n type help to get a list of commands.\n";

####
#get informations on the client
#peeraddr = client name or IP
####
 $hostinfo = gethostbyaddr($client->peeraddr);

#print this informations on the server side
 printf "[Connect from %s]\n", $hostinfo->name || $client->peerhost;

#ask the client for a command
# print $client "[server]\$";
 while ( <$client>) {
 next unless /\S/; # blank line
#quit/exit
# if (/quit|exit/i) { last;}
#print something
# elsif (/date|time/i) { printf $client "%s\n", scalar localtime;}
#execute a command on the server
# elsif (/services/i ) { print $client `cat /etc/services 2>&1`;}
#else print all the commands
# else {
 #print $client "Commands: quit date services\n";
	printf $_;
 
# }
 }
 continue {
 print $client "[server]\$ ";
 }
 close $client;
}
#the socket $client is closed
#to close the socket $server: ctrl+c 
