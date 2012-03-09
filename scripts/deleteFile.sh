#!/usr/bin/csh
if( -e $1) then;
	/usr/bin/rm -f $1;
	echo "true"
	exit 0
else
	echo "false"
	exit 1
endif
