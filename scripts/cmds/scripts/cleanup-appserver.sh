#!/usr/bin/bash

DOMAIN_DIR="/esp/esp_projects/"

echo "Removing old application backups:"
find $DOMAIN_DIR -name "app*.bak" -type d -mtime +30 -print -exec rm -Rf {} \;

echo "Removing old application deploys:"
find $DOMAIN_DIR -name "*app*.zip" -type f -mtime +30 -print -exec rm -Rf {} \;
