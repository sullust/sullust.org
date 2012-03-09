#!/usr/bin/bash
#/esp/snmcpe5-5/jboss-5.1.0.GA/server/snmcpe/conf/bindingservice.beans/META-INF/bindings-jboss-beans.xml

FILE=$1
for port in `grep 'property name="port"' $FILE | sed 's/.*">//' | sed 's/<.*//'`; do 
        echo -n "$port -> ";
        P2=$port;
        LOOP=0;
        while [[ $LOOP -eq 0 ]]; do
                if [[ -z `/esp/bin/openSocket.pl localhost $P2 2>/dev/null` ]]; then
                        echo $P2;
                        sed "s/$port/$P2/" $FILE >/tmp/foo;
                        mv /tmp/foo $FILE;

                        LOOP=1;
                fi
                P2=`expr $P2 + 1`;
        done;
done;

