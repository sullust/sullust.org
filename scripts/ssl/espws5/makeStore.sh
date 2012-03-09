PATH=/esp/esp5/bea103/jdk160_17/bin:$PATH
HOST=$1
openssl pkcs8 -topk8 -nocrypt -in espws5.vzbi.com.key -inform PEM -out espws5.vzbi.com.key.der -outform DER

openssl pkcs7 -inform pem -outform der -in espws5.vzbi.com.p7b -out espws5.vzbi.com.cer.der

#openssl x509 -in espws5.vzbi.com.cer -inform PEM -out espws5.vzbi.com.cer.der -outform DER

java ImportKey espws5.vzbi.com.key.der espws5.vzbi.com.cer.der

mv ~/keystore.ImportKey ./espws5.vzbi.com.jks
keytool -storepasswd -keystore espws5.vzbi.com.jks -new p@ssw0rd -storepass importkey -storetype jks
keytool -keypasswd -keypass importkey -new p@ssw0rd -storepass p@ssw0rd -keystore espws5.vzbi.com.jks -alias importkey
keytool -changealias -alias importkey -destalias espws5 -keystore espws5.vzbi.com.jks -storepass p@ssw0rd
keytool -import -file root.pem -alias ca_cert -keystore espws5.vzbi.com.jks -storepass p@ssw0rd
