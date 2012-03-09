#!/usr/bin/bash

. /home/jainswor/.profile

echo "============= BEGIN BACKUP TO DISK: `date` =============";

/usr/bin/rsync -avr --delete /home/jainswor /media/backup/
echo "============= BACKUP COMPLETE: `date` =============";
