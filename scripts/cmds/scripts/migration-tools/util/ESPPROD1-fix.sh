#!/usr/bin/bash
for j in `find . -name "*jdbc*.ro" 2>/dev/null | sed 's/\([^\.]\)\/.*/\\1/' | sort -u`; do
	echo $j;
	cd $j;
	for i in `grep -l ESPPROD1 config/jdbc/*`; do 
		echo "Altering $i...";
		sed 's/146.170.67.8/146.170.124.21/' $i > /tmp/foo;
		mv /tmp/foo $i; 
		sed 's/espadmin123/Adm1n3sp/' $i > /tmp/foo; 
		mv /tmp/foo $i; 
	done;
	cd ../;
done;