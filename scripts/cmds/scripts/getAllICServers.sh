#!/usr/bin/bash

scp jainswor@pdcd01-snmcpe1.mso.mci.com:/usr/local/SMARTS_Config ./

for i in `cat SMARTS_Config `; do 
	j=`echo $i | grep '\-ic'`; 
	if [[ "x"$j != "x" ]]; then 
		echo $i | sed 's/:.*//' | grep -v OVRIDE | grep -v DOMAIN | grep -v OI;
	fi; 
done | sort -u | sed 's/^.*,//';


