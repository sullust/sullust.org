PATH=/esp/esp5/bea103/jdk160_17/bin:$PATH
HOST=$1
openssl pkcs8 -topk8 -nocrypt -in lpfndczpa01.vzbi.com.key -inform PEM -out lpfndczpa01.vzbi.com.key.der -outform DER

openssl pkcs7 -inform pem -outform der -in lpfndczpa01.vzbi.com.p7b -out lpfndczpa01.vzbi.com.cer.der

#openssl x509 -in lpfndczpa01.vzbi.com.cer -inform PEM -out lpfndczpa01.vzbi.com.cer.der -outform DER

java ImportKey lpfndczpa01.vzbi.com.key.der lpfndczpa01.vzbi.com.cer.der

mv ~/keystore.ImportKey ./lpfndczpa01.vzbi.com.jks
keytool -storepasswd -keystore lpfndczpa01.vzbi.com.jks -new p@ssw0rd -storepass importkey -storetype jks
keytool -keypasswd -keypass importkey -new p@ssw0rd -storepass p@ssw0rd -keystore lpfndczpa01.vzbi.com.jks -alias importkey
keytool -changealias -alias importkey -destalias espcpe -keystore lpfndczpa01.vzbi.com.jks -storepass p@ssw0rd
keytool -import -file root.pem -alias ca_cert -keystore lpfndczpa01.vzbi.com.jks -storepass p@ssw0rd
