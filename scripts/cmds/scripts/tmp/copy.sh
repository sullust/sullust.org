#!/usr/bin/bash
./execute-remote-command.sh jainswor server-lists/prod/all "cd /esp/esp_projects; echo \"B0b4f377\" | /usr/local/bin/sudo -S /home/jainswor/scripts/WebLogic-Instance-Copy.sh 1105 1107"

