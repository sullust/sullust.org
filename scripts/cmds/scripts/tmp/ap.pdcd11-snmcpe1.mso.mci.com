#AutoProv Properties
#Mon Jun 14 15:56:56 EDT 2004
CONCORD_ENVIRONMENT_VARIABLE=NH_HOME
CONCORD_NUM_CONN=1
CONCORD_LOGIN_USE_KEY=true
CONCORD_MINIMUM_PROCESSES=8
CONCORD_NHCONFIG_WAIT=3
CONCORD_NHCONFIG_MAXWAIT=60
CONCORD_LICENSE_PERCENT=95
CONCORD_DBR_CMD=/concord/autoprov/bin/concord_dbdump.pl 
CONCORD_COMMAND_PREFIX=. /concord/ehealth/nethealthrc.sh ;

SMARTS_CONFIG_FILENAME=/usr/local/SMARTS_Config
SMARTS_LOGIN_USE_KEY=true
SMARTS_SCRIPTS_DIR=/usr/local/scripts
SMARTS_ADD_CMD=/usr/local/scripts/amprov /usr/local/scripts/discover_esp -verbose -debug <smarts_instances>
SMARTS_ENTITY_DELETE_CMD=/usr/local/scripts/amprov /usr/local/scripts/delete_agent -verbose -npn -force -dns <smarts_instances>
SMARTS_DNSENTITY_DELETE_CMD=/usr/local/scripts/amprov /usr/local/scripts/add_del_dns.pl -x -d 
SMARTS_CUSTOMER_DELETE_CMD=/usr/local/scripts/amprov /usr/local/scripts/delete_customer -v -d <smarts_instances>
SMARTS_NPM_CMD=/usr/local/scripts/amprov /usr/local/scripts/newprov  <smarts_instances>
SMARTS_NUM_CONN=1
SMARTS_FEATURE_CMD=/usr/local/scripts/amprov /usr/local/scripts/v2feature <smarts_instances>
SMARTS_FEATURE_WAIT=15
SMARTS_FEATURE_STATE_CMD=/usr/local/scripts/amprov /usr/local/scripts/isFeatureMgd <smarts_instances>
SMARTS_FEATURE_VERIFY_WAIT=600
SMARTS_BACKUP_DELAY=10
DISCOVER_CMD=/usr/local/scripts/amprov /usr/local/scripts/dm
DISCOVER_LOGIN_USE_KEY=true
SSH_ATTEMPTS=30
SSH_ATTEMPT_WAIT=1
USE_POOLING=false
RESULTS_PAUSE_TIME=15000
RESULTS_NUM_ATTEMPTS=120

# This setting can be used to ensure that all output from a command
# that is executed is gathered and returned.  It does this by
# using a temporary file.  This is slower at runtime, but protected
# from any bugs in the J2SSH libraries.
# this is ONLY used by J2SSH
SLOW_SAFE_CMD_EXECUTION=true

# Should requests be programmatically verified by exporting
# data and ensuring that requested updates were actually made.
# This should be left on for development, but disabled
# for production use.
VERIFY_REQUESTS=false

# How many minutes to allow a command to execute without generating
# any output before it is considered to have failed.
SSH_TIMEOUT_MINUTES=60

SSH_CONNECTION_FACTORY=JSCH
DQ_TEST_MODE=true
DQ_TEST_DIR=/esp/snmcpe5-5/jboss-5.1.0.GA/server/snmcpe/dqtest


