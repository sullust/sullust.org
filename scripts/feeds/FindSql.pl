#!/usr/bin/perl
use strict;

# EVERY SCRIPT MUST BE OPENED

#### Script variables ####
my $BILLING_HOME='/export/home/oracle/billing';
my $EREF_HOME='/export/home/oracle/eRef';
my $RLM_HOME='/export/home/oracle/rlm';
my $PT_HOME='/export/home/oracle/ProjectTracker';

my $SCRIPTS_BASE_DIR='/mulder';
my @initial_scripts = `cat /home/jainswor/scripts/feeds/feed_scripts`;
my @known_scripts = @initial_scripts;
my %processed_scripts = ();

foreach my $script(@known_scripts) {
	$script =~ s/\n//gi;
	$processed_scripts{$script}++;
	processScript($script, \@known_scripts, \%processed_scripts);
}

#print join "\n", @known_scripts;

sub processScript {
	my $script = shift;
	my $known_scripts = shift;
	my $processed_scripts = shift;
		
	open(FH, "< $script");
	while(<FH>) {
		$_ =~ s/\n//gi;
		$_ =~ s/^ *//;
		$_ =~ s/\$\{BILLING_HOME(\}|\))/$BILLING_HOME/;
		$_ =~ s/\$\{EREF_HOME\}/$EREF_HOME/;
		$_ =~ s/\$\{RLM_HOME\}/$RLM_HOME/;
		$_ =~ s/\$\{PT_HOME\}/$PT_HOME/;
		$_ =~ s/\;//;
		
		my $command = "";
		if($_ =~ m/.+\.sql/i && $_ !~ m/^(\. |\#|\$?echo)/i)
		{
			$command = $_;
			$command =~ s/.+?sqlplus/sqlplus/;
			my ($command1) = ($command =~ m/^.*(\/.*?\.sql)/i);
			#if(!$processed_scripts->{$command}) {
			#	push(@{$known_scripts}, $command);
			#} else {
			#	print "\tAlready examined: $command\n";
			#}
			print $command1."\n";
		}
	}
}


