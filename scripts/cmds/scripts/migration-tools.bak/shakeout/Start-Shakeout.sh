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

for i in `/esp/bin/findInstances.sh refresh  | grep $FROM | awk '{print $1}' | perl -ne 's/[a-z]+\.pid://i && print'`; do
	I=`echo $i | sed 's/$FROM/$TO/'`;
	cd $I;

	PID=`ps -ef | grep \`cat *.pid\` | grep -v grep`;
	if [[ -n $PID ]]; then
		echo "Killing process in $i...";
		kill -9 `cat *.pid`; 
	fi;
	
	sleep 1; 
	if [[ -e startesp ]]; then
		./startesp;
	fi;
	if [[ -e startespws ]]; then
		./startespws;
	fi
	if [[ -e starttools ]]; then 
		./starttools;
	fi
done;

printEnd;