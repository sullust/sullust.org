#!/usr/bin/bash

HOME_DIR=/home/jainswor

echo "Cleaning up staging directory:"
touch $HOME_DIR/staging
find $HOME_DIR/staging -mtime +10 -type f -print -exec rm -f {} \;
find $HOME_DIR/staging -mtime +10 -type d -empty -print -exec rmdir {} \; 

echo "Cleaning up tmp directory:"
touch $HOME_DIR/Documents/tmp
find $HOME_DIR/Documents/tmp -mtime +2 -type f -print -exec rm -f {} \;
find $HOME_DIR/Documents/tmp -mtime +2 -type d -empty -print -exec rmdir {} \; 

echo "Cleaning up Documents tmp directory:"
touch $HOME_DIR/tmp
find $HOME_DIR/tmp -mtime +2 -type f -print -exec rm -f {} \;
find $HOME_DIR/tmp -mtime +2 -type d -empty -print -exec rmdir {} \;


if [[ -e $HOME_DIR/downloads/ ]]; then
echo "Cleaning up downloads directory:"
touch $HOME_DIR/downloads/
find $HOME_DIR/downloads/ -mtime +10 -type f -print -exec rm -f {} \;
find $HOME_DIR/downloads/ -mtime +10 -type d -empty -print -exec rmdir {} \; 
find $HOME_DIR/downloads/ -name "*.pls" -type f -exec rm -f {} \;
fi

if [[ -e $HOME_DIR/download ]]; then
echo "Cleaning up download directory:"
touch $HOME_DIR/download
find $HOME_DIR/download/ -mtime +10 -type f -print -exec rm -f {} \;
find $HOME_DIR/download/ -mtime +10 -type d -empty -print -exec rmdir {} \;
fi

if [[ -e $HOME_DIR/Music/podcasts ]]; then
echo "Cleaning up podcasts:"
find /home/jainswor/Music/podcasts/ \
! -name "*YogPod*" \
! -name "You_Look_Nice_Today" \
-mtime +7 -type f -print -exec rm -f {} \;
#find /home/jainswor/Music/podcasts -mtime +7 -type f -print -exec rm -f  {} \;

echo "Cleaning up Minecraft:"
find /home/jainswor/.minecraft -name "saves.*.gz" -mtime +2 -exec rm -f {} \;

fi
