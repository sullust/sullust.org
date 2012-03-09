PATH=/esp/esp5/bea103/jdk160_17/bin:$PATH
HOST=$1
openssl pkcs8 -topk8 -nocrypt -in espcpe.vzbi.com.key -inform PEM -out espcpe.vzbi.com.key.der -outform DER

openssl pkcs7 -inform pem -outform der -in espcpe.vzbi.com.p7b -out espcpe.vzbi.com.cer.der

#openssl x509 -in espcpe.vzbi.com.cer -inform PEM -out espcpe.vzbi.com.cer.der -outform DER

java ImportKey espcpe.vzbi.com.key.der espcpe.vzbi.com.cer.der

mv ~/keystore.ImportKey ./espcpe.vzbi.com.jks
keytool -storepasswd -keystore espcpe.vzbi.com.jks -new p@ssw0rd -storepass importkey -storetype jks
keytool -keypasswd -keypass importkey -new p@ssw0rd -storepass p@ssw0rd -keystore espcpe.vzbi.com.jks -alias importkey
keytool -changealias -alias importkey -destalias espcpe -keystore espcpe.vzbi.com.jks -storepass p@ssw0rd
keytool -import -file root.pem -alias ca_cert -keystore espcpe.vzbi.com.jks -storepass p@ssw0rd
