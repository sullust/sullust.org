#!/usr/bin/bash
echo "Creating fresh shakeout configs"
echo "Cleaning old configs..."
find *_1105 -name "*.shk*" -print -exec rm {} \;
find *_1105 -name esp.properties > /tmp/props
find *_1105 -name espws.properties >>/tmp/props
for i in `cat /tmp/props `; do echo "Creating $i.shk"; sed 's/SEND_EMAIL=1/SEND_EMAIL=0/' $i > /tmp/prop;  mv /tmp/prop $i.shk; done;
for i in `find *_1105 -name "start*.sh" -exec grep -l Xmx {} \;`; do sed 's/-Xms.*m -Xmx....m/-Xms512m -Xmx512m/' $i > /tmp/mem;  cp /tmp/mem $i.shk;  cp $i $i.rw;  chmod 755 $i*; done; 
for i in `find *_1105 -name config.xml`; do echo "Creating $i.shk"; cp $i $i.shk; done;
