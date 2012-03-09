#!/usr/bin/bash

if [[ -z $WORKING_DIR ]]; then
	WORKING_DIR=$0;
	WORKING_DIR=`echo $WORKING_DIR | perl -ne 's/\/[a-z]+\/([a-z]|-)+\.sh$//i && print'`

	export WORKING_DIR

	echo $WORKING_DIR

	cd $WORKING_DIR/;
else 
	cd $WORKING_DIR;
fi

. config/config.sh
. config/migration-functions.sh

printBegin;

IMPORT_PORT_MAP=$1;

BASE_PROJECT_DIR=/esp/esp_projects

cd $BASE_PROJECT_DIR

echo "Clear old pid files"
find *_$TO -name "*.pid" -print -exec rm {} \;

echo "Collect Properties Files..."
find *_$TO -name esp.properties > /tmp/props.$$
find *_$TO -name espws.properties >>/tmp/props.$$

for i in `cat /tmp/props.$$`; do  cp $i $i.rw; done;

echo "Generating Shakeout Properties Files for..."
cat /tmp/props.$$

#Turn off email
for i in `cat /tmp/props.$$ `; do 
	sed "s/SEND_EMAIL=1/SEND_EMAIL=0/" $i > /tmp/prop.$$;
	mv /tmp/prop.$$ $i.shk; 
done;

#Lower memory usage
for i in `find *_$TO -name "start*.sh" -exec grep -l Xmx {} \;`; do 
	cp $i $i.rw;  
	sed 's/^MEM_ARGS.*/MEM_ARGS="-Xms512m -Xmx512m"/' $i > /tmp/mem.$$
	mv /tmp/mem.$$ $i.shk;  
done; 

for i in `find *_$TO -name config.xml`; do 
	cp $i $i.shk; 
	cp $i $i.rw;
done;

#Set Shakeout Ports
echo "Setting Shakeout Ports...";
if [[ $IMPORT_PORT_MAP -eq 1 ]]; then
		scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /home/jainswor/.ssh/id_rsa jainswor@pdcc01-cmds1.mso.mci.com:~/staging/port-map /tmp/port-map.$$;
else
		if [[ -e /tmp/port-map.$$ ]]; then
			rm /tmp/port-map.$$
		fi

		touch /tmp/port-map.$$
fi

$WORKING_DIR/Ports/FindOpenPorts.sh > /tmp/open-ports.$$
$WORKING_DIR/Ports/CollectUsedPorts.sh | sort -u > /tmp/used-ports.$$
$WORKING_DIR/Ports/MapPorts.pl /tmp/open-ports.$$ /tmp/port-map.$$

if [[ $IMPORT_PORT_MAP -eq 1 ]]; then
	scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /home/jainswor/.ssh/id_rsa /tmp/port-map.$$ jainswor@pdcc01-cmds1.mso.mci.com:~/staging/port-map
fi

echo "Fix File Permissions..."
chmod -R 755 *_$TO 2>/dev/null
find *_$TO -name ssl -type d -exec chmod -R 700 {} \;

#Final Cleanup
echo "Final Cleanup"
find . -name "*.xml.*.*" -exec rm {} \; 
find . -name "*.sh.*.*" -exec rm {} \; 
find . -name "*.properties.*.*" -exec rm {} \;

rm /tmp/*.$$

printEnd;