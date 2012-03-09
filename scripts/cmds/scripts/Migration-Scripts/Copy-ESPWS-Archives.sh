#!/usr/bin/bash

. config/config.sh

if [[ $# -lt 2 ]]; then
	echo "You must specify the from and to release numbers";
	exit 1;
fi

FROM=$1;
TO=$2;

BASE_PROJECT_DIR=/esp/esp_projects

cd $BASE_PROJECT_DIR/archive

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