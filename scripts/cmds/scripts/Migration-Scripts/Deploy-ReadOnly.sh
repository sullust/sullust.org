#!/usr/bin/bash

echo "Gathering read only files";
find . -name "*.ro" > /tmp/ro-files

for i in `cat /tmp/ro-files`; do 
	base_name=`echo $i | sed "s/\.ro\$//"`;
	echo "$i -> $base_name";
	cp $i $base_name;
done;