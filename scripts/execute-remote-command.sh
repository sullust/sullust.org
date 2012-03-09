#!/bin/bash

if [[ -z $3 ]];
then
	echo "Usage: <username> <list of servers as file> <command>";
	exit 1;
fi

for i in `cat $2`; do 
	echo "/usr/bin/ssh $1@$i \"$3\"";
	echo -n "($i):  ";
	if [[ $4 == "b" ]]; 
	then
		echo "background"
		/usr/bin/ssh $1@$i "$3" &
	else
		/usr/bin/ssh $1@$i "$3";
	fi
	echo "*********====================*********";
done;
