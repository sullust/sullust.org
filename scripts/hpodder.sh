#!/usr/bin/bash

pid=/var/run/vpnc/pid
PID="$(cat "$pid" 2> /dev/null)"
echo $PID;

#if [ -z "$PID" ]; then
	/usr/bin/hpodder fetch
#else
#	echo "too slow"
#fi	
