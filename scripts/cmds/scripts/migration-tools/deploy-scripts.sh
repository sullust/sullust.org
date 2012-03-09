#!/usr/bin/bash

if [[ -z $2 ]];
then
	echo "Usage: <username> <destination-server>";
	exit 1;
fi

ssh $1@$2 "mkdir -p /home/$1/scripts/migration-tools" >/dev/null 2>&1

chmod -R 755 ./*
rsync --delete --exclude="CVS" -av -e "ssh" ./* $1@$2:/home/$1/scripts/migration-tools/
