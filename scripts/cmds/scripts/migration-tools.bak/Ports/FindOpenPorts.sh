#!/usr/bin/bash
port=7001
while [[ $port -lt 9010 ]]; do
        #listeners=`lsof -i tcp:$port | wc -l`;
        $WORKING_DIR/Ports/OpenSocket.pl localhost $port>/dev/null 2>&1;
        RESULT=$?;
        if [[ ! $RESULT -eq 0 ]]; then
                echo "$port";
        fi
        if [[ $port -eq 7010 || $port -eq 8010 ]]; then
                port=`expr $port + 990`;
        fi
        port=`expr $port + 1`;
done;
		