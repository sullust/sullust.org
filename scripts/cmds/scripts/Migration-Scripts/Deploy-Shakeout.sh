#!/usr/bin/bash

echo "Gathering shakeout files";
find . -name "*.shk" > /tmp/shk-files

for i in `cat /tmp/shk-files`; do 
	base_name=`echo $i | sed "s/\.shk\$//"`;
	echo "$i -> $base_name";
	cp $i $base_name;
done;