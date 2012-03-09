#!/usr/bin/bash

for i in `ls -d /esp/snmcpe*`; do
	if [[ -e $i/jboss-5.1.0.GA/server/snmcpe/deploy/jbossweb.sar/server.xml ]]; then
		echo -n "$i: ";
		grep 'Connector protocol="HTTP/1.1" port' $i/jboss-5.1.0.GA/server/snmcpe/deploy/jbossweb.sar/server.xml | sed 's/.*port="//' | sed 's/".*//' ; 
	fi	
done

