#!/usr/bin/bash

SERVER_LIST=$1

COMMANDS="cd /esp; cp -r snmcpe_prod_104 snmcpe_prod_106;"

COMMANDS=$COMMANDS"cd /esp/snmcpe_prod_106/jboss-5.1.0.GA/bin"

COMMANDS=$COMMANDS"sed 's/104/106/' startSNMCPE.sh > /tmp/snmcpe-move; mv /tmp/snmcpe-move ./startSNMCPE.sh;"

COMMANDS=$COMMANDS"sed 's/104/106/' /esp/bin/processCleanup.sh > /tmp/snmcpe-move; mv /tmp/snmcpe-move /esp/bin/processCleanup.sh;"

COMMANDS=$COMMANDS"sed 's/104/106/' /esp/bin/snmcpeCleanup.sh > /tmp/snmcpe-move; mv /tmp/snmcpe-move /esp/bin/snmcpeCleanup.sh;"

COMMANDS=$COMMANDS"cd ../server/snmcpe; rm -Rf tmp data"

echo $COMMANDS

./execute-remote-command.sh esp $SERVER_LIST "$COMMANDS"
