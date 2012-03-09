#!/usr/bin/bash

SERVER_LIST=$2
USER=$1
USER_LIST=$3

rm -Rf user-lists 2>/dev/null
mkdir -p user-lists

rm -Rf accounts-needed 2>/dev/null
mkdir -p accounts-needed

for i in `cat $SERVER_LIST`; do echo "Pulling passwd from: $i... "; ssh $USER@$i "cat /etc/passwd" > user-lists/$i 2>/dev/null; done; 

ls user-lists > prime

for i in `cat $USER_LIST`; do 
	USERNAME=`echo $i | awk -F':' '{print $1}'`;
	ONEWORLD=`echo $i | awk -F':' '{print $2}'`;
	REAL_NAME=`echo $i | awk -F':' '{print $3}'`;
	
	#echo "Examining user: $USERNAME"
        echo "Real Name: $REAL_NAME" 
        echo "One World: $ONEWORLD" 
        echo "Desired User ID: $USERNAME" 
	
	echo "Account needed on:"

	grep -l $USERNAME user-lists/* | sed 's/user-lists\///' > this-user;
	diff prime this-user | grep '<' | sed 's/< //'
	
	echo "==========================="

#	for i in `diff prime this-user | grep '<' | sed 's/< //'`; do
#		echo "Real Name: $REAL_NAME" >> accounts-needed/$i-needs
#		echo "One World: $ONEWORLD" >> accounts-needed/$i-needs
#		echo "Desired User ID: $USERNAME" >> accounts-needed/$i-needs
#		echo "===========================" >> accounts-needed/$i-needs
#	done;
	rm this-user 2>/dev/null
done;
rm -Rf user-lists
rm prime
