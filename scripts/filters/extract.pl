#!/usr/bin/perl

#for i in `ls *.html`; do grep -A 5 Justification $i;  grep 'host .*eq' $i  | grep -oP 'host [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} eq [0-9]+' | sed 's/host //' | sed 's/ eq /,/g'; done;

my @files = `ls *.html`;

foreach my $file(@files) { 
	open(FH, "< $file");
	$_ =~ s/\n//gi;
	my $just_on = 0;
	my $justification = "";
	my @ips = "";
	while(<FH>) {
		if($just_on == 1) { 
			$justification .= $_;
			if ($_ =~ m/\<\/dd\>/) {
				$just_on = 0;
			}
		}
		if($_ =~ m/Justification/) {
			$just_on = 1;
		}

		if ($_ =~ m/host [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} eq [0-9]+/) {
			my ($host, $port) = ($_ =~ m/host ([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}) eq ([0-9]+)/); 
			push(@ips, "$host,$port\n");
		}
	}
	%seen = (); @ips = grep { ! $seen{$_} ++ } @ips;

	$justification =~ s/\<.*?\/?\>//g;
	$justification =~ s/  +//g;
	$justification =~ s/\n//g;
	print "\"Justification: ".$justification."\"\n";

	print join "", @ips;
}

		
