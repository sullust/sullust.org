#!/usr/bin/bash
JAVA_HOME=/esp/jdk160_17
PROXY_HOME=`pwd`
export JAVA_HOME 
export PROXY_HOME

PID=`cat proxy.pid`;
PROCESS_COUNT=`ps -ef | awk '{print $2}' | grep "^$PID$" | wc -l`;
PROXY_RUN=`ls run.this.proxy 2>/dev/null | wc -l `

if [[ $PROCESS_COUNT -lt 1  && $PROXY_RUN -eq 1 ]]; then
	echo "--- Required Proxy not found";
	echo -n "--- ";
	./startProxy.sh
fi

if [[ $PROCESS_COUNT -gt 0 && $PROXY_RUN -eq 0 ]]; then
	echo "--- Unwanted Proxy found";
	echo -n "--- ";
	./stopProxy.sh
fi
