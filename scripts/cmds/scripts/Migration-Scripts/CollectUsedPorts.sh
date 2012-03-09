#!/usr/bin/bash

if [[ $# -lt 2 ]]; then
	echo "You must specify the from and to release numbers";
	exit 1;
fi

FROM=$1;
TO=$2;

for i in `sudo find *_$TO -name config.xml`; do 
	echo "$i: "; 
	grep listen-port $i | sed 's/.*<listen-port>//' | sed 's/<.*//'; 
done;

