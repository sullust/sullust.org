#!/usr/bin/bash


function mountencryption() {
        /usr/bin/truecrypt --keyfiles=/home/jainswor/Dropbox/hands.key --non-interactive /dev/mmcblk0p1 >/dev/null 2>&1;
##################################
#        /usr/bin/truecrypt --keyfiles=/home/jainswor/Dropbox/hands.key --non-interactive /home/jainswor/encrypted/Documents >/dev/null 2>&1 ;
#        /usr/bin/truecrypt --keyfiles=/home/jainswor/Dropbox/hands.key --non-interactive /home/jainswor/encrypted/workspaces >/dev/null 2>&1 ;
#	/usr/bin/truecrypt --keyfiles=/home/jainswor/Dropbox/hands.key --non-interactive /home/jainswor/encrypted/workspaces2 >/dev/null 2>&1;
##################################
}

function closeWindows() {
#	wmctrl -c `wmctrl -l | grep TUF | sed 's/.*laptop //'`
#        wmctrl -c `wmctrl -l | grep truecrypt1 | sed 's/.*laptop //'`
#        wmctrl -c `wmctrl -l | grep truecrypt2 | sed 's/.*laptop //'`
wmctrl -c "TUF - File Browser"
wmctrl -c "truecrypt1 - File Browser"
wmctrl -c "truecrypt2 - File Browser"
}


if [ -e /home/jainswor/Dropbox/hands.key ] 
then
	mountencryption;
else
	echo "Trying to mount TUF";
#	mkdir /media/TUF 2>/dev/null; 
#	mount -t vfat /dev/sdb1 /media/TUF 2>/dev/null
	if [ -e /home/jainswor/Dropbox/hands.key ]
	then
#		/usr/bin/truecrypt -d /home/jainswor/encrypted/Documents
#		/usr/bin/truecrypt -d /home/jainswor/encrypted/workspaces
#		/usr/bin/truecrypt -d /home/jainswor/encrypted/workspaces2
		/usr/bin/truecrypt -d /dev/mmcblk0p1
		mountencryption;
		closeWindows;
	else
		/usr/bin/zenity --info --text="Unable to find encryption keyfile";
	fi
fi
