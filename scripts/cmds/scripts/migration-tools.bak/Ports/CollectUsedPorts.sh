#!/usr/bin/bash

if [[ -z $WORKING_DIR ]]; then
	WORKING_DIR=$0;
	WORKING_DIR=`echo $WORKING_DIR | perl -ne 's/([a-z]|-)+.sh//i && print'`

	export WORKING_DIR

	cd $WORKING_DIR/../;
else 
	cd $WORKING_DIR;
fi
. config/config.sh;
. config/migration-functions.sh;

cd $BASE_PROJECT_DIR;

for i in `find *_$FROM -name config.xml`; do 
	#echo "$i: "; 
	grep '<listen-port>' $i | sed 's/.*<listen-port>//' | sed 's/<.*//'; 
done;

