#!/usr/bin/bash

./execute-remote-command.sh root $1 "for i in \`ps -ef -o'pid,comm' | grep jdk160 | grep -v grep | sed 's/\/.*//'\`; do kill -9 \$i; done;"
