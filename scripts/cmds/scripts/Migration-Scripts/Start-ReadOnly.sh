#!/usr/bin/bash

for i in `/esp/bin/findInstances.sh  | grep 1105 | awk '{print $1}' | perl -ne 's/[a-z]+\.pid://i && print'`; do
	cd $i; 
	kill -9 `cat *.pid`; 
	~/scripts/Deploy-ReadOnly.sh ; 
	sleep 1; 
	./start*; 
done;