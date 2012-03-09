#!/usr/bin/bash

HOST=$1

openssl req -new -newkey rsa:2048 -keyout esp4.vzbi.com.key -out esp4.vzbi.com.pem -subj '/C=US/ST=NC/L=Cary/CN=esp4.vzbi.com/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key esp4.vzbi.com.key -out esp4.vzbi.com.csr -subj '/C=US/ST=NC/L=Cary/CN=esp4.vzbi.com/O=Verizon/OU=ESP' -outform PEM;
cat esp4.vzbi.com.csr;
