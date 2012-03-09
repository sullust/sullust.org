#!/usr/bin/bash

for i in `ps -ef | grep -i pidgin | grep -v grep | awk '{print $2}'`; do 
	kill $i; 
done;
