#!/usr/bin/bash

for i in `ps -ef | grep sshfs | grep jainswor | grep -v grep | awk '{print $2}'`; do 
	kill -9 $i; 
done;

#sudo mkdir -p /td11 /td6 /td7 /td9 /td10 /cmds /ut /imac /ut-root 2>/dev/null
#sudo chown jainswor:jainswor /td11 /td6 /td7 /td9 /td10 /cmds /ut /imac /ut-root
SERVERS="esputils.vzbi.com 10.0.1.195 esptd11.vzbi.com esptd10.vzbi.com esptd9.vzbi.com esptd8.vzbi.com esptd7.vzbi.com esptd6.vzbi.com"
DEST_PATH="ut imac td11 td10 td9 td8 td7 td6"

for i in $DEST_PATH; do 
	sudo umount /mnt/$i; 
done;

COUNT=1;

for i in $SERVERS; do 
	AWK_VAL='$'$COUNT;
	p=`echo $DEST_PATH | awk "{print $AWK_VAL}"`;
	sudo mkdir -p /mnt/$p 2>/dev/null;
	sudo chown jainswor:jainswor /mnt/$p 2>/dev/null;

	if [[ $p = "ut" || $p = "imac" ]]; then
		COMMAND="sshfs justin@$i:/ /mnt/$p -o reconnect";
		echo $COMMAND;
		$COMMAND;
	else	
		COMMAND="sshfs jainswor@$i:/ /mnt/$p -o reconnect";
		echo $COMMAND;
		$COMMAND;
	fi;
	COUNT=`expr $COUNT + 1`;
done;

#sudo mkdir -p /mnt/imac 2>/dev/null
#sudo mkdir -p /mnt/ut 2>/dev/null

#sudo chown jainswor:jainswor /mnt/imac
#sudo chown jainswor:jainswor /mnt/ut

#sshfs esp@esptd11.vzbi.com:/esp /td11 -o reconnect 
#sshfs esp@esptd6.vzbi.com:/esp /td6 -o reconnect 
#sshfs esp@esptd7.vzbi.com:/esp /td7 -o reconnect 
#sshfs esp@esptd9.vzbi.com:/esp /td9 -o reconnect 
#sshfs esp@esptd10.vzbi.com:/esp /td10 -o reconnect 
#sshfs jainswor@pdcc01-cmds1.mso.mci.com:/home/jainswor /cmds -o reconnect 
#sshfs justin@esputils.vzbi.com:/home/justin /ut -o reconnect 
#sshfs justin@10.0.1.195:/ /imac -o reconnect  &
#sshfs justin@esputils.vzbi.com:/ /mnt/ut -o reconnect &
