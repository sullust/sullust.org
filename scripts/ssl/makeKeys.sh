#!/usr/bin/bash

HOST=$1

openssl req -new -newkey rsa:2048 -keyout espcpe.vzbi.com.key -out espcpe.vzbi.com.pem -subj '/C=US/ST=NC/L=Cary/CN=espcpe.vzbi.com/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key espcpe.vzbi.com.key -out espcpe.vzbi.com.csr -subj '/C=US/ST=NC/L=Cary/CN=espcpe.vzbi.com/O=Verizon/OU=ESP' -outform PEM;
cat espcpe.vzbi.com.csr;
