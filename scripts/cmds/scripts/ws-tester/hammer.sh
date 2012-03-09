#!/usr/bin/bash

function run5() {
	./runWsTestSingle.sh &
	./runWsTestSingle.sh &
	./runWsTestSingle.sh &
	./runWsTestSingle.sh &
	./runWsTestSingle.sh &
}

function run10() {
	run5 &
	run5 &
}

function run20() {
	run10 &
	run10 &
}

while [[ 1 -eq 1 ]]; do 
	clear; 
	PIDCOUNT=`ps -ef | grep java | grep -v grep | wc -l`;
	if [[ $PIDCOUNT -gt 40 ]]; then
		echo "ABORT!"
		./die
	fi
	date;
	run5 >/dev/null 2>&1
	ps -ef | grep java | grep -v grep | wc -l
	sleep 10;
done;
