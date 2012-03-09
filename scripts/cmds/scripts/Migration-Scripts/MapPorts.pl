#!/usr/bin/perl
use lib qw (/esp/snmcpe/scripts/perl-libs);
use strict;
use Data::Dumper;

my $BASE_PROJECT_DIR='/esp/esp_projects';
my $SHAKEOUT_ESPWS_SERVER='ndcc01-espwsb2.mso.mci.com';
my $SHAKEOUT_TOOLS_SERVER='espws5.vzbi.com';

my %portMap = ();
my $hashFile = "";

my ($availablePortsFile, $portMapFile, $FROM, $TO) = @ARGV;
open(BP_DIR, "$BASE_PROJECT_DIR");

print "Collecting available ports...\n";
my @availablePorts = `cat $availablePortsFile`;

@availablePorts = map {s/\n//gi; $_ } @availablePorts;

$hashFile = $portMapFile;
%portMap = %{loadHashFile($portMapFile)};
@availablePorts = @{cleanPortArray(\%portMap, \@availablePorts)};

print "Available Ports: \n";
print join "\n", @availablePorts;
print "\n";

my $findCommand = "find $BASE_PROJECT_DIR/*_$TO -name \"*.shk\"";
print "Find Command: $findCommand\n";
my @all = `$findCommand`;

print "Performing port transaltion on: \n";
print join "\n", @all;

foreach my $file(@all) {
	$file =~ s/\n//;
	open(FH, "< $file");
	my %filePrinted = ();

	if($file !~ m/(cpe|extra|timeout)/) {
		`rm $file.tmp 2>/dev/null`;
		open(OUT, ">> $file.tmp");
		while(<FH>) {
			my $line = $_;
			my $port = "";
			if($line =~ m/listen-port/) {
				($port) = ($line =~ m/listen-port\>([0-9]+)\<\/listen-port/);
			}

			my $replacementValue = "";

			if($line =~ m/TOOLS/) {
				$replacementValue = $SHAKEOUT_TOOLS_SERVER;
			} else {
				$replacementValue = $SHAKEOUT_ESPWS_SERVER;
			}

			#Fix the server used in shakeout
			if($line =~ m/TOOLS_/ || $line =~ m/^espws\./ || $line =~ m/^SECURE_PORT=/) {
				($port) = ($line =~ m/([0-9]{4,4})$/);
				$line =~ s/146.170.67.10/$replacementValue/g;
				$line =~ s/espws7/$replacementValue/g;
				$line =~ s/pdcc01\-espws1.mso.mci.com/$replacementValue/g;
				$line =~ s/ndcc01\-espwsb1.mso.mci.com/$replacementValue/g;
				$line =~ s/pdcc01\-esp1.mso.mci.com/$replacementValue/g;
				$line =~ s/espws5.vzbi.com/$replacementValue/g;
			}
			if($port =~ m/./) {
					if($filePrinted{$file} == 0) {
						print "Mapping $file\n";
						$filePrinted{$file}=1;
					}
					if($portMap{$port} !~ m/./) {
						if(($#availablePorts + 1) == 0) {
							print "No more available ports\n";
						} else {
							$portMap{$port} = pop(@availablePorts);
						}
					}
					print "Transposing $port to $portMap{$port}\n";
					$line =~ s/$port/$portMap{$port}/g;
			}
			print OUT $line;
		}
		close(OUT);
	}
	if($filePrinted{$file} == 1) { 
		`mv $file.tmp $file`;
	}
	close(FH);
}

saveHashFile(\%portMap, $hashFile);

#Load port map from file
sub loadHashFile {
	my $filename = shift;
	my %portMap = ();

	open(IN, "< $filename");
	while(<IN>){ 
		my $line = $_;
		$line =~ s/\n//;
		my ($old, $new) = split(/:/, $line);
		$portMap{$old} = $new;
	}
	close(IN);
	return \%portMap;
}

#Save port map to file
sub saveHashFile {
	my $portMapRef = shift;
	my $filename = shift;
	my %portMap = %{$portMapRef};
	open(OUT, "> $filename");

	foreach my $key (keys %portMap) {
		print OUT "$key:$portMap{$key}\n";
	}
	close(OUT);
}

#Rmove ports defined as used in the port map data file even 
#they are currently available
sub cleanPortArray {
        my $portMapRef = shift;
        my $arrayRef = shift;

        my %tmpHash = ();
        my %portMap = %{$portMapRef};
        my @array = @{$arrayRef};
        my @finalArray = ();

        for (my $i = 0; $i < @array; $i++) {
			$tmpHash{$array[$i]} = $i;
        }
        foreach my $key (keys %portMap) {
			$array[$tmpHash{$portMap{$key}}] = "";
        }
        foreach my $item(@array) {
			if ($item =~ m/./) {
				push(@finalArray, $item);
			}
        }

        return \@finalArray;
}