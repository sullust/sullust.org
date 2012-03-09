#!/usr/bin/bash

. /home/jainswor/.profile

echo "============= BEGIN BACKUP TO DROPBOX: `date` =============";
/usr/bin/rsync --delete -avr --files-from=/home/jainswor/.backup-dropbox /home/jainswor/ /home/jainswor/Dropbox/Justin/VzB/Backup/
echo "============= BACKUP COMPLETE: `date` =============";
