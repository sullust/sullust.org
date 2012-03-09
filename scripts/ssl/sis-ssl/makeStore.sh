#!/usr/bin/bash

HOST=$1

keytool -genkey -v -alias $HOST -keyalg RSA -sigalg MD5WithRSA -validity 1825 -keystore $HOST.jks -dname "cn=$HOST.mso.mci.com, ou=MCI, o=MCI, l=Cary, s=NC, c=US" -storepass p@ssw0rd -keypass p@ssw0rd

keytool -selfcert -v -alias $HOST -sigalg MD5WithRSA -validity 1825 -keystore $HOST.jks -storepass p@ssw0rd

keytool -export -file $HOST.der -keystore $HOST.jks -storepass p@ssw0rd -alias $HOST

java -cp /esp/bea103/wlserver_10.3/server/lib/weblogic.jar utils.der2pem $HOST.der

rm $HOST.der
