#!/usr/bin/bash

export PATH=$PATH:/usr/local/bin

echo `date`

echo "Restarting 7006"
kill `ps -ef | grep 7006: | grep ssh | grep L | grep -v grep  | awk '{print $2}'`;
sleep 3;
ssh -f -g -N -L 17006:127.0.0.1:7006 127.0.0.1

echo "Restarting 8006"
kill `ps -ef | grep 8006: | grep ssh | grep L | grep -v grep  | awk '{print $2}'`;
sleep 3;
ssh -f -g -N -L 18006:127.0.0.1:8006 127.0.0.1

echo "Restarting 9005"
kill `ps -ef | grep 9005: | grep ssh | grep L | grep -v grep  | awk '{print $2}'`;
sleep 3;
ssh -f -g -N -L 19005:127.0.0.1:9005 127.0.0.1

echo "Restarting 9006"
kill `ps -ef | grep 9006: | grep ssh | grep L | grep -v grep  | awk '{print $2}'`;
sleep 3;
ssh -f -g -N -L 19006:127.0.0.1:9006 127.0.0.1
