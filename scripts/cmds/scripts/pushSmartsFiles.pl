#!/usr/bin/perl
use strict;

my ($user, $serverList, $remoteDestination) = @ARGV;

if(!$user || !$serverList || !$remoteDestination) { 
	print "Usage: Usage: <username> <list of servers as file> <remote destination>\n";
	exit(1);
}	

my @propertiesFiles = `ls properties/`; 
my @snmcpeServers = `cat $serverList`;

foreach my $server (@snmcpeServers) { 
	$server =~ s/\n//gi;
	$server =~ m/d[0-9][0-9]-/;
	my $domain = $&;
	$domain =~ s/-//gi;
	

	if(`ls properties/\*.$domain` =~ m/./) {
	`echo "$server" > tmp-server`;
	#print "tmp server: ".`cat tmp-server`;
	print `./upload-file.sh properties/domain.properties.$domain $user tmp-server $remoteDestination`;
	#print "\n";
	}
}
`rm tmp-server`;
