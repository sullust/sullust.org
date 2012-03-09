#!/usr/bin/perl
use strict;

my $server_list_file = $ARGV[0];
my $verbose = "";

print "Server list: $server_list_file\n" unless $verbose != 1;

my @server_list = `cat $server_list_file`;

print "Servers: \n" unless $verbose != 1;
print join "", @server_list unless $verbose != 1;

foreach my $server (@server_list) { 
	$server =~ s/\n//gi;
	print "Server: $server\n" unless $verbose != 1;
	my $command = "ssh jainswor\@$server \"/esp/bin/findInstances.sh refresh\"";
	print "Command: ".$command."\n" unless $verbose != 1;
	my @instances = `$command`;

	print "Server: $server";

	print join "\n", @instances;
}