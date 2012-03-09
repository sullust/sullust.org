#!/usr/bin/perl
use strict;

my ($host, $port) = @ARGV;

my @output = `echo "abc123" | openssl s_client -host $host -port $port -showcerts`;
my $printLines = 0;
open(FH, "> /tmp/$host.pem");

foreach my $line(@output) 
{ 
        if($printLines == 1) { 
                print FH $line;
        }
        if($line =~ m/-----BEGIN CERTIFICATE-----/) 
        { 
                print "Certificate begin\n";
                print FH $line;
                $printLines =  1;
        }
        if($line =~ m/-----END CERTIFICATE-----/) 
        {       
                print "Certificate end\n";
                $printLines = 0;
        }
}
close(FH);
