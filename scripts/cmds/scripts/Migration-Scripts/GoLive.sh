#!/usr/bin/bash


if [[ $# -lt 2 ]]; then
	echo "You must specify the from and to release numbers";
	exit 1;
fi

FROM=$1;
TO=$2;

/esp/bin/findInstances.sh refresh

for i in `/esp/bin/findInstances.sh  | grep $FROM | awk '{print $2}'`; do
	kill -9 $i;
done;

echo "Should not be any old weblogic running:"
/esp/bin/findInstances.sh
sleep 5;


for i in `/esp/bin/findInstances.sh  | grep $TO | awk '{print $1}' | perl -ne 's/[a-z]+\.pid://i && print'`; do
	cd $i; 
	kill -9 `cat *.pid`; 

	OLD_BASE=`echo $i | sed "s/$TO/$FROM/g"`;

	echo "Copying from $OLD_BASE to $i"
	cp $OLD_BASE/config/config.xml ./config/config.xml.rw;
	sed "s/$FROM/$TO/g" config/config.xml.rw > /tmp/foo; 
	mv /tmp/foo config.config.xml.rw

	cp $OLD_BASE/properties/espws.properties properties/;

	sed 's/SEND_EMAIL=0/SEND_EMAIL=1/' esp.properties > /tmp/foo
	mv /tmp/foo esp.properties
	
	echo "Gathering read/write files";
	find . -name "*.rw" > /tmp/rw-files

	for i in `cat /tmp/rw-files | grep -v esp.properties | grep -v tools.properties`; do 
		base_name=`echo $i | sed "s/\.rw\$//"`;
		echo "$i -> $base_name";
		cp $i $base_name;
	done;

	chmod 755 start*;
	chmod 755 bin/*;
	sleep 1; 
	if [[ -e startesp ]]; then
		./startesp >/dev/null;
	fi;
	if [[ -e startespws ]]; then
		./startespws >/dev/null;
	fi
	if [[ -e starttools ]]; then 
		./starttools >/dev/null;
	fi
done;



