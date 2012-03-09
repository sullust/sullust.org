#!/usr/bin/bash

stopPidgin() {
	echo "Stopping Pidgin"
	killall pidgin

}

startPidgin() {
	echo "Starting Pidgin: `date`"
	/usr/bin/pidgin
}

wipePidgin() {
	stopPidgin
	sleep 10
	echo "Wiping out the accounts"
	if [ ! -e /tmp/accounts.xml ]; then
		mv /home/jainswor/.purple/accounts.xml /tmp
	else 
		if [ -z `grep meanwhile /tmp/accounts.xml` ]; then
			echo "accounts.xml is already on the desktop, I don't want to wipe out a good file";
			echo "you may want to move that file to /home/jainswor/.purple/accounts.xml and re-run the script";
			exit 1;
		else 
			rm /home/jainswor/.purple/accounts.xml;
		fi
	fi
	startPidgin &
	sleep 10
	stopPidgin
}

restoreAccounts() {
	mv /tmp/accounts.xml /home/jainswor/.purple/accounts.xml
}

stopPidgin;
while [[ 1 -eq 1 ]]; do 
	#wipePidgin
	sleep 10
	#echo "Pidgin has been cleaned.  Starting fresh.";
	#restoreAccounts
	startPidgin 
done;

