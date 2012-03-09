#!/bin/bash

function initializesudo() {
	sudo hostname >/dev/null 2>&1;
}

function pidgin() { 
	killall pidgin
	/home/jainswor/scripts/startup/startPidgin.sh >/dev/null 2>&1 
}

function dns() {
	sudo /home/jainswor/scripts/vpn/setresolve.sh >/dev/null 2>&1
}

function tomboy() { 
	killall tomboy;
	sleep 1;
	/usr/bin/tomboy >/dev/null 2>&1
}

function xchat() {
	killall xchat-gnome;
	sleep 1;
	/usr/bin/xchat-gnome >/dev/null 2>&1
}

function encrypted() {
	sudo /usr/bin/truecrypt -d
	sudo /home/jainswor/scripts/startup/mountEncryptedVolumes.sh
}

function evolution() {
	/usr/bin/evolution --force-shutdown
}

function sethosts() {
	sudo /home/jainswor/scripts/vpn/sethosts.sh;
}

function setconnect() { 
	/home/jainswor/scripts/vpn/setconnect.sh;
}

function sshmounts() {
	/home/jainswor/scripts/startup/ssh-mounts.sh;
}

function limited() {
	initializesudo;
	sethosts;
	dns;
	#setconnect;
	#evolution 
	#encrypted;
	#tomboy
	sshmounts 
	#xchat 
	echo 100000 | sudo tee /proc/sys/fs/inotify/max_user_watches
}

function complete() {
	limited;
	#pidgin & 
}

date;

if [[ -n `ps -ef | grep ncsvc | grep -v grep` ]]; then
	echo "VPN Running";

	if [[ ! -e /tmp/start-network-run ]]; then
	 echo "Running network startup: `date`" 
	 #date > /tmp/start-network-run
       	 complete
	else
       	 echo "Startup already run...";
	fi
else
	echo "VPN Not Running";
fi;
#/usr/bin/zenity --question --text="Do you want to start/restart all network tools (including Pidgin)?" --cancel-label="No" --ok-label="Yes";
#RESPONSE=$?
#if [ $RESPONSE -eq 0 ] ; then
#	complete;
#else
#	/usr/bin/zenity --question --text="Do you want to start/restart the limited set (excluding Pidgin)?" --cancel-label="No" --ok-label="Yes";
#	RESPONSE=$?
#	if [ $RESPONSE -eq 0 ] ; then
#		limited;
#	fi
#fi

exit 0;
