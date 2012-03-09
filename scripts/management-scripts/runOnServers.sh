#!/bin/bash
scp -q $1 jainswor@pdcc01-cmds1.mso.mci.com:/home/jainswor/scripts/server-lists/tmp/servers
./util/runOnCmds.sh "/home/jainswor/scripts/execute-remote-command.sh jainswor /home/jainswor/scripts/server-lists/tmp/servers \"$2\""

