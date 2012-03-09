#!/usr/bin/bash

HOST=$1

openssl req -new -newkey rsa:2048 -keyout espws5.vzbi.com.key -out espws5.vzbi.com.pem -subj '/C=US/ST=NC/L=Cary/CN=espws5.vzbi.com/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key espws5.vzbi.com.key -out espws5.vzbi.com.csr -subj '/C=US/ST=NC/L=Cary/CN=espws5.vzbi.com/O=Verizon/OU=ESP' -outform PEM;
cat espws5.vzbi.com.csr;
