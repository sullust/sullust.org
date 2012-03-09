#!/bin/bash

echo "" >> /etc/hosts
echo "10.0.1.195 imac" >> /etc/hosts

LOCAL_IP=`ifconfig tun0 | grep 'inet addr'  | sed 's/.*addr://' | sed 's/ .*//'`;
#echo "127.0.0.1		`hostname`" >> /etc/hosts
echo "$LOCAL_IP	`hostname` 127.0.0.1 jainswor-HP-EliteBook-6930p jainswor-laptop jainswor-laptop.vzbi.com" >> /etc/hosts
