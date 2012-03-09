#!/usr/bin/sh
JAVA_HOME=/esp/jdk160_17
MEM_ARGS="-Xmx2500m -XX:PermSize=256m -XX:MaxPermSize=256m"
export MEM_ARGS
JAVA_OPTS="-Ddomain.path=/esp/snmcpe_prod_1109/jboss-5.1.0.GA/server/snmcpe  ${MEM_ARGS} "
export JAVA_HOME
JAVA_OPTS="${JAVA_OPTS} -Djavax.net.ssl.trustStore=/esp/snmcpe_prod_1109/jboss-5.1.0.GA/server/snmcpe/conf/ssl/tools -Djavax.net.ssl.trustStorePassword=p@ssw0rd"
export CLASSPATH
export JAVA_HOME
export JAVA_OPTS
rm snmcpe.log 2>/dev/null
rm boot.log 2>/dev/null
#./run.sh -b 146.170.65.21 -c snmcpe > snmcpe.log 2>snmcpe.log&
./run.sh -b 0.0.0.0 -c snmcpe  >/dev/null 2>&1
sleep 1;
ln -s ../server/snmcpe/log/server.log ./snmcpe.log
ln -s ../server/snmcpe/log/boot.log ./boot.log
#> snmcpe.log 2>snmcpe.log&
