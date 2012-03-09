#!/usr/bin/bash

KEYSTORE=$3

PASSCODE=$4

if [[ -z $PASSCODE ]]; then
	PASSCODE='p@ssw0rd';
fi

if [[ -n $JAVA_HOME ]]; then
	if [[ -e /esp/esp5/bea103/jdk160_17/ ]]; then
		JAVA_HOME=/esp/esp5/bea103/jdk160_17/;
	fi

	if [[ -e /esp/jdk160_17 ]]; then
		JAVA_HOME=/esp/jdk160_17
	fi

	if [[ -e /esp/jdk1.6.0_17 ]]; then
		JAVA_HOME=/esp/jdk1.6.0_17
	fi
fi

if [[ -n $JAVA_HOME ]]; then
	echo "No JAVA_HOME could be found"
	exit 1;
fi

export LD_LIBRARY_PATH=/esp/usr/local/ssl/lib:/esp/usr/local/lib
export PATH=$PATH:/usr/sfw/bin:/usr/local/ssl/bin

/esp/bin/collectCertificate.pl $1 $2

ALIAS="$1-`date +%Y.%m.%d`";

echo yes | $JAVA_HOME/bin/keytool -import -file /tmp/$1.pem -alias $ALIAS -keystore $KEYSTORE -storepass $PASSCODE -trustcacerts

