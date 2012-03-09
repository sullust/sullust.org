#!/usr/bin/bash
#New Production Instance Copy
#WebLogic Version

. config/config.sh
. config/migration-functions.sh

printBegin;

createExcludeFile;

cd $BASE_PROJECT_DIR

if [[ -n $1 ]]; then
	echo $1 > /tmp/instances.$$;
else
	ls -d *_$FROM > /tmp/instances.$$
fi

for i in `cat /tmp/instances.$$ `; do 

	I=`echo $i | sed "s/$FROM/$TO/"`; 
	if [[ -e $I && $NOCLEAN != 1 ]]; then
		echo "$I already exists.  You must remove it first";
		exit 1;
	fi
	echo "$i -> $I"; 
	rsync -a --include=registry.zip --exclude-from=/tmp/exclude-file.$$ $i/ $I; 
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

rm /tmp/*.$$

printEnd;
