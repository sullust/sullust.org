#!/usr/bin/perl

my %data = ();
@{$data{1}}=qw(30);
@{$data{2}}=qw(21);
@{$data{4}}=qw(19 20);
@{$data{5}}=qw(36 37);
@{$data{6}}=qw(1 50);

foreach my $title(keys %data) {
	print "Title: $title\n";
	foreach my $ep(@{$data{$title}}) {
		print "$title - $ep\n";
		`hpodder setstatus -c $title -s Pending $ep`;
	}
}
