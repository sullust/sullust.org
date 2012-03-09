#!/usr/bin/bash

. ./validation-info.sh

#TOOLS_SERVER=espws5.vzbi.com
#TOOLS_PORT=9007
#TOOLS_CONNECTION_T3=t3
#TOOLS_CONNECTION_HTTP=http


INSTANCE_DIR=$1;
MONITORING_DIR=`find $INSTANCE_DIR -type d -name "*monitor"`
INSTANCE_SUBDIR=`echo $INSTANCE_DIR | sed 's/.*\///'`
INSTANCE_SUBDIR_VERSIONLESS=`echo $INSTANCE_SUBDIR | sed 's/_..$//'`

echo "Monitoring should be disabled: ";
sudo crontab -l | grep monitor
echo ""

if [ -z $INSTANCE_DIR/properties/espws.properties ]; then
	echo "Verify server url is localhost:7009 in $INSTANCE_DIR/properties/espws.properties"
	grep server.url $INSTANCE_DIR/properties/espws.properties
	echo ""
fi

echo "Verify TOOLS server settings in esp.properties:"
echo "Tools server should be $TOOLS_SERVER:$TOOLS_PORT"
grep TOOLS_SECURE_SERVER $INSTANCE_DIR/esp.properties
grep TOOLS_PORT $INSTANCE_DIR/esp.properties | grep -v AIM
grep TOOLS_SERVER_MAIN $INSTANCE_DIR/esp.properties
grep TOOLS_SERVER_BACKUP $INSTANCE_DIR/esp.properties
echo ""

echo "Verify test modes are disabled:"
grep TEST_MODE $INSTANCE_DIR/esp.properties
echo ""

echo "Start scripts should have production level memory: "
grep Xmx $INSTANCE_DIR/bin/startWebLogic.sh | grep -v '\#'
echo ""

echo "Read Only mode should be false:"
grep READONLY_MODE $INSTANCE_DIR/esp.properties
echo ""

echo "EMAIL should be on:"
grep 'SEND_EMAIL=' $INSTANCE_DIR/esp.properties
echo ""

echo "Read/Write databases configured:"
grep '<url>' $INSTANCE_DIR/config/jdbc/CP-*.xml
echo ""

echo "Monitoring script should reference $INSTANCE_DIR: "
grep 'set SERVER_DIR' $MONITORING_DIR/*.sh
echo ""

echo "Verify latest code has been published:"
	if [ "X`grep -l ear $INSTANCE_DIR/config/config.xml`"="X" ]; then
		ls -ld $INSTANCE_DIR/applications
	else 	
		grep '\.ear' $INSTANCE_DIR/config/config.xml
	fi
echo ""

echo "Verify production ports are in config.xml ($PROD_HTTP_PORT and $PROD_HTTPS_PORT):"
grep listen-port $INSTANCE_DIR/config/config.xml
echo ""

echo "The following scripts do not reference $INSTANCE_DIR"
grep $INSTANCE_SUBDIR_VERSIONLESS $INSTANCE_DIR/bin/*.sh | grep -v $INSTANCE_SUBDIR
grep $INSTANCE_SUBDIR_VERSIONLESS $INSTANCE_DIR/*.sh | grep -v $INSTANCE_SUBDIR
grep $INSTANCE_SUBDIR_VERSIONLESS $INSTANCE_DIR/start* | grep -v $INSTANCE_SUBDIR
echo ""

if [ -z `grep -l $INSTANCE_SUBDIR_VERSIONLESS /esp/bin/instances` ]; then
	echo "/esp/bin/instances doesn't reference $INSTANCE_SUBDIR_VERSIONLESS"
	cat /esp/bin/instances
	echo ""
fi;

HOSTNAME=`hostname`
if [ -z `grep ESP_SERVER_HOST $INSTANCE_DIR/esp.properties  | grep $HOSTNAME` ]; then
	echo "ESP_SERVER_HOST must be equal to $HOSTNAME";
	grep ESP_SERVER_HOST $INSTANCE_DIR/esp.properties;
	echo ""
fi

echo "Verify CVS properties merged with prod"

echo "esp.properties compare:"
diff $INSTANCE_DIR/esp.properties $2
