#!/usr/bin/bash

df > /tmp/df

for i in `ls /`; do 
	if [[ -z `grep $i'[^\/]' /tmp/df` ]]; then
		find $i -type f -size +100000000c -exec ls -lh {} \;
	fi
done;	
