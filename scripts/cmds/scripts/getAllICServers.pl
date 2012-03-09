#!/usr/bin/perl

`scp jainswor\@pdcd01-snmcpe1.mso.mci.com:/usr/local/SMARTS_Config ./`;

open (FH, "< SMARTS_Config");

my %servers = ();

my $line_count = 1;
while (<FH>) {
	my $line = $_;
	$line =~ s/\n//;

	my @results = ($line =~ m/([a-z]+[^t]d[0-9]+\-icb?[0-9])/g);
	foreach my $r (@results) {
		$servers{$r}++;
	}

	$line_count++;
}

foreach my $key (sort keys %servers) {
	print $key."\n";
}

# for i in `cat SMARTS_Config `; do 
# 	j=`echo $i | grep '\-ic'`; 
# 	if [[ "x"$j != "x" ]]; then 
# 		echo $i | sed 's/:.*//' | grep -v OVRIDE | grep -v DOMAIN | grep -v OI;
# 	fi; 
# done | sort -u | sed 's/^.*,//';


