#!/usr/bin/bash

if [[ -z $2 ]];
then
	echo "Usage: <username> <destination-server>";
	exit 1;
fi

#ssh $1@$2 "mkdir -p /home/$1/scripts/migration-tools"

chmod -R 755 ./*
rsync --exclude="CVS" -av -e "ssh" ./* $1@$2:/home/$1/scripts/migration-tools/
