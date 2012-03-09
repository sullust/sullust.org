#!/usr/bin/bash

WORKING_DIR=$0;
WORKING_DIR=`echo $WORKING_DIR | perl -ne 's/([a-z]|-)+.sh//i && print'`

export WORKING_DIR

cd $WORKING_DIR;
echo "Working Directory: $WORKING_DIR";

if [[ -z config/config.xh ]]; then
	echo "Cannot continue without config.sh"
	exit 1;
fi;
. config/config.sh
. config/migration-functions.sh


if [[ $1 != "noclean" ]]; then
	echo "Cleaning existing directories";
	cd $BASE_PROJECT_DIR
	for i in `ls -d *_$TO 2>/dev/null`; do 
		echo "Deleting $i...";
		rm -Rf $i;
		rmdir $i 2>/dev/null

		if [[ ! -z `echo $i | grep espws` ]]; then
			echo "Deleteing archive/$i...";
			rm -Rf archive/$i;
			rmdir archive/$i 2>/dev/null;
		fi

	done;
	cd $WORKING_DIR
else 
	echo "Proceeding with unclean migration.  Problems are likely.  Proceed with caution."
	export NOCLEAN=1;
fi

doCopy;
doPathFix;

if [[ $MAKE_SOURCE_READ_ONLY == "true" ]]; then
	doMakeReadOnly
	doDeployReadOnly;
fi

if [[ $IS_SHAKEOUT == "true" ]]; then
	doPrepareShakeout;
	doDeployShakeout;
fi