#!/usr/bin/bash

export FROM_VERSION=1107
export TO_VERSION=1109
export BASE_PROJECT_DIR=/esp/esp_projects

export READONLY_COMMERCIAL=ESPDEV
export READONLY_NETWORX=ESPTST
export READONLY_VOIP=ESPBKP

export SHAKEOUT_TOOLS_SERVER="esptd8.vzbi.com";
export SHAKEOUT_ESPWS_SERVER="esptd8.vzbi.com";

export IS_SHAKEOUT="false";
export MAKE_SOURCE_READ_ONLY="true";








###################
# Shortcut Variable
###################
export FROM=$FROM_VERSION
export TO=$TO_VERSION