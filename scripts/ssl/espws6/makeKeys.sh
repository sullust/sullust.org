#!/usr/bin/bash

HOST=$1

openssl req -new -newkey rsa:2048 -keyout espws6.vzbi.com.key -out espws6.vzbi.com.pem -subj '/C=US/ST=NC/L=Cary/CN=espws6.vzbi.com/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key espws6.vzbi.com.key -out espws6.vzbi.com.csr -subj '/C=US/ST=NC/L=Cary/CN=espws6.vzbi.com/O=Verizon/OU=ESP' -outform PEM;
cat espws6.vzbi.com.csr;
