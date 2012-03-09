#!/usr/bin/bash

. config/config.sh
. config/migration-functions.sh

printBegin;

cd $BASE_PROJECT_DIR/archive

echo "Copying ESPWS Archive Directories"

SRVEAR=`find . -name espwssrv.ear | head -1`;
for i in `ls -d *$FROM`; do 
	I=`echo $i | sed "s/$FROM/$TO/"`;
	mkdir -p $I;
	echo "Copy $SRVEAR -> $I/espwssrv.ear";
	cp $SRVEAR $I/espwssrv.ear;
	for ii in `ls -tr $i | tail -1`; do 
		echo "Copy $i/$ii -> $I/";
		cp $i/$ii $I/;
	done; 
done;

printEnd;