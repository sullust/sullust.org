#!/usr/bin/bash

HOST=$1

openssl req -new -newkey rsa:2048 -keyout espws4.vzbi.com.key -out espws4.vzbi.com.pem -subj '/C=US/ST=NC/L=Cary/CN=espws4.vzbi.com/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key espws4.vzbi.com.key -out espws4.vzbi.com.csr -subj '/C=US/ST=NC/L=Cary/CN=espws4.vzbi.com/O=Verizon/OU=ESP' -outform PEM;
cat espws4.vzbi.com.csr;
