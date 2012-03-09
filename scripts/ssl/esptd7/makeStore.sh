PATH=/esp/esp5/bea103/jdk160_17/bin:$PATH
HOST=$1

javac ImportKey.java

openssl pkcs8 -topk8 -nocrypt -in esptd7.vzbi.com.key -inform PEM -out esptd7.vzbi.com.key.der -outform DER

openssl pkcs7 -inform pem -outform der -in esptd7.vzbi.com.p7b -out esptd7.vzbi.com.cer.der

#openssl x509 -in esptd7.vzbi.com.cer -inform PEM -out esptd7.vzbi.com.cer.der -outform DER

java ImportKey esptd7.vzbi.com.key.der esptd7.vzbi.com.cer.der

mv ~/keystore.ImportKey ./esptd7.vzbi.com.jks
keytool -storepasswd -keystore esptd7.vzbi.com.jks -new p@ssw0rd -storepass importkey -storetype jks
keytool -keypasswd -keypass importkey -new p@ssw0rd -storepass p@ssw0rd -keystore esptd7.vzbi.com.jks -alias importkey
keytool -changealias -alias importkey -destalias esptd7.vzbi.com -keystore esptd7.vzbi.com.jks -storepass p@ssw0rd
keytool -import -file root.pem -alias ca_cert -keystore esptd7.vzbi.com.jks -storepass p@ssw0rd
