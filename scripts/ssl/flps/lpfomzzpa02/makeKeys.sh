#!/usr/bin/bash

HOST=$1

openssl req -new -newkey rsa:2048 -keyout lpfomzzpa02.vzbi.com.key -out lpfomzzpa02.vzbi.com.pem -subj '/C=US/ST=NC/L=Cary/CN=lpfomzzpa02.vzbi.com/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key lpfomzzpa02.vzbi.com.key -out lpfomzzpa02.vzbi.com.csr -subj '/C=US/ST=NC/L=Cary/CN=lpfomzzpa02.vzbi.com/O=Verizon/OU=ESP' -outform PEM;
cat lpfomzzpa02.vzbi.com.csr;
