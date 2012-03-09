#!/usr/bin/bash

if [ -z `grep -l 'nameserver 166' /etc/resolv.conf` ]; then
	cp /home/jainswor/scripts/vpn/connect-esputils.sh /home/jainswor/connect.sh
else 
	cp /home/jainswor/scripts/vpn/connect-cmds.sh /home/jainswor/connect.sh
fi


