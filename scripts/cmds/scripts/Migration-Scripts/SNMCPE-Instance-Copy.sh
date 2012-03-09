#!/usr/bin/bash
#New Production Instance Copy
#WebLogic Version

. config/config.sh

function createExcludeFile() {
cat > /tmp/exclude-file <<EOF
admin-console.war
tmp
data
work
snmcpe.ear
jmx-console.war
*.gz
management
*.log
snmcpe.pid
EOF
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
if [[ $# -lt 2 ]]; then
	echo "You must specify the from and to release numbers";
	exit 1;
fi

FROM=$1;
TO=$2;

createExcludeFile;

cd /esp/
rm /tmp/instances 2>/dev/null
ls -d *_$FROM > /tmp/instances

for i in `cat /tmp/instances `; do 
	I=`echo $i | sed "s/$FROM/$TO/"`; 
	mkdir -p $I; 
	echo "$i -> $I"; 
	rsync -a --exclude-from=/tmp/exclude-file snmcpe_prod_$FROM snmcpe_prod_$TO
done;

#Clean up mess
for i in `find *_$TO -name "*_$FROM" -type d`; do 
	echo $i; 
	I=`echo $i | sed "s/$FROM/$TO/"`; 
	mv $i/* $i/../; 
	rmdir $i; 
done;

echo "Clear old pid files"
find *_$TO -name "*.pid" -print -exec rm {} \;