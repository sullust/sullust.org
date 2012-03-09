#!/usr/bin/bash
export BEA_HOME=/esp/bea103
export WEBLOGIC_HOME=$BEA_HOME/wlserver_10.3
export JAVA_HOME=$BEA_HOME/jdk160_05
export CLASSPATH=.:$WEBLOGIC_HOME/server/lib/weblogic.jar:$WEBLOGIC_HOME/server/lib/webservices.jar:/home/justin/scripts/ws-tester/wsTester.jar
export PATH=$JAVA_HOME/bin:$WEBLOGIC_HOME/server/bin:$PATH
date > /tmp/ws-test.log;

FAILURE=0

java wsTester.Test /home/justin/scripts/ws-tester/wsTester.ws5.properties 
EXITVAL=$?

if [[ $EXITVAL -ne 0 ]]; then
	echo "WS4 Long/Short query timed out!" >> /tmp/ws-test.log 2>&1;
	FAILURE=1
fi;

echo "=================================" >> /tmp/ws-test.log 2>&1



