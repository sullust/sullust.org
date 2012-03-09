#!/usr/bin/bash

./execute-remote-command.sh esp $1 "cd /esp/snmcpe_prod_106/jboss-5.1.0.GA/bin; tail -$2 snmcpe.log" 2>/dev/null
