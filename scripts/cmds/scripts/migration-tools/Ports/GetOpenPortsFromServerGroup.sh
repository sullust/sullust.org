#!/usr/bin/bash

if [[ $# -lt 2 ]]; then
	echo "Usage: <username> <server-list>";
	exit 1;
fi

SERVER_LIST=`cat $2`;
USERNAME=$1

#echo "Username: $USERNAME"
#echo "Server List: $SERVER_LIST"

COUNT=7001
while [[ $COUNT -lt 9009 ]]; do 
	echo $COUNT >> /tmp/master.ports.$$;
	COUNT=`expr $COUNT + 1`;
	if [[ $COUNT -eq 7010 || $COUNT -eq 8010 ]]; then
				COUNT=`expr $COUNT + 990`;
	fi
done;

for server in $SERVER_LIST; do
	echo "Pulling open ports from $server...";
	ssh $USERNAME\@$server "~/scripts/migration-tools/Ports/FindOpenPorts.sh" > /tmp/$server.ports.$$
	comm -12 /tmp/master.ports.$$ /tmp/$server.ports.$$ > /tmp/tmp.ports.$$;
	mv /tmp/tmp.ports.$$ /tmp/master.ports.$$;
done;


echo "=========================================";

cat /tmp/master.ports.$$;

rm /tmp/*.ports.$$;