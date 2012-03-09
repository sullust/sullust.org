#!/usr/bin/bash

HOST=$1

openssl req -new -newkey rsa:2048 -keyout cnh1-d22.verizon.com.key -out cnh1-d22.verizon.com.pem -subj '/C=US/ST=NC/L=Cary/CN=cnh1-d22.verizon.com/O=Verizon Communication Inc/OU=Verizon Business' -sha1 -nodes -outform PEM; 

openssl req -new -nodes -key cnh1-d22.verizon.com.key -out cnh1-d22.verizon.com.csr -subj '/C=US/ST=NC/L=Cary/CN=cnh1-d22.verizon.com/O=Verizon Communication Inc/OU=Verizon Business' -outform PEM;
cat cnh1-d22.verizon.com.csr;
