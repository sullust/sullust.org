#!/usr/bin/bash

/home/jainswor/scripts/execute-remote-command.sh esp $1 "for i in \`ps -ef -o 'pid,comm,args' | grep 'jdk160_..' | grep -v grep | grep -v \\\`cat $2/snmcpe.pid \\\` | grep -v snmcpe4 | grep -v PrintGCT | sed 's/\/.*//'\`; do echo \$i;  kill -9 \$i; done;"
