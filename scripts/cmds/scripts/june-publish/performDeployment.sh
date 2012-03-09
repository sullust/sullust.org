#!/usr/bin/bash

#DEPLOYMENT STEPS 

#stop
#transition
#generate properties
#push properties
#upload
#deploy
#start

SERVER_LIST=$1
APPLICATION=$2

./killAllDomain.sh $SERVER_LIST

./transitionDomain.sh $SERVER_LIST

./upload-file.sh $APPLICATION esp $SERVER_LIST /esp/snmcpe_prod_106/jboss-5.1.0.GA/server/snmcpe

./build-smarts-mapping.pl

./generateDomainProperties.pl $SERVER_LIST smarts-server-list domain.properties

./pushSmartsFiles.pl esp $SERVER_LIST /esp/snmcpe_prod_106/jboss-5.1.0.GA/server/snmcpe/conf/domain.properties

./execute-remote-command.sh esp $SERVER_LIST "cd /esp/snmcpe_prod_106/jboss-5.1.0.GA/server/snmcpe; mv deploy/snmcpe.ear ./snmcpe.ear.0619.bak; unzip $APPLICATION >/dev/null; mv snmcpe.ear deploy/snmcpe.ear; rm -Rf tmp data"

./startAll.sh $SERVER_LIST
