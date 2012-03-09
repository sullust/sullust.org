#!/usr/bin/bash

PROPS_FILE=$1
KEYSTORE=$2

SEARCH_COMMAND="grep https $PROPS_FILE | grep -v '^#' | sed 's/\\\\//g' | sed 's/.*https:\/\///g' | sed 's/\/.*//'";
echo $SEARCH_COMMAND;

for p in `grep https $PROPS_FILE | grep -v '^#' | sed 's/\\\\//g' | sed 's/.*https:\/\///g' | sed 's/\/.*//'`; do
	SERVER="";
	PORT="":

	SERVER=`echo $p | awk -F: '{print $1}'`
	PORT=`echo $p | awk -F: '{print $2}'`
	echo "PORT: $PORT";

	if [[ $PORT -eq "" ]]; then
		PORT=443;
	fi

	echo "Adding $SERVER:$PORT"

	./timeout.sh /esp/bin/addCertificateToKeystore.sh $SERVER $PORT $KEYSTORE
done;