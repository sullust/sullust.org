PATH=/esp/esp5/bea103/jdk160_17/bin:$PATH
HOST=$1
openssl pkcs8 -topk8 -nocrypt -in espcp3-net2003.verizonbusiness.com.key -inform PEM -out espcp3-net2003.verizonbusiness.com.key.der -outform DER

openssl pkcs7 -inform pem -outform der -in espcp3-net2003.verizonbusiness.com.p7b -out espcp3-net2003.verizonbusiness.com.cer.der

#openssl x509 -in espcp3-net2003.verizonbusiness.com.cer -inform PEM -out espcp3-net2003.verizonbusiness.com.cer.der -outform DER

java ImportKey espcp3-net2003.verizonbusiness.com.key.der espcp3-net2003.verizonbusiness.com.cer.der

mv ~/keystore.ImportKey ./espcp3-net2003.verizonbusiness.com.jks
keytool -storepasswd -keystore espcp3-net2003.verizonbusiness.com.jks -new p@ssw0rd -storepass importkey -storetype jks
keytool -keypasswd -keypass importkey -new p@ssw0rd -storepass p@ssw0rd -keystore espcp3-net2003.verizonbusiness.com.jks -alias importkey
keytool -changealias -alias importkey -destalias esptd11 -keystore espcp3-net2003.verizonbusiness.com.jks -storepass p@ssw0rd
keytool -import -file root.pem -alias ca_cert -keystore espcp3-net2003.verizonbusiness.com.jks -storepass p@ssw0rd
