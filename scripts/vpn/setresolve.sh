#!/bin/bash

SEARCH_STRING=`head -1 /etc/resolv.conf`;

SEARCH_STRING="$SEARCH_STRING mso.mci.com ebiz.verizon.com"

sed -i "s/^search.*/$SEARCH_STRING/" /etc/resolv.conf;
