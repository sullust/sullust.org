#!/usr/bin/bash

HOST=$1

openssl req -new -newkey rsa:2048 -keyout mulder.mcilink.com.key -days 1825 -out mulder.mcilink.com.pem -subj '/C=US/ST=NC/L=Cary/CN=mulder.mcilink.com/O=Verizon/OU=ESP' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key mulder.mcilink.com.key -out mulder.mcilink.com.csr -subj '/C=US/ST=NC/L=Cary/CN=mulder.mcilink.com/O=Verizon/OU=ESP' -outform PEM;
cat mulder.mcilink.com.csr;
