#!/usr/bin/bash

while true; do
	pid=/var/run/vpnc/pid

	PID="$(cat "$pid" 2> /dev/null)"

	if [ -z "$PID" ]; then
		echo "`date`: Not Running";
		/usr/bin/zenity --question --text="VPNC is not running, would you like to start it?" --cancel-label="No" --ok-label="Yes";
		RESPONSE=$?
		if [ $RESPONSE -eq 0 ] ; then
			gksu /usr/local/bin/vpnc-connect
			exit 0;
		else 
			exit 0;
		fi
	else 
		echo "`date`: Running";
	fi
	sleep 30
done;
