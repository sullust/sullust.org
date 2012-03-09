#!/usr/bin/bash

HOST=$1

openssl req -new -newkey rsa:2048 -keyout esp3.vzbi.com.key -out esp3.vzbi.com.pem -subj '/C=US/ST=NC/L=Cary/CN=esp3.vzbi.com/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key esp3.vzbi.com.key -out esp3.vzbi.com.csr -subj '/C=US/ST=NC/L=Cary/CN=esp3.vzbi.com/O=Verizon/OU=ESP' -outform PEM;
cat esp3.vzbi.com.csr;
