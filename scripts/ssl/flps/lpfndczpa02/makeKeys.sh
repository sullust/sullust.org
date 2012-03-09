#!/usr/bin/bash

HOST=$1

openssl req -new -newkey rsa:2048 -keyout lpfndczpa02.vzbi.com.key -out lpfndczpa02.vzbi.com.pem -subj '/C=US/ST=NC/L=Cary/CN=lpfndczpa02.vzbi.com/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key lpfndczpa02.vzbi.com.key -out lpfndczpa02.vzbi.com.csr -subj '/C=US/ST=NC/L=Cary/CN=lpfndczpa02.vzbi.com/O=Verizon/OU=ESP' -outform PEM;
cat lpfndczpa02.vzbi.com.csr;
