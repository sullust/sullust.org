#!/usr/bin/bash

./execute-remote-command.sh esp $1 "cd /esp/snmcpe_prod_1202/jboss-5.1.0.GA/bin; tail -$2 ../server/snmcpe/log/server.log" 2>/dev/null
