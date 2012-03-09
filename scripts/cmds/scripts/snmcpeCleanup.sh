#!/usr/bin/bash

DOMAIN_DIR="/esp/snmcpe_prod_1107"

for DOMAIN_DIR in `ls -d /esp/snmcpe_prod_*`; do 

SNMCPE_DIR="${DOMAIN_DIR}/jboss-5.1.0.GA/server/snmcpe"


find /esp -name "{}*" -print -exec rm {} \;

echo "Compressing old log files"
find $SNMCPE_DIR/log -name "server.log.*" ! -name "*.gz" -mtime +1 -print -exec gzip {} \;

echo "Compressing old application dirs"
for i in `find $SNMCPE_DIR -mtime +7 -type d -name "*.bak"`; do 
	echo $i;
	/usr/bin/zip -r $i.zip $i >/dev/null
	rm -Rf $i
done;

echo "Removing old archive files"
find $SNMCPE_DIR -mtime +90 -type f -name "*.gz" -print -exec rm {} \; 
find $SNMCPE_DIR -mtime +90 -type f -name "*.zip" -print -exec rm {} \;

echo "Removing old IPCC files"
find /esp/snmcpe/cmerecords/new -name "IPCC_CME_*" -mtime +7 -print -exec rm {} \;

echo "Compressing old IPCC files"
find /esp/snmcpe/cmerecords -name "IPCC_CME_*" ! -name "*.gz" -mtime +1 -print -exec gzip {} \;

echo echo "Removing old CME logs"
find /esp/snmcpe/cmerecords -name "cme.log.*" -mtime +30 -print -exec rm {} \;
echo "Compressing old CME logs"
find /esp/snmcpe/cmerecords -name "cme.log.*" -mtime +r ! -name "*.gz" -print -exec gzip {} \;

done;
