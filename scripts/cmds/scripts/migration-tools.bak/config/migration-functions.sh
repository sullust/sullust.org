#!/usr/bin/bash

function doCopy() {
	./instance-copy/WebLogic-Instance-Copy.sh; OUTPUT=$?;
	if [[ $OUTPUT != "0" ]]; then 
		echo "Error running script... ./instance-copy/WebLogic-Instance-Copy.sh";
		exit 1;
	fi

	./instance-copy/Copy-ESPWS-Archives.sh; OUTPUT=$?;
	if [[ $OUTPUT != "0" ]]; then 
		echo "Error running script... ./instance-copy/Copy-ESPWS-Archives.sh";
		exit 1;
	fi	
}

function doPathFix() {
	./instance-copy/Migrate-WebLogic.sh; OUTPUT=$?;
	if [[ $OUTPUT != "0" ]]; then 
		echo "Error running script... ./instance-copy/Migrate-WebLogic.sh";
		exit 1;
	fi
}

function doPortMap() {
	./Ports/MapPorts.pl $@; OUTPUT=$?;
	if [[ $OUTPUT != "0" ]]; then 
		echo "Error running script... ./Ports/MapPorts.pl $@";
		exit 1;
	fi
}

function doMakeReadOnly() {
	./readonly/Prepare-ReadOnly.sh; OUTPUT=$?;
	if [[ $OUTPUT != "0" ]]; then 
		echo "Error running script ./readonly/Prepare-ReadOnly.sh...";
		exit 1;
	fi
}

function doDeployReadOnly() {
	./readonly/Deploy-ReadOnly.sh; OUTPUT=$?;
	if [[ $OUTPUT != "0" ]]; then
		echo "Error running script ./readonly/Deploy-ReadOnly.sh...";
		exit 1;
	fi;
}

function doStartReadOnly() {
	./readonly/Start-ReadOnly.sh; OUTPUT=$?;
	if [[ $OUTPUT != "0" ]]; then
		echo "Error running script ./readonly/Start-ReadOnly.sh...";
		exit 1;
	fi;
}

function doPrepareShakeout() {
	./shakeout/Prepare-Shakeout.sh; OUTPUT=$?;
	if [[ $OUTPUT != "0" ]]; then
		echo "Error running script ./shakeout/Prepare-Shakeout.sh...";
		exit 1;
	fi;
}

function doDeployShakeout() {
	./shakeout/Deploy-Shakeout.sh; OUTPUT=$?;
	if [[ $OUTPUT != "0" ]]; then
		echo "Error running script ./shakeout/Deploy-Shakeout.sh...";
		exit 1;
	fi;
}

function doStartShakeout() {
	./shakeout/Start-Shakeout.sh; OUTPUT=$?;
	if [[ $OUTPUT != "0" ]]; then
		echo "Error running script ./shakeout/Start-Shakeout.sh...";
		exit 1;
	fi;
}

function printConfig() {
	echo "CONFIG!";
}

function createExcludeFile() {
cat > /tmp/exclude-file.$$ <<EOF
*log0*
*.log
*.bak
*.zip
tmp
expgc.txt
EOF
}

function generateClearCache() {
cat > $1/clearWebLogicCache.sh <<EOF
#!/usr/bin/bash
DIR=/esp/esp_projects/$1
cd \$DIR
mv servers/espwsserver/data/ldap ./ldap.\$\$; 
rm -Rf servers
mkdir -p servers/espwsserver/data/
mv ldap.\$\$ servers/espwsserver/data/ldap
rm -Rf rmfilestore
EOF
	chmod 755 $1/clearWebLogicCache.sh
}

function printHR() {
	LINE_LENGTH=$1;
	I=0;
	PRINTED_LINE="";
	while [[ $I -lt $LINE_LENGTH ]]; do 
		PRINTED_LINE=$PRINTED_LINE"=";
		I=`expr $I + 1`;
	done;
	echo $PRINTED_LINE;
}

function printBegin() {
	LINE="== Begin $0 - `date`";
	LINE_LENGTH=`echo $LINE | wc -m`;

	printHR $LINE_LENGTH;
	echo $LINE;
	printHR $LINE_LENGTH
}

function printEnd() {
	LINE="== Begin $0 - `date`";
	LINE_LENGTH=`echo $LINE | wc -m`;

	printHR $LINE_LENGTH;
}