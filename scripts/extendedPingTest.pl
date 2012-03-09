#!/usr/local/bin/perl
#######################################################
#################  NETCHk SNMP Discovery###############
#################    Rich Schemitsch	###############
#######################################################
use lib qw (/esp/snmcpe_prod_92/scripts/perl-libs);
use strict;
use Getopt::Long qw(:config bundling);
use Pod::Usage;
use Net::Ping;

use vars qw($entity_ip $local_interface $data_size $time $pattern $timeout $VERBOSE $LIBCHECK $HELP);
$VERBOSE = -5;


GetOptions (
	'i=s' => \$entity_ip,
	'l=s' => \$local_interface,
	'd=s' => \$data_size,
#	'r=s' => \$repeat_count,
	't=s' => \$time,
#	'p=s' => \$percentage_for_success,
	'a=s' => \$pattern,
#	'o=s' => \$timeout,
        'v'   => \$VERBOSE,
	'c'   => \$LIBCHECK,
        'h|help|?' => \$HELP
);

print "Libraries present\n" if $LIBCHECK;
exit(0) if $LIBCHECK;

pod2usage(1) if $HELP;
exit(0) if $HELP;

if(!$entity_ip || !$data_size || !$time) {
	my @missing_args = ();
	if(!$entity_ip) { push(@missing_args, "Entity Ip Address");}
	if(!$data_size) { push(@missing_args, "Datagram Size");}
	if(!$time) { push(@missing_args, "Processing Time");}	

	print "The required arguments are missing:\n";
	print join "\n", @missing_args;
	print "\n\n";
	pod2usage(1);
	exit(1);
}

#$data_size=512;
$timeout=1;
#$time = 60;

my $p = Net::Ping->new("icmp", $timeout, $data_size, $pattern);
#if($local_interface) { $p->bind($local_interface);}

my $pingSuccess = 0;
my $pingFailure = 0;

my $beginTime = time();
my $newTime = time();
my $deltaTime = 0; 

while($deltaTime <= $time) {
	$p->ping($entity_ip, $timeout) ? $pingSuccess++ : $pingFailure++;
	$newTime = time();
	$deltaTime = $newTime - $beginTime;
}

print "passed: ".$pingSuccess."\n";
print "failed: ".$pingFailure."\n";

__END__
=head1 extendedPingTest.pl

=head1 SYNOPSIS

extendedPingTest.pl [vh] [-i <Router IP>] [-d <Data Size>] [-l Local Inteface Address] [-t execute time] [-o timeout] (-a Data Pattern)

=head1 OPTIONS

=over 8

=item B<-v>

Verbose mode

=item B<-h>

Print this help message

=item B<-i>

The IP Address for the entity to be pinged

=item B<-d>

Size of data to be transmitted in Ping packets

=item B<-a>

Optional data pattern to use when filling the packet

=item B<-l>

Address of the local interface to use when pinging

=item B<-t>

Total time (in seconds) to execute pings

=back

=head1 DESCRIPTION

B<This program> pings floods a given entity 
with various preferences assigned by the user.

=cut

