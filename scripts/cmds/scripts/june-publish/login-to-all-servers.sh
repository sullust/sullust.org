#!/usr/bin/bash

if [[ -z $2 ]];
then
	echo "Usage: <username> <server list file>";
	exit 1;
fi

for i in `cat $2`; do 
	ssh $1@$i;
done;
