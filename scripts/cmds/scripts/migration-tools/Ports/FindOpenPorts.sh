#!/usr/bin/bash
if [[ -z $WORKING_DIR ]]; then
        WORKING_DIR=$0;
        WORKING_DIR=`echo $WORKING_DIR | perl -ne 's/([a-z]|-)+.sh//i && print'`

        WORKING_DIR=`echo $WORKING_DIR | sed 's/Ports\/$//'`;

        export WORKING_DIR

        cd $WORKING_DIR

        
else 
        cd $WORKING_DIR;
fi

. config/config.sh
. config/migration-functions.sh

port=7001
while [[ $port -lt 9010 ]]; do
        #listeners=`lsof -i tcp:$port | wc -l`;
        $WORKING_DIR/Ports/OpenSocket.pl `hostname` $port>/dev/null 2>&1;
        RESULT=$?;
        if [[ $RESULT -gt 0 ]]; then
                echo "$port";
        fi
        if [[ $port -eq 7010 || $port -eq 8010 ]]; then
                port=`expr $port + 990`;
        fi
        port=`expr $port + 1`;
done;
		