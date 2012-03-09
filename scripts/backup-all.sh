#!/usr/bin/bash
FORCE=$1

. /home/jainswor/.profile

HOUR=`date +%H`; 
REMAINDER=`expr $HOUR % 4`; 
DATE=`date +%m%d`;

if [[ $HOUR -eq 6 || $FORCE == "-f" ]]; then
	/home/jainswor/scripts/backup-disk.sh
	/home/jainswor/scripts/backup-sd.sh
fi;

/home/jainswor/scripts/backup-dropbox.sh
