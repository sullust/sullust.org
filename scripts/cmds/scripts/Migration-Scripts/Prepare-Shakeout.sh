#!/usr/bin/bash

. config/config.sh
. ~/scripts/migration-functions.sh

if [[ $# -lt 2 ]]; then
	echo "You must specify the from and to release numbers";
	exit 1;
fi

FROM=$1;
TO=$2;
IMPORT_PORT_MAP=$3;

BASE_PROJECT_DIR=/esp/esp_projects

cd $BASE_PROJECT_DIR

rm /tmp/instances
ls -d *_$FROM > /tmp/instances

echo "Clear old pid files"
find *_$TO -name "*.pid" -print -exec rm {} \;

echo "Cleanup old configs..."
find . -name "*.xml.*" -print -exec rm {} \; 
find . -name "*.sh.*" -print -exec rm {} \; 
find . -name "*.properties.*" -print -exec rm {} \;
find . -name "*.bak.*" -type f -print -exec rm {} \;


echo "Creating fresh shakeout configs"
echo "Cleaning old configs..."

find *_$TO -name "*.shk*" -print -exec rm {} \;
find *_$TO -name esp.properties > /tmp/props
find *_$TO -name espws.properties >>/tmp/props



#Turn off email
for i in `cat /tmp/props `; do 
	echo "Creating $i.shk"; 
	sed 's/SEND_EMAIL=1/SEND_EMAIL=0/' $i > /tmp/prop;  
	mv /tmp/prop $i.shk; 
done;

#Lower memory usage
for i in `find *_$TO -name "start*.sh" -exec grep -l Xmx {} \;`; do 
	sed 's/-Xms.*m -Xmx....m/-Xms512m -Xmx512m/' $i > /tmp/mem;  
	cp /tmp/mem $i.shk;  
	cp $i $i.rw;  
	chmod 755 $i*; 
done; 

for i in `find *_$TO -name config.xml`; do 
	echo "Creating $i.shk"; 
	cp $i $i.shk; 
done;

#Set Shakeout Ports
rm /tmp/port-map
if [[ $IMPORT_PORT_MAP -eq 1 ]]; then
		scp -i /home/jainswor/.ssh/id_rsa jainswor@pdcc01-cmds1.mso.mci.com:~/staging/port-map /tmp/; 
else
		touch /tmp/port-map
fi

echo "Setting Shakeout Ports";
collectOpenPorts /tmp/open-ports
~/scripts/MapPorts.pl /tmp/open-ports /tmp/port-map $FROM $TO

if [[ $IMPORT_PORT_MAP -eq 1 ]]; then
	scp -i /home/jainswor/.ssh/id_rsa /tmp/port-map jainswor@pdcc01-cmds1.mso.mci.com:~/staging/
fi

#Final Cleanup
echo "Final Cleanup"
find . -name "*.xml.*.*" -print -exec rm {} \; 
find . -name "*.sh.*.*" -print -exec rm {} \; 
find . -name "*.properties.*.*" -print -exec rm {} \;