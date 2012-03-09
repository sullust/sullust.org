#!/usr/bin/bash
. config/config.sh

BASE_PROJECT_DIR=/esp/esp_projects

cd $BASE_PROJECT_DIR

READONLY_COMMERCIAL=ESPDEV
READONLY_NETWORX=ESPTST
READONLY_VOIP=ESPBKP

#Get all jdbc dirs
echo "Collect jdbc configs"
find . -name jdbc -type d > /tmp/jdbc-dirs

#get all db files files:$i/*; done > 
for i in `cat /tmp/jdbc-dirs `; do grep -il espprod2 $i/*; done > /tmp/prod2
for i in `cat /tmp/jdbc-dirs `; do grep -il ESPSUB1 $i/*; done > /tmp/sub1
for i in `cat /tmp/jdbc-dirs `; do grep -il ESPVOIP $i/*; done > /tmp/voip

#Create new jdbc config file with RO db
echo "Generate RO configs"
for i in `cat /tmp/voip /tmp/prod2 /tmp/sub1`; do  cp $i $i.rw; done;
for i in `cat /tmp/prod2 `; do echo "Creating: $i.ro"; sed "s/[eE][sS][pP][pP][rR][oO][dD]2/$READONLY_COMMERCIAL/" $i > /tmp/p2.tmp;  mv /tmp/p2.tmp $i.ro; echo $i.ro; done;
for i in `cat /tmp/sub1 `; do sed "s/[eE][sS][pP][sS][uU][bB]1/$READONLY_NETWORX/" $i > /tmp/p2.tmp;  mv /tmp/p2.tmp $i.ro; echo $i.ro; done;
for i in `cat /tmp/voip `; do sed "s/[eE][sS][pP][vV][oO][iI][pP]/$READONLY_VOIP/" $i > /tmp/p2.tmp;  mv /tmp/p2.tmp $i.ro; echo $i.ro; done;

#replace password entries
for i in `cat /tmp/voip /tmp/prod2 /tmp/sub1`; do sed "s/>{3DES}.*</>espadmin123</" $i.ro > /tmp/ro.tmp;  mv /tmp/ro.tmp $i.ro; done;

#Find esp.properties
echo "Collect esp.properties"
find . -name esp.properties > /tmp/props
find . -name espws.properties >>/tmp/props
for i in `cat /tmp/props`; do cp $i $i.rw; done;
for i in `cat /tmp/props`; do cp $i $i.shk; done;
for i in `cat /tmp/props `; do echo "Creating $i.ro"; sed "s/READONLY_MODE=false/READONLY_MODE=true/" $i > /tmp/prop;  mv /tmp/prop $i.ro; done;
for i in `cat /tmp/props `; do echo "Creating $i.ro"; sed "s/SEND_EMAIL=1/SEND_EMAIL=0/" $i.ro > /tmp/prop;  mv /tmp/prop $i.ro; done;

#Final Cleanup
echo "Final Cleanup"
find . -name "*.xml.*.*" -print -exec rm {} \; 
find . -name "*.sh.*.*" -print -exec rm {} \; 
find . -name "*.properties.*.*" -print -exec rm {} \;
