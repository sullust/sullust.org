#!/usr/bin/bash

echo "Beginning load measurements: `date`"

#DATE,LOAD,SNMCPE PID, MEMORY,CPU,FILES

LOAD_COMMAND="uptime | awk '{print \$10}'";
PRSTAT_COMMAND="/usr/bin/prstat -p \`cat /esp/snmcpe_prod_1101/jboss-5.1.0.GA/bin/snmcpe.pid\` 1 1 | grep java"
LSOF_COMMAND="/usr/local/sbin/lsof -p \`cat /esp/snmcpe_prod_1101/jboss-5.1.0.GA/bin/snmcpe.pid\` | wc -l"

for server in `cat /home/jainswor/scripts/server-lists/bak/all-domain-servers`; do 
	echo $server
	SSH_COMMAND="/usr/local/bin/ssh jainswor@$server";
	
	LOAD_RESULT=`$SSH_COMMAND "$LOAD_COMMAND"`;
	PRSTAT_RESULT=`$SSH_COMMAND "$PRSTAT_COMMAND"`;
	LSOF_RESULT=`$SSH_COMMAND "$LSOF_COMMAND"`;

	PRSTAT_RESULT_FINAL=`echo $PRSTAT_RESULT | awk '{print $1,","$3,","$9}'`
	echo -n `date +%Y.%m.%d-%H:%M:%S`",">> /home/jainswor/scripts/load/$server.load 2>&1
	echo -n $LOAD_RESULT >> /home/jainswor/scripts/load/$server.load 2>&1
	echo -n $PRSTAT_RESULT_FINAL"," >> /home/jainswor/scripts/load/$server.load 2>&1
	echo $LSOF_RESULT >> /home/jainswor/scripts/load/$server.load 2>&1;
done;	
echo "===================================";
