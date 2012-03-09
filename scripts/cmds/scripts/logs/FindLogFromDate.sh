#!/usr/bin/bash

LOG_PATH=$1;

echo $LOG_PATH;

for i in `ls $LOG_PATH/* | grep -v 'access.log'`; do
	FILE_NAME=`echo $i | sed 's/.*\///g'`;
	echo -n "$FILE_NAME: "
	LINE_ONE=`gunzip -c $i | grep '^####<' | head -1 \
		| sed 's/> <.*/>/g' \
		| awk '{print $1" "$2" "$3" "$4" "$5" "$6}' \
		| sed 's/^####//'`
	echo $LINE_ONE;
done