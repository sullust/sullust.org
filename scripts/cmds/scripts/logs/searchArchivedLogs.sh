#!/usr/bin/bash

TERM=$1

for i in `find . -mtime -2 -type f `; do 
	RESULTS=`gunzip -c $i | grep -l $TERM`; 
	echo -n "$i: ";

	if [[ -z $RESULTS ]]; then
		echo "N/A";
	else
		echo "MATCH";
	fi
done;