#!/usr/bin/bash

HOST=$1

openssl req -new -newkey rsa:2048 -keyout espcpe3.vzbi.com.key -out espcpe3.vzbi.com.pem -subj '/C=US/ST=NC/L=Cary/CN=espcpe3.vzbi.com/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key espcpe3.vzbi.com.key -out espcpe3.vzbi.com.csr -subj '/C=US/ST=NC/L=Cary/CN=espcpe3.vzbi.com/O=Verizon/OU=ESP' -outform PEM;
cat espcpe3.vzbi.com.csr;
