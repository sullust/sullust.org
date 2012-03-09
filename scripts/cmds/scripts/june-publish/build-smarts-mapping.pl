#!/usr/bin/perl

open(FH, "< $ARGV[0]"); 
`scp -q esp\@pdcd01-snmcpe1.mso.mci.com:/usr/local/SMARTS_Config /tmp/SMARTS_Config`;
open(FH, "< /tmp/SMARTS_Config");
my @trapservers = ();

#pdcd27-ic4-oi1

while(<FH>) { 
	my $line = $_;
	$line =~ s/\n//gi;

	if($line =~ m/d[0-9]{1,3}-.{3,5}-oi1/) { 
		my @tokens = split(/:/, $line); 
		foreach my $token(@tokens) { 
			if($token =~ m/^.+?d[0-9]{1,3}-.{3,5}-oi1/ ) {
				$token =~ s/-oi1\@.*//;
				push(@trapservers, $token);
			}
		}
	}
}

%seen = ();
foreach $item (@trapservers) {
    $item =~ m/d[0-9]{1,3}/;
    push(@uniq, $item) unless $seen{$&}++;
}

foreach my $item(@uniq) { 
	$item =~ m/d[0-9]{1,3}/;
	my $ip = `nslookup $item | tail -4 | grep 'Address' | sed 's/.* //'`;
	print $&.":".$ip;
}
