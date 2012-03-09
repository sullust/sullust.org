#!/usr/bin/bash

./execute-remote-command.sh esp $1 "for i in \`ps -ef -o'pid,comm' | grep jdk160 | grep -v grep | sed 's/\/.*//'\`; do kill -9 \$i; done; cd /esp/snmcpe_prod_1111/jboss-5.1.0.GA/server/snmcpe; rm -Rf tmp data"
