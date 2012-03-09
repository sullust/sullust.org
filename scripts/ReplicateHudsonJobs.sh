#!/usr/bin/bash

OLD_ESP=7007
NEW_ESP=8007

OLD_TOOLS=7003
NEW_TOOLS=8003

OLD_ESPWS=7005
NEW_ESPWS=8005

OLD_MONTH=November
NEW_MONTH=January

for i in `ls -d *$OLD_MONTH* | grep -v Publish`; do 
	echo $i; 
done;
