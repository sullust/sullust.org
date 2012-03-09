#!/usr/bin/bash
LD_LIBRARY_PATH=/esp/usr/local/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
PATH=/usr/bin:/usr/ucb:/etc:.:/usr/local/bin:/usr/local/sbin:/bin:/usr/sbin:/sbin:$PATH
export PATH;

/esp/bin/logrotate/logrotate -f /esp/bin/logrotate/logrotate.conf
/esp/bin/logrotate/logrotate -f /esp/bin/logrotate/logrotate-sys.conf
touch /logs/cisco_logs/cisco.log

/usr/local/scripts/hup-process syslog1 sm_adapter
/usr/local/scripts/hup-process syslog2 sm_adapter
/usr/local/scripts/hup-process syslog3 sm_adapter
/usr/local/scripts/hup-process syslog4 sm_adapter
/usr/local/scripts/hup-process syslog5 sm_adapter
kill -HUP `cat /etc/syslog.pid`

gzip /logs/cisco_logs/cisco.log.0

mv /logs/cisco_logs/cisco.log.0.gz /logs/cisco_logs/archive/cisco.log.`date +%Y.%m.%d-%H.%M.%S`.gz

find /logs/cisco_logs/archive/ -mtime +60 -exec rm {} \;
