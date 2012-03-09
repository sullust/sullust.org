#!/usr/bin/bash
if [[ "$1" == 'refresh' || ! -e /tmp/fileList ]]; then
	rm /tmp/fileList
	rm /tmp/fileContents
	rm /tmp/runningPids
	echo "Refreshing pid files"
	find /esp/snmcpe* -name "*.pid" >/tmp/fileList 2>/dev/null
	find /esp/esp_projects/* -name "*.pid" >> /tmp/fileList 2>/dev/null
fi

if [ "$1" == 'verify' ]; then
        echo "Verifying pids"
        rm /tmp/verify
        /esp/bin/findInstances.sh > /tmp/verify
        for i in `ps -ef | grep java | grep -v grep | awk '{print $2}'`; do echo -n "$i: "; cat /tmp/verify | grep $i; done;
        exit 0;
fi

echo -n "" > /tmp/fileContents;
for i in `cat /tmp/fileList 2>/dev/null`; do 
	echo -n "$i: " >>/tmp/fileContents; 
	cat $i >>/tmp/fileContents 2>/dev/null; 
done;

echo -n "" > /tmp/runningPids;
for i in `ps -ef -o "pid args" | grep java | grep -v grep | awk '{print $1}'`; do 
	grep " $i" /tmp/fileContents >> /tmp/runningPids #2>/dev/null;
done;

sort /tmp/runningPids 
cat /tmp/runningPids 2>/dev/null | wc -l

chmod 777 /tmp/fileList 2>/dev/null
chmod 777 /tmp/fileContents 2>/dev/null
chmod 777 /tmp/runningPids 2>/dev/null
