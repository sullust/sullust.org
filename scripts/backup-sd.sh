#!/usr/bin/bash

. /home/jainswor/.profile

mkdir -p /tmp/logs


echo "============= BEGIN BACKUP TO SD CARD: `date` =============";
/usr/bin/rsync -avr --delete --files-from=/home/jainswor/.backup-encrypted /home/jainswor /media/sd/
#/usr/bin/rsync --progress --modify-window=432000 -avr --delete -avr /home/jainswor/email /media/sd/

echo "============= BACKUP COMPLETE: `date` =============";
