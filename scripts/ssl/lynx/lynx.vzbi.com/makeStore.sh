PATH=/esp/esp5/bea103/jdk160_17/bin:$PATH
HOST=$1
openssl pkcs8 -topk8 -nocrypt -in lynx.vzbi.com.key -inform PEM -out lynx.vzbi.com.key.der -outform DER

openssl pkcs7 -inform pem -outform der -in lynx.vzbi.com.p7b -out lynx.vzbi.com.cer.der

#openssl x509 -in lynx.vzbi.com.cer -inform PEM -out lynx.vzbi.com.cer.der -outform DER

java ImportKey lynx.vzbi.com.key.der lynx.vzbi.com.cer.der

mv ~/keystore.ImportKey ./lynx.vzbi.com.jks
keytool -storepasswd -keystore lynx.vzbi.com.jks -new p@ssw0rd -storepass importkey -storetype jks
keytool -keypasswd -keypass importkey -new p@ssw0rd -storepass p@ssw0rd -keystore lynx.vzbi.com.jks -alias importkey
keytool -changealias -alias importkey -destalias lynx -keystore lynx.vzbi.com.jks -storepass p@ssw0rd
keytool -import -file root.pem -alias ca_cert -keystore lynx.vzbi.com.jks -storepass p@ssw0rd
