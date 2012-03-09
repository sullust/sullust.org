#!/usr/bin/perl

my $parentPid = `cat /esp/snmcpe_prod_108/jboss-5.1.0.GA/bin/snmcpe.pid`;

my @procs =  `ps -eo ppid,pid,etime | grep $parentPid`;

foreach my $proc(@procs) { 
        $proc =~ s/\n//gi;
        $proc =~ s/ +/ /gi;
        $proc =~ s/^ //;
        my ($ppid,$pid,$etime) = split(/ /, $proc);

        my ($HOUR, $MINUTE, $SECOND) = split(/:/, $etime);

        if($ppid == $parentPid && (($HOUR > 0 && $SECOND =~ m/./) || $MINUTE > 15 ) || $etime == '-') {
                
                print "Killing process: $pid\n";
                print "Age: $etime\n";
                print `ps -p $pid -o args`;
                `kill -9 $pid`;
                print "======================\n";
        }
}
