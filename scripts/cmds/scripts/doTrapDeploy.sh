#!/usr/bin/bash

echo "=======================================================";
echo "Beginning Trap Deployment: `date`";

cd /home/jainswor/scripts

./createTrapServerList.pl > smarts-server-list 2>/dev/null

./generateDomainProperties.pl server-lists/bak/all-domain-servers smarts-server-list domain.properties

./pushSmartsFiles.pl esp server-lists/bak/all-domain-servers /esp/snmcpe_current/jboss-5.1.0.GA/server/snmcpe/conf/domain.properties

for i in `cat server-lists/bak/all-domain-servers`; do 
	/usr/local/bin/wget -T 30 -t 0 --output-document=/dev/null "https://$i:8880/snmcpe/ReloadProperties.jsp"; 
	rm ReloadProperties.jsp
done;

echo "Trap Deployment Complete: `date`";
echo "=======================================================";
