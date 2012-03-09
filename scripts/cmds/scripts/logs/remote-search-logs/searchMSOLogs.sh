#!/usr/bin/bash

if [[ -z $4 ]];
then
	echo "Usage: <user> <server-list-file> <log-path> <search-term>";
	exit 1;
fi

USER=$1;
SERVER_LIST=$2;
REMOTE_PATH=$3;
TERM=$4;

PORT=7023

for i in `cat $SERVER_LIST`; do
	SERVER=$i;

	ssh -f -g -N -l $USER -L $PORT:$SERVER:22 pdcc01-cmds1.mso.mci.com >/dev/null 2>&1
	
	echo "Searching for $TERM in $REMOTE_PATH on $SERVER";
	echo '--------------------------------------------------------------------------------';

	ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -l $USER -p$PORT $USER@$localhost "grep -l $TERM $REMOTE_PATH/*";

	PID=`ps -ef | grep $PORT | grep -v grep | grep ssh | awk '{print $2}'`;
	kill $PID;

	echo "--------------------------------------------------------------------------------";
	echo "--------------------------------------------------------------------------------";
done
