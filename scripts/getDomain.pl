#!/usr/bin/perl

my $hostname = `hostname`;
#ndcd21-snmcpeb1.mso.mci.com

my ($domain, $backup) = ($hostname =~ m/d([0-9][0-9]?).+snmcpe(b?).*/);
$domain =~ s/^0//;
print $domain.$backup;

