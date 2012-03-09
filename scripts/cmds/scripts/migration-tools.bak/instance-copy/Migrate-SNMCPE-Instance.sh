#!/usr/bin/bash

. config/config.sh
. config/migration-functions.sh

if [[ $# -lt 2 ]]; then
	echo "You must specify the from and to release numbers";
	exit 1;
fi

FROM=$1;
TO=$2;

cd /esp/
rm /tmp/instances
ls -d *_$FROM > /tmp/instances

echo "Cleanup old configs..."
find . -name "startSNMCPE.sh.*" -print -exec rm {} \;

#Find all files containing old path
echo "Fix file paths"
find *_$TO -type f -exec grep -l "_$FROM" {} \; > /tmp/fix-path

#Replace old path with new path
for i in `cat /tmp/fix-path `; do 
	echo $i;  
	sed "s/$FROM/$TO/g" $i > /tmp/foo;  
	mv /tmp/foo $i; 
done

#Remove all old pid files
find *_$TO -name "*.pid"
