#!/usr/bin/perl
use strict;

#FILE AGE IS IN MINUTES
my $FILE_AGE_LIMIT=90;
my $CME_LOGS_DIR="/esp/snmcpe/cmerecords/new";
my $CURRENT_TIME=time;

my @files = `ls $CME_LOGS_DIR/IPCC*`;

foreach my $file(@files) {
        $file =~ s/\n//gi;
        #print "$file\n";
        my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,$blksize,$blocks)=stat("$file");
        #print "Modified time: $mtime\n";       
        my $delta = ($CURRENT_TIME - $mtime);
        if($delta > ($FILE_AGE_LIMIT * 60)) {
                print "Delete file $file\n";
        }
}

