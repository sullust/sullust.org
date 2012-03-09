PATH=/esp/esp5/bea103/jdk160_17/bin:$PATH
HOST=$1
openssl pkcs8 -topk8 -nocrypt -in lynxdev.vzbi.com.key -inform PEM -out lynxdev.vzbi.com.key.der -outform DER

openssl pkcs7 -inform pem -outform der -in lynxdev.vzbi.com.p7b -out lynxdev.vzbi.com.cer.der

#openssl x509 -in lynxdev.vzbi.com.cer -inform PEM -out lynxdev.vzbi.com.cer.der -outform DER

java ImportKey lynxdev.vzbi.com.key.der lynxdev.vzbi.com.cer.der

mv ~/keystore.ImportKey ./lynxdev.vzbi.com.jks
keytool -storepasswd -keystore lynxdev.vzbi.com.jks -new p@ssw0rd -storepass importkey -storetype jks
keytool -keypasswd -keypass importkey -new p@ssw0rd -storepass p@ssw0rd -keystore lynxdev.vzbi.com.jks -alias importkey
keytool -changealias -alias importkey -destalias lynxdev -keystore lynxdev.vzbi.com.jks -storepass p@ssw0rd
keytool -import -file root.pem -alias ca_cert -keystore lynxdev.vzbi.com.jks -storepass p@ssw0rd
