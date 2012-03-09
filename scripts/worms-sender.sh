#!/usr/bin/bash
PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin
export PATH

SYSLOG_PATH='/logs/cisco_logs'
DEST_SERVER=pdcc01-espws1.mso.mci.com
#DEST_DIR=$2
DEST_DIR=`/esp/snmcpe/bin/getDomain.pl`

#cisco.log.bak_200810150000.gz

echo "============= Begin "`date`"=============="

cd $SYSLOG_PATH

for i in `find . -name "cisco.log.*.gz" | grep -v archive`; do

echo "/usr/local/bin/scp -q -i /home/esp/.ssh/id_rsa $i esp@$DEST_SERVER:/esp/syslog/$DEST_DIR/$i"

if /usr/local/bin/scp -q -i /home/esp/.ssh/id_rsa $i esp@$DEST_SERVER:/esp/syslog/$DEST_DIR/$i
then
	echo "mv $i archive/$i";
	mv $i archive/$i
else 
	echo "Couldn't upload file, move delayed";
fi

done;

echo "============= End "`date`"=============="
