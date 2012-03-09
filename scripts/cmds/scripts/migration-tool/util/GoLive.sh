#!/usr/bin/bash

if [[ -z $WORKING_DIR ]]; then
	WORKING_DIR=$0;
	WORKING_DIR=`echo $WORKING_DIR | perl -ne 's/([a-z]|-)+.sh//i && print'`

	export WORKING_DIR

	cd $WORKING_DIR/../;
else 
	cd $WORKING_DIR;
fi

. config/config.sh
. config/migration-functions.sh

printBegin;

cd $BASE_PROJECT_DIR
#
#esp/bin/findInstances.sh refresh
#
#for i in `/esp/bin/findInstances.sh  | grep $FROM | awk '{print $2}'`; do
#	kill -9 $i;
#done;

#echo "Should not be any old weblogic running:"
#/esp/bin/findInstances.sh
#sleep 5;


for i in `ls -d *_$TO`; do
	cd $i; 

	PID=`ps -ef | grep \`cat *.pid\` | grep -v grep`;
	#if [[ -n $PID ]]; then
	#	echo "Killing process in $i...";
	#	kill -9 `cat *.pid`; 
	#fi;
		
	echo "Gathering read/write files";
	find . -name "*.rw" > /tmp/rw-files.$$

	for i in `cat /tmp/rw-files.$$`; do
		base_name=`echo $i | sed "s/\.rw\$//"`;
		echo "$i -> $base_name";
		cp $i $base_name;
	done;

	chmod -R 755 ./* 2>/dev/null
	find . -name ssl -type d -exec chmod -R 700 {} \;
	
	if [[ -e startesp ]]; then
		./startesp >/dev/null;
	fi;
	if [[ -e startespws ]]; then
		./startespws >/dev/null;
	fi
	if [[ -e starttools ]]; then 
		./starttools >/dev/null;
	fi
	cd ../
done;

printEnd;
