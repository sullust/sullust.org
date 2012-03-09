#!/usr/bin/bash

HOST=$1

openssl req -new -newkey rsa:2048 -keyout espcpe1.vzbi.com.key -out espcpe1.vzbi.com.pem -subj '/C=US/ST=NC/L=Cary/CN=espcpe1.vzbi.com/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key espcpe1.vzbi.com.key -out espcpe1.vzbi.com.csr -subj '/C=US/ST=NC/L=Cary/CN=espcpe1.vzbi.com/O=Verizon/OU=ESP' -outform PEM;
cat espcpe1.vzbi.com.csr;