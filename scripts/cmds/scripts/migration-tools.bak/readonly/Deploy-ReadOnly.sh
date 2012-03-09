#!/usr/bin/bash

. config/config.sh
. config/migration-functions.sh

printBegin;

cd $BASE_PROJECT_DIR

echo "Gathering read only files";
find *_$FROM -name "*.ro" > /tmp/ro-files.$$

for i in `cat /tmp/ro-files.$$`; do 
	base_name=`echo $i | sed "s/\.ro\$//"`;
	echo "Copying $i -> $base_name";
	cp $i $base_name;
done;

rm /tmp/*.$$

printEnd;