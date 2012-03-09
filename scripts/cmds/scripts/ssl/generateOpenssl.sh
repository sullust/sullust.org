#!/usr/bin/bash

openssl genrsa -out host.key 1024
chmod 400 host.key
openssl req -new -nodes -key host.key -out host.csr

echo "====================================="
cat host.csr
