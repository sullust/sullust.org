#!/usr/bin/bash


if [[ $# -lt 2 ]]; then
	echo "You must specify the from and to release numbers";
	exit 1;
fi

FROM=$1;
TO=$2;

for i in `/esp/bin/findInstances.sh  | grep $FROM | awk '{print $1}' | perl -ne 's/[a-z]+\.pid://i && print'`; do
	I=`echo $i | sed 's/$FROM/$TO/'`;
	cd $I; 
	chmod 755 start*;
	chmod 755 bin/*;
	kill -9 `cat *.pid`; 
	~/scripts/Deploy-Shakeout.sh ; 
	sleep 1; 
	./start*; 
done;