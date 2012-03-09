#!/usr/bin/bash

if [[ -z $WORKING_DIR ]]; then
	WORKING_DIR=$0;
	WORKING_DIR=`echo $WORKING_DIR | perl -ne 's/\/[a-z]+\/([a-z]|-)+\.sh$//i && print'`

	export WORKING_DIR

	echo $WORKING_DIR

	cd $WORKING_DIR/;
else 
	cd $WORKING_DIR;
fi

. config/config.sh
. config/migration-functions.sh

printBegin;

cd $BASE_PROJECT_DIR

echo "Gathering shakeout files";
find *_$TO -name "*.shk" > /tmp/shk-files.$$

for i in `cat /tmp/shk-files.$$`; do 
	base_name=`echo $i | sed "s/\.shk\$//"`;
	echo "Copying $i -> $base_name";
	cp $i $base_name;
done;

rm /tmp/*.$$

printEnd;