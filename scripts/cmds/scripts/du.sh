#!/usr/bin/bash

df > /tmp/df

for i in `ls /`; do 
	if [[ -z `grep $i'[^\/]' /tmp/df` ]]; then
		du -hs /$i
	fi
done;	
