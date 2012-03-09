
#!/usr/bin/bash

HOST=$1

if [ $# -ne 1 ]; then
	echo "Usage: `basename $0 ` {hostname}"
	exit 1;
fi

openssl req -new -newkey rsa:2048 -keyout $HOST.key -out $HOST.der -subj '/C=US/ST=NC/L=Cary/CN=$HOST/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key $HOST.key -out $HOST.csr -subj '/C=US/ST=NC/L=Cary/CN=$HOST/O=Verizon/OU=ESP' -outform PEM;
cat $HOST.csr;
