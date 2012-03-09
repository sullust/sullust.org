#!/bin/sh
PATH=/esp/bea103/jdk160_05/bin:/usr/local/ssl/bin/:${PATH}
LD_LIBRARY_PATH=/usr/lib/ssl
CLASSPATH=.
export PATH
export LD_LIBRARY_PATH
export CLASSPATH
javac DumpPrivateKey.java
ALIAS=esptd11
KEYSTORE=esptd11.jks
PASS=p@ssw0rd
PKEY_8=privatekey.pkcs8
PKEY_64=privatekey.b64
CERT_64=certificate.b64
keytool -alias ${ALIAS}  -export -rfc -keystore ${KEYSTORE} -storepass ${PASS} > ${CERT_64}
java DumpPrivateKey >${PKEY_8}
(echo "-----BEGIN PRIVATE KEY-----" ;
 openssl enc -in ${PKEY_8} -a;
 echo "-----END PRIVATE KEY-----") >${PKEY_64}
cat ${PKEY_64}
#openssl pkcs12 -inkey ${PKEY_64} -in ${CERT_64} -out ${CERT_12} -export 
rm ${PKEY_8} ${PKEY_64} ${CERT_64}

