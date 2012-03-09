#!/usr/bin/bash

HOME_DIR=/home/jainswor

echo "Cleaning up staging directory:"
touch $HOME_DIR/staging
find $HOME_DIR/staging -mtime +10 -type f -print -exec rm -f {} \;
find $HOME_DIR/staging -mtime +10 -type d -print -exec rmdir {} \; 2>/dev/null

echo "Cleaning up tmp directory:"
touch $HOME_DIR/tmp
find $HOME_DIR/tmp -mtime +10 -type f -print -exec rm -f {} \;
find $HOME_DIR/tmp -mtime +10 -type d -print -exec rmdir {} \; 2>/dev/null

if [[ -e $HOME_DIR/downloads ]]; then
echo "Cleaning up downloads directory:"
touch $HOME_DIR/downloads
find $HOME_DIR/downloads -mtime +10 -type f -print -exec rm -f {} \;
find $HOME_DIR/downloads -mtime +10 -type d -print -exec rmdir {} \; 2>/dev/null
fi

if [[ -e $HOME_DIR/download ]]; then
echo "Cleaning up download directory:"
touch $HOME_DIR/download
find $HOME_DIR/download -mtime +10 -type f -print -exec rm -f {} \;
find $HOME_DIR/download -mtime +10 -type d -print -exec rmdir {} \; 2>/dev/null
fi
