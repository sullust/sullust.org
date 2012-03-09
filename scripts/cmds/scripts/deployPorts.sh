#!/usr/bin/bash
for dir in `ls -d *_1105 | grep -v cpe | grep -v extra | grep -v timeout`; do 
        for i in `find $dir -name "*.shk"`; do 
                echo "Copying $i"; 
                I=`echo $i | sed 's/\.shk//'`; 
                cp $i $I; 
        done; 

        cd $dir;
	chmod 755 start*
	chmod 755 bin/*
        ./start*
        cd ../

done;
