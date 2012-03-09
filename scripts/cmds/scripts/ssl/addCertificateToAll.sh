#!/usr/bin/bash

HOST=$1
PORT=$2

for i in `find /esp/esp_projects -name esp_truststore.jks 2>/dev/null`; do 
	/esp/bin/addCertificateToKeystore.sh $HOST $PORT $i;
done;