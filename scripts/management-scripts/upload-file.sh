#!/bin/bash
if [[ -z $4 ]];
then
        echo "Usage: <local file> <username> <list of servers as file> <remote destination>";
        exit 1;
fi
LOCAL_FILE=$1;
REMOTE_DEST=$4;
USER_NAME=$2;
SERVER_LIST=$3;

scp -r $LOCAL_FILE jainswor@pdcc01-cmds1.mso.mci.com:~/staging/;
CMDS_FILE=`echo $LOCAL_FILE | sed 's/.*\//\/home\/jainswor\/staging\//g'`

for i in `cat $SERVER_LIST`; do 
	echo "scp -r $LOCAL_FILE $USER_NAME@$i:$REMOTE_DEST ";
#	if [[ $5 == "b" ]];
#        then
#                echo "background"
#		scp -qr $LOCAL_FILE $USER_NAME@$i:$REMOTE_DEST &
#        else
		SCP_COMMAND="scp -r $CMDS_FILE $USER_NAME@$i:$REMOTE_DEST"
		echo "ssh jainswor@pdcc01-cmds.mso.mci.com \"$SCP_COMMAND\""
		ssh jainswor@pdcc01-cmds1.mso.mci.com "$SCP_COMMAND"
#	fi
	echo "======================================";
done;
