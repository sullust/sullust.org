#!/usr/bin/bash

HOST=$1

openssl req -new -newkey rsa:2048 -keyout esptd7.vzbi.com.key -out esptd7.vzbi.com.pem -subj '/C=US/ST=NC/L=Cary/CN=esptd7.vzbi.com/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key esptd7.vzbi.com.key -out esptd7.vzbi.com.csr -subj '/C=US/ST=NC/L=Cary/CN=esptd7.vzbi.com/O=Verizon/OU=ESP' -outform PEM;
cat esptd7.vzbi.com.csr;
