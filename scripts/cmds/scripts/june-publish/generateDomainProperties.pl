#!/usr/bin/perl
use strict;
use Data::Dumper;
my ($serverList, $smartsList, $domainProperties) = @ARGV;
if(!$serverList || !$smartsList || !$domainProperties) { 
	print "Usage:<list of servers as file> <list of smarts mappings as file> <sample domain.properties>\n";
	exit(1);
}

my @smartsEntries = `cat $smartsList`;
my @serverList = `cat $serverList`;

my %smartsServer = ();

foreach my $sEntry (@smartsEntries) {
	$sEntry =~ s/\n//gi;
	my ($domain, $smartsServer) = split(/:/, $sEntry);
	
	foreach my $snmcpeServer(@serverList) { 	
		$snmcpeServer =~ s/\n//gi;
		if($snmcpeServer =~ m/$domain-/i) { 
			print "Creating domain.properties.$domain with smarts server $smartsServer\n";		
			`sed 's/NEW_TRAP_SENDER_DESTINATION.*/NEW_TRAP_SENDER_DESTINATION=$smartsServer/' $domainProperties > properties/$domainProperties.$domain`; 
		}
	}
#$smartsServer{$domain} = $server;
}		


#foreach my $key ( keys %smartsServer) { 
#	print "$key: $smartsServer{$key}\n";
#}
