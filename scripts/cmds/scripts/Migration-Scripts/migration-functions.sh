#!/usr/bin/bash

function collectOpenPorts {
		OUTFILE=$1;
		rm $OUTFILE
		
		port=7001
		while [[ $port -lt 9010 ]]; do
				listeners=`lsof -i tcp:$port | wc -l`;
				if [[ $listeners -eq 0 ]]; then
						echo "$port" >> $OUTFILE;
				fi
				if [[ $port -eq 7010 || $port -eq 8010 ]]; then
						port=`expr $port + 990`;
				fi
				port=`expr $port + 1`;
		done;
}