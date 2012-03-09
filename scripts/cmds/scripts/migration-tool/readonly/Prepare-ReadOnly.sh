#!/usr/bin/bash
. config/config.sh
. config/migration-functions.sh

printBegin;

cd $BASE_PROJECT_DIR

# READONLY_COMMERCIAL=ESPDEV
# READONLY_NETWORX=ESPTST
# READONLY_VOIP=ESPBKP

#Get all jdbc dirs
echo "Collect jdbc configs..."
find *_$FROM -name jdbc -type d > /tmp/jdbc-dirs.$$

if [[ $DB_READONLY == "true" ]]; then
	#get all db files files:$i/*; done > 
	for i in `cat /tmp/jdbc-dirs.$$ `; do grep -il espprod2 $i/*.xml; done > /tmp/prod2.$$
	for i in `cat /tmp/jdbc-dirs.$$ `; do grep -il ESPSUB1 $i/*.xml; done > /tmp/sub1.$$
	for i in `cat /tmp/jdbc-dirs.$$ `; do grep -il ESPVOIP $i/*.xml; done > /tmp/voip.$$

	for i in `cat /tmp/voip.$$ /tmp/prod2.$$ /tmp/sub1.$$`; do 
		if [[ -e $i.rw ]]; then
			cp $i.rw $i;
		fi;
	done;

	#Create RW/Shakeout configs
	for i in `cat /tmp/voip.$$ /tmp/prod2.$$ /tmp/sub1.$$`; do  cp $i $i.rw; done;
	for i in `cat /tmp/voip.$$ /tmp/prod2.$$ /tmp/sub1.$$`; do  cp $i $i.shk; done;

	#Create new jdbc config file with RO db
	echo "Generate RO jdbc configs for..."
	cat /tmp/prod2.$$ /tmp/sub1.$$ /tmp/voip.$$
	for i in `cat /tmp/prod2.$$ `; do sed "s/[eE][sS][pP][pP][rR][oO][dD]2/$READONLY_COMMERCIAL/" $i > /tmp/p2.tmp.$$;  mv /tmp/p2.tmp.$$ $i.ro; done;
	for i in `cat /tmp/sub1.$$ `; do sed "s/[eE][sS][pP][sS][uU][bB]1/$READONLY_NETWORX/" $i > /tmp/p2.tmp.$$;  mv /tmp/p2.tmp.$$ $i.ro; done;
	for i in `cat /tmp/voip.$$ `; do sed "s/[eE][sS][pP][vV][oO][iI][pP]/$READONLY_VOIP/" $i > /tmp/p2.tmp.$$;  mv /tmp/p2.tmp.$$ $i.ro; done;

	#replace password entries
	for i in `cat /tmp/voip.$$ /tmp/prod2.$$ /tmp/sub1.$$`; do sed "s/>{3DES}.*</>espadmin123</" $i.ro > /tmp/ro.tmp.$$;  mv /tmp/ro.tmp.$$ $i.ro; done;
fi

#Find esp.properties
echo "Collect Properties Files..."
find *_$FROM -name esp.properties > /tmp/props.$$
find *_$FROM -name espws.properties >>/tmp/props.$$

echo "Generate RO Proprties Files for..."
cat /tmp/props.$$
for i in `cat /tmp/props.$$`; do cp $i $i.rw; done;
for i in `cat /tmp/props.$$`; do cp $i $i.shk; done;
for i in `cat /tmp/props.$$ `; do sed "s/READONLY_MODE=false/READONLY_MODE=true/" $i > /tmp/prop.$$;  mv /tmp/prop.$$ $i.ro; done;
for i in `cat /tmp/props.$$ `; do sed "s/SEND_EMAIL=1/SEND_EMAIL=0/" $i.ro > /tmp/prop.$$;  mv /tmp/prop.$$ $i.ro; done;
for i in `cat /tmp/props.$$ `; do sed "s/SEND_EMAIL=1/SEND_EMAIL=0/" $i.shk > /tmp/prop.$$;  mv /tmp/prop.$$ $i.shk; done;

#Final Cleanup
echo "Final Cleanup"
find . -name "*.xml.*.*" -exec rm {} \; 
find . -name "*.sh.*.*" -exec rm {} \; 
find . -name "*.properties.*.*" -exec rm {} \;
rm /tmp/*.$$

printEnd;