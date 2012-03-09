#!/usr/bin/bash

. config/config.sh

if [[ $# -lt 2 ]]; then
	echo "You must specify the from and to release numbers";
	exit 1;
fi

FROM=$1;
TO=$2;

BASE_PROJECT_DIR=/esp/esp_projects

cd $BASE_PROJECT_DIR

rm /tmp/instances
ls -d *_$FROM > /tmp/instances

echo "Clear old pid files"
find *_$TO -name "*.pid" -print -exec rm {} \;

echo "Cleanup old configs..."
find *_$TO -name "*.xml.*" -print -exec rm {} \; 
find *_$TO -name "*.sh.*" -print -exec rm {} \; 
find *_$TO -name "*.properties.*" -print -exec rm {} \;
find *_$TO -name "*.bak.*" -type f -print -exec rm {} \;

#Find all files containing old path
echo "Fix file paths"
find *_$TO -type f -exec grep -l "_$FROM" {} \; > /tmp/fix-path

#Replace old path with new path
for i in `cat /tmp/fix-path `; do 
	echo $i;  
	sed "s/$FROM/$TO/g" $i > /tmp/foo;  
	mv /tmp/foo $i; 
done