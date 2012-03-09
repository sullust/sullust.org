openssl req -new -newkey rsa:2048 -keyout espws.vzbi.com.key -out espws.vzbi.com.der -subj '/C=US/ST=NC/L=Cary/CN=espws.vzbi.com/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key espws.vzbi.com.key -out espws.vzbi.com.csr -subj '/C=US/ST=NC/L=Cary/CN=espws.vzbi.com/O=Verizon/OU=ESP' -outform PEM;
cat espws.vzbi.com.csr;
