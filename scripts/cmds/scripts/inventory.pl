#!/usr/bin/perl

my @domains = `ls /esp/esp_projects/ | grep domain | sort`;

foreach my $domain(@domains) {
	$domain =~ s/\n//gi;
	my $app = $domain;
	$app =~ s/domain.*//;

	#APP NAME
	print "$app,";

	#HOSTNAME
	my $hostname = `hostname`;	
	chomp $hostname;
	$hostname =~ s/\..*//;
	print "$hostname,";

	#ALIAS
	empty();

	#APACHE
	empty();

	#WEBLOGIC/JBOSS PORT
	my $listen_port_raw = `grep 'listen-port>' /esp/esp_projects/$domain/config/config.xml`;
	my ($listen_port) = ($listen_port_raw =~ m/([0-9]+)/);
	print "$listen_port,";
		
	my @database = `grep -h '<url>' /esp/esp_projects/$domain/config/jdbc/* | grep -v '[0-9]<'`;
	@database = map { s/.*://; s/<.*$//; chomp; $_ } @database;
	print join "-", @database;
	print ',';
	
	#PATH
	print $domain.",";

	#BRANCH
	empty();

	#REGION
	empty();

	#STATUS
	$command='cat /esp/esp_projects/'.$domain.'/*.pid';
	$PID=`$command`;
	chomp $PID;
	$PROCS=`ps -ef | grep $PID | grep -v grep | wc -l`;
	if ($PROCS >0) {
		print 'ACTIVE,';
	} else {
		print 'DOWN,';
	}

	#END
	print "\n";
}

sub empty {
	print '"",'; 
}
