#!/usr/bin/bash

HOST=$1

openssl req -new -key id_rsa -out ndcc01-esp3.mso.mci.com.pem -subj '/C=US/ST=NC/L=Cary/CN=ndcc01-esp3.mso.mci.com/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key id_rsa -out ndcc01-esp3.mso.mci.com.csr -subj '/C=US/ST=NC/L=Cary/CN=ndcc01-esp3.mso.mci.com/O=Verizon/OU=ESP' -outform PEM;
cat ndcc01-esp3.mso.mci.com.csr;
