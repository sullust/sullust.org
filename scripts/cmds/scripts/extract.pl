#!/usr/bin/perl

use lib qw (/esp/snmcpe/scripts/perl-libs);
use strict;
use Getopt::Long qw(:config bundling);
use Pod::Usage;
use Date::Calc qw(Delta_Days);

#DEFINED USER ARGUMENT VARIABLES
use vars qw($begin $end $dns_short $type $VERBOSE $HELP);
$VERBOSE = -5;

#GET CURRENT TIME
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
$year += 1900; $mon += 1;

#GET USER INPUT
GetOptions (
	'b=s' => \$begin,
	'e=s' => \$end,
	'd=s' => \$dns_short,
	't=s' => \$type,	
        'v'   => \$VERBOSE,
        'h|help|?' => \$HELP
);

pod2usage(1) if $HELP;
exit(0) if $HELP;

# LOAD USER ARGUMENTS
if(!$begin || !$end || !$dns_short) {
        my @missing_args = ();
        if(!$begin) { push(@missing_args, "Begin Date");}
        if(!$end) { push(@missing_args, "End Date");}
        if(!$dns_short) { push(@missing_args, "DNS Short Name");}
#        if(!$type) { push(@missing_args, "Log type");}

        print "The required arguments are missing:\n";
        print join "\n", @missing_args;
        print "\n\n";
        pod2usage(1);
        exit(1);
}


#Extract Y/M/D from user input
my ($bY, $bM, $bD) = split(/\./, $begin);
my ($eY, $eM, $eD) = split(/\./, $end);

#Prepare find command
my $command = "find . ";

# CALCULATE BEGIN TIME
my $deltaBegin = Delta_Days($year, $mon, $mday, $bY, $bM, $bD);
$deltaBegin -= 0;
$deltaBegin = (sqrt ($deltaBegin * $deltaBegin));
$command .= "-mtime -$deltaBegin ";

# CALCULATE END TIME
my $deltaEnd = Delta_Days($year, $mon, $mday, $eY, $eM, $eD);

#IF DELTA IS 0, SEARCH WAS FOR TODAY
if($deltaEnd == 0) {
	print "You can not extract events from today\n";
	exit 1;
}
elsif($deltaEnd != -1) {
	$deltaEnd += 2;
	$deltaEnd = (sqrt ($deltaEnd * $deltaEnd));
	$command .= "-a -mtime +$deltaEnd ";
}

#COMPLETE BUILDING COMMAND
$command .= "-name \"*.gz\" ";
my @files = `$command`;

#LOOP THROUGH APPROPRIATE LOG FILES
#AND EXTRACT MATCHING LINES
print "Log messages from $dns_short from $begin to $end\n";
foreach my $file(@files) { 
	$file =~ s/\n//gi;
	my $command = 'gunzip -c '.$file.' | grep '.$dns_short.' | grep -v '.`hostname`;
	my $results = `$command`;
	print $results;
}

__END__
=head1 extract.pl

=head1 SYNOPSIS

extract.pl [vh] [-b <Begin Date Range>] [-e <End Date Range>] [-d DNS Entity Name] [-t Log Type]

=head1 OPTIONS

=over 8

=item B<-v>
Verbose mode

=item B<-h>
Print this help message

=item B<-b> 
Date before which log messages will not be printed. 

Date format: YYYY.MM.DD

=item B<-e>
Date after which log messages will not be printed. 

Date format: YYYY.MM.DD

=item B<-d>
Full DNS Entity name of the device to search for
Example: 

=item B<-t>
Type of log to print.  Available types are:

	Type 1
	Type 2
	Type 3
	Type 4

=back

=head1 DESCRIPTION

B<This program> extract log entries for defined
devices from syslog files

=cut

