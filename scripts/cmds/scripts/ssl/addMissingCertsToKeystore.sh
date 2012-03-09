#!/usr/bin/bash

FILE=$1;

cd /esp/bin/

grep AXL_SSL_HANDSHAKE_ERROR $FILE  | egrep '[0-9][0-9]?[0-9]?\.[0-9][0-9]?[0-9]?\.' | awk '{print $11}' | sort -u | grep '.' > /tmp/ips.$$;
grep javax.net.ssl.SSLHandshakeException $FILE | sed 's/.*https:\/\///' | sed 's/:.*//' | egrep '[0-9][0-9]?[0-9]?\.[0-9][0-9]?[0-9]?\.' | sort -u | grep '.' >> /tmp/ips.$$


for i in `cat /tmp/ips.$$`; do 
	echo "Adding certificate for $i:"
	./addCertificateToKeystore.sh $i 443 $2 p@ssw0rd;
done;
