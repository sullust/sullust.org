#!/usr/bin/perl

`scp -q jainswor\@pdcd01-snmcpe1.mso.mci.com:/usr/local/SMARTS_Config /home/jainswor/scripts/`;


$SMC = '/home/jainswor/scripts/SMARTS_Config';

open (FH, "< $SMC");

while (<FH>) {
	($oiServer) = ($_ =~ m/([a-z]dcd[0-9]{2,2}-[a-z]{2,3}[0-9])-oi1/);
	if($oiServer =~ m/./) { 
		my ($domain) = ($oiServer =~ m/[a-z]dcd([0-9]{2,2})/);
		my $oiServerIP = `host $oiServer.mso.mci.com`;
		$oiServerIP =~ s/.*address //g;
		print "d$domain:$oiServerIP";
	}
}
		
