#!/usr/bin/bash

./execute-remote-command.sh esp $1 "for i in \`ps -ef -o'pid,comm' | grep java15 | grep -v grep | sed 's/\/.*//'\`; do kill -9 \$i; done; cd /esp/snmcpe_prod_92/jboss-4.2.2.GA/server/snmcpe; rm -Rf tmp data"
