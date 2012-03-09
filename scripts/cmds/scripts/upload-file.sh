#!/usr/bin/bash
if [[ -z $4 ]];
then
        echo "Usage: <local file> <username> <list of servers as file> <remote destination>";
        exit 1;
fi
LOCAL_FILE=$1;
REMOTE_DEST=$4;
USER_NAME=$2;
SERVER_LIST=$3;
for i in `cat $SERVER_LIST`; do 
	echo "scp -i ~/.ssh/id_rsa -r $LOCAL_FILE $USER_NAME@$i:$REMOTE_DEST ";
	if [[ $5 == "b" ]];
        then
                echo "background"
		yes yes | scp -i ~/.ssh/id_rsa -qr $LOCAL_FILE $USER_NAME@$i:$REMOTE_DEST &
        else

		yes yes | scp -i ~/.ssh/id_rsa -r $LOCAL_FILE $USER_NAME@$i:$REMOTE_DEST 
	fi
	echo "======================================";
done;