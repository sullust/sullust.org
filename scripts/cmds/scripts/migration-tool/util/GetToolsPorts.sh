#!/usr/bin/bash

if [[ $# -lt 1 ]]; then
	echo "Usage: <Release Number>";
	exit 1;
fi

FROM=$1

for i in `find *_$FROM -name "*.properties" 2>/dev/null`; do 
	if [[ -n `grep TOOLS $i` ]]; then 
		echo $i; echo ""; 
		grep TOOLS_ $i | perl -ne 'm/(:|=)([0-9]{4,4})/ && print $2."\n"' | sort -u; 
		echo "============================="; 
	fi; 
done;