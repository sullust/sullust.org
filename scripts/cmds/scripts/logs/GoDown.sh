#!/usr/bin/bash

HERE=`pwd | sed 's/.*\///'`;
LAST=""

for i in `ls ../`; do 
	if [[ "$i" == "$HERE" ]]; then 
		echo "cd ../$LAST"
	fi
	LAST=$i;
done;
	