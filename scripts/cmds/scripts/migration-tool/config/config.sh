#!/usr/bin/bash

export FROM_VERSION=1111
export TO_VERSION=1202
export BASE_PROJECT_DIR=/esp/

#export READONLY_COMMERCIAL=ESPDEV
#export READONLY_NETWORX=ESPTST
#export READONLY_VOIP=ESPBKP

export READONLY_COMMERCIAL=ESPPROD2
export READONLY_NETWORX=ESPSUB1
export READONLY_VOIP=ESPVOIP


export SHAKEOUT_TOOLS_SERVER="pdcc01-espws1.mso.mci.com";
export SHAKEOUT_ESPWS_SERVER="pdcc01-espws1.mso.mci.com";

export IS_SHAKEOUT="false";
export MAKE_SOURCE_READ_ONLY="true";
export DB_READONLY="false";

export IMPORT_PORT_MAP=1

export SNMCPE_MIGRATION=1


###################
# Shortcut Variable
###################
export FROM=$FROM_VERSION
export TO=$TO_VERSION
