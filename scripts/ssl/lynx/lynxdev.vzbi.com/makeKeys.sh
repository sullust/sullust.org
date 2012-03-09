#!/usr/bin/bash

HOST=$1

openssl req -new -newkey rsa:2048 -keyout lynxdev.vzbi.com.key -out lynxdev.vzbi.com.pem -subj '/C=US/ST=NC/L=Cary/CN=lynxdev.vzbi.com/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key lynxdev.vzbi.com.key -out lynxdev.vzbi.com.csr -subj '/C=US/ST=NC/L=Cary/CN=lynxdev.vzbi.com/O=Verizon/OU=ESP' -outform PEM;
cat lynxdev.vzbi.com.csr;
