PATH=/esp/esp5/bea103/jdk160_17/bin:$PATH
openssl pkcs8 -topk8 -nocrypt -in espws.vzbi.com.key -inform PEM -out espws.vzbi.com.key.der -outform DER

openssl pkcs7 -inform pem -outform der -in espws.vzbi.com.p7b -out espws.vzbi.com.cer.der

#openssl x509 -in espws.vzbi.com.cer -inform PEM -out espws.vzbi.com.cer.der -outform DER

java ImportKey espws.vzbi.com.key.der espws.vzbi.com.cer.der

mv ~/keystore.ImportKey ./espws.vzbi.com.jks
keytool -storepasswd -keystore espws.vzbi.com.jks -new p@ssw0rd -storepass importkey -storetype jks
keytool -keypasswd -keypass importkey -new p@ssw0rd -storepass p@ssw0rd -keystore espws.vzbi.com.jks -alias importkey
keytool -changealias -alias importkey -destalias espws -keystore espws.vzbi.com.jks -storepass p@ssw0rd
keytool -import -file root.pem -alias ca_cert -keystore espws.vzbi.com.jks -storepass p@ssw0rd
