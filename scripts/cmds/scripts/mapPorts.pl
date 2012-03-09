#!/usr/bin/perl
use lib qw (/esp/snmcpe/scripts/perl-libs);
use strict;
use Data::Dumper;

my %portMap = ();
my $hashFile = "";

print "Collecting available ports...\n";
my @availablePorts = `/tmp/findOpenPorts.sh`;

@availablePorts = map {s/\n//gi; $_ } @availablePorts;

if($ARGV[0] =~ m/./) {
	$hashFile = $ARGV[0];
	%portMap = %{loadHashFile($ARGV[0])};
	@availablePorts = @{cleanPortArray(\%portMap, \@availablePorts)};
} else {
	$hashFile = "PortMappingData";
}
print "Available Ports: \n";
print join "\n", @availablePorts;
print "\n";

my $PATH="*_1105";
my @all = `find $PATH -name "*.shk"`;

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
				print "Found $port\n";
			}
			if($line =~ m/TOOLS_/ || $line =~ m/^espws\./ || $line =~ m/^SECURE_PORT=/) {
				($port) = ($line =~ m/([0-9]{4,4})$/);
				$line =~ s/146.170.67.10/espws4.vzbi.com/g;
				$line =~ s/espws7/espws4/g;
				$line =~ s/pdcc01\-espws1.mso.mci.com/espws4.vzbi.com/g;
				$line =~ s/ndcc01\-espwsb1.mso.mci.com/espws4.vzbi.com/g;
				$line =~ s/pdcc01\-esp1.mso.mci.com/espws4.vzbi.com/g;
				$line =~ s/espws5.vzbi.com/espws4.vzbi.com/g;
				print "Found $port\n";
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
			if ($item =~ m/./ && $item != 8004) {
				push(@finalArray, $item);
			}
        }

        return \@finalArray;
}
