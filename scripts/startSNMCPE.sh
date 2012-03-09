#!/usr/bin/sh
JAVA_HOME=/esp/java15
MEM_ARGS="-Xms512m -Xmx1512m"
export MEM_ARGS
JAVA_OPTS="-Ddomain.path=/esp/snmcpe_prod_92/jboss-4.2.2.GA/server/snmcpe  ${MEM_ARGS} "
export JAVA_HOME
JAVA_OPTS="${JAVA_OPTS} -Djavax.net.ssl.trustStore=/esp/snmcpe_prod_92/jboss-4.2.2.GA/server/snmcpe/conf/ssl/tools -Djavax.net.ssl.trustStorePassword=p@ssw0rd"
export JAVA_HOME
export JAVA_OPTS
#./run.sh -b 146.170.65.21 -c snmcpe > snmcpe.log 2>snmcpe.log&
./run.sh -b 0.0.0.0 -c snmcpe > snmcpe.log 2>snmcpe.log&
