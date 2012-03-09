#!/usr/bin/bash

. config/config.sh
. config/migration-functions.sh

printBegin;

cd $BASE_PROJECT_DIR

ls -d *_$TO > /tmp/instances.$$

echo "Clear old pid files"
find *_$TO -name "*.pid" -print -exec rm {} \;

echo "Cleanup old configs..."
find *_$TO -name "*.xml.*" -exec rm {} \; 
find *_$TO -name "*.sh.*" -exec rm {} \; 
find *_$TO -name "*.properties.*" -exec rm {} \;
find *_$TO -name "*.bak.*" -type f -exec rm {} \;

#Find all files containing old path
echo "Fix file paths..."
find *_$TO -type f -exec grep -l "_$FROM" {} \; > /tmp/fix-path.$$

#Replace old path with new path
for i in `cat /tmp/fix-path.$$ `; do 
	echo "Migrating $i...";
	echo $i >> /tmp/file-count.$$;  
	sed "s/$FROM/$TO/g" $i > /tmp/foo.$$;  
	mv /tmp/foo.$$ $i; 
done
echo `wc -l /tmp/fix-path.$$  | awk '{print $1}'`" files fixed";

#Generate Clear Cache Script
for i in `cat /tmp/instances.$$`; do
	echo "Clearing $i cache...";
	generateClearCache $i;
done;

rm /tmp/*.$$

printEnd;