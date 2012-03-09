#!/usr/bin/bash

HERE=`pwd | sed 's/.*\///'`;
NEXT=0

for i in `ls ../`; do 
	if [[ $NEXT -eq 1 ]]; then
		echo "cd ../$i";
		exit 0;
	fi
	
	if [[ "$i" == "$HERE" ]]; then 
		NEXT=1
	fi
done;
	