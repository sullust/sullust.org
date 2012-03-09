#!/usr/bin/bash

HOST=$1

openssl req -new -newkey rsa:2048 -keyout lynx.vzbi.com.key -out lynx.vzbi.com.pem -subj '/C=US/ST=NC/L=Cary/CN=lynx.vzbi.com/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key lynx.vzbi.com.key -out lynx.vzbi.com.csr -subj '/C=US/ST=NC/L=Cary/CN=lynx.vzbi.com/O=Verizon/OU=ESP' -outform PEM;
cat lynx.vzbi.com.csr;
