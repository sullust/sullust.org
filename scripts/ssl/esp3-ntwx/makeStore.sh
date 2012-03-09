PATH=/esp/esp5/bea103/jdk160_17/bin:$PATH
HOST=$1
openssl pkcs8 -topk8 -nocrypt -in esp3.vzbi.com.key -inform PEM -out esp3.vzbi.com.key.der -outform DER

openssl pkcs7 -inform pem -outform der -in esp3.vzbi.com.p7b -out esp3.vzbi.com.cer.der

#openssl x509 -in esp3.vzbi.com.cer -inform PEM -out esp3.vzbi.com.cer.der -outform DER

java ImportKey esp3.vzbi.com.key.der esp3.vzbi.com.cer.der

mv ~/keystore.ImportKey ./esp3.vzbi.com.jks
keytool -storepasswd -keystore esp3.vzbi.com.jks -new p@ssw0rd -storepass importkey -storetype jks
keytool -keypasswd -keypass importkey -new p@ssw0rd -storepass p@ssw0rd -keystore esp3.vzbi.com.jks -alias importkey
keytool -changealias -alias importkey -destalias esp3.vzbi.com -keystore esp3.vzbi.com.jks -storepass p@ssw0rd
keytool -import -file root.pem -alias ca_cert -keystore esp3.vzbi.com.jks -storepass p@ssw0rd
