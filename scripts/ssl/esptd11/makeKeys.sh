#!/usr/bin/bash

HOST=$1

openssl req -new -newkey rsa:2048 -keyout esptd11.vzbi.com.key -out esptd11.vzbi.com.pem -subj '/C=US/ST=NC/L=Cary/CN=esptd11.vzbi.com/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key esptd11.vzbi.com.key -out esptd11.vzbi.com.csr -subj '/C=US/ST=NC/L=Cary/CN=esptd11.vzbi.com/O=Verizon/OU=ESP' -outform PEM;
cat esptd11.vzbi.com.csr;
