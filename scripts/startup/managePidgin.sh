#!/usr/bin/bash


removeSametime() {
	cp /home/jainswor/.purple/accounts-no-sametime.xml /home/jainswor/.purple/accounts.xml;
}

includeSametime() {
	cp /home/jainswor/.purple/accounts-all.xml /home/jainswor/.purple/accounts.xml;
}


while true; do
	removeSametime;
	/usr/bin/pidgin & 
	PID=$!;
	sleep 5;
	kill $PID;
	includeSametime
	/usr/bin/pidgin;
done;

