#!/usr/local/bin/perl 
use strict;     
use Data::Dumper;
#use Time::localhost;

my $CISCO_LOG = "";
my $beginDate = `date`;
my $syslog_pid = `cat /etc/syslog.pid`;

$beginDate =~ s/\n//gi;
print "=== Begin CME Parsing: $beginDate ===\n";

if($ARGV[0] !~ m/./) { 
	$CISCO_LOG = '/logs/cisco_logs/cisco-20051117-caytd2-snmcpe1.log';
} else {
 	$CISCO_LOG = $ARGV[0];	
}
print "\t Reading file: $CISCO_LOG\n";
#my $CDR_REPOSITORY='/esp/snmcpe3/cmerecords/new';
my $CDR_REPOSITORY=$ARGV[1];

## Compile time and date
my $TIME = time();
my ($DAY, $MONTH, $YEAR) = (localtime)[3,4,5]; 
$MONTH = sprintf("%02d", $MONTH + 1);
$DAY = sprintf("%02d", $DAY);
$YEAR += 1900;
my $DATE = $YEAR.$MONTH.$DAY;

## Create log file names
my $OLD_CISCO_LOG = $CISCO_LOG;
my $NEW_CISCO_LOG = $OLD_CISCO_LOG.".".$TIME;

`mv $OLD_CISCO_LOG $NEW_CISCO_LOG`;
`touch $OLD_CISCO_LOG`;
`chmod 777 $OLD_CISCO_LOG`;
`kill -HUP $syslog_pid`;

my $CISCO_LOG_FINAL = $OLD_CISCO_LOG.".".$DATE;

my %cdr_lines = ();
open(CISCO_LOG_FINAL, ">> $CISCO_LOG_FINAL");
open(NEW_CISCO_LOG, "< $NEW_CISCO_LOG");
while(<NEW_CISCO_LOG>) {
	my $line = $_;
	if($line =~ m/VOIPAAA-5-VOIP_CALL_HISTORY/) {
	        my $timeStamp = getTimeStamp($line);	
		push(@{$cdr_lines{$timeStamp}}, $line);
		my $cdrFileName = getCdrFileName($timeStamp);
		open(CDR_RECORD, "> $CDR_REPOSITORY/$cdrFileName");
		close(CDR_RECORD);
	} else {
		print CISCO_LOG_FINAL $line;
	}
}
close(CISCO_LOG_FINAL);
close(NEW_CISCO_LOG);

foreach my $key (keys %cdr_lines) {
	#print $key."\n";
	foreach my $item(@{$cdr_lines{$key}}) {
		my $cdrFileName = getCdrFileName($key);
		open(CDR_RECORD, ">> $CDR_REPOSITORY/$cdrFileName");
		print CDR_RECORD "$item";
		close(CDR_RECORD);
		`chmod 777 $CDR_REPOSITORY/$cdrFileName`;
		`cp $CDR_REPOSITORY/$cdrFileName /esp/snmcpe/cmerecords/bak/$cdrFileName`;
	} 
}
#`gzip $CISCO_LOG_FINAL`;
`rm $NEW_CISCO_LOG`;
`chown -R esp /esp/snmcpe/cmerecords`; 

my $endDate = `date`;
$endDate =~ s/\n//gi;
print "=== End CME Parsing: $endDate ===\n";

sub getTimeStamp {
	my $entry = shift;
	my $year = `date +%Y`;
	$year =~ s/\n//gi;
	$entry =~ m/^[a-z]+\s+[0-9]+\s+[0-9]{1,2}:[0-9]{1,2}/i;
	my $timeStamp = $&;
	$timeStamp =~ s/\s+/ /g;
	print "I got timeStamp $timeStamp\n";
	my @time = split(/ /, $timeStamp);
	my ($hour, $minute) = ($time[2] =~ m/([0-9]{1,2}):([0-9]{1,2})/);

	my $day = $time[1];	
	$day = sprintf("%02d", $day);
	$minute = sprintf("%02d", $minute - ($minute % 5));
	$hour = sprintf("%02d", $hour);
	#print "Minute: $minute\n";
	#print "Hour: $hour\n";
	
	my $date = $year.getMonth($time[0]).$day.$hour.$minute."00";
	print "\tReturned date is $date\n";
	return $date;	
}

sub getMonth { 
	my $month = shift;
	my %months = (
		"Jan" => "01",
		"Feb" => "02",
		"Mar" => "03",
		"Apr" => "04",
		"May" => "05",
		"Jun" => "06",
		"Jul" => "07",
		"Aug" => "08",
		"Sep" => "09",
		"Oct" => "10",
		"Nov" => "11",
		"Dec" => "12"
	);
	return $months{$month};
}

sub getCdrFileName { 
	return "IPCC_CME_".$_[0];
}
