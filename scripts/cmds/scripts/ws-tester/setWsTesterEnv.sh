echo set the environment for building the module 
export BEA_HOME=/bea
export WEBLOGIC_HOME=$BEA_HOME/weblogic81 
export JAVA_HOME=$BEA_HOME/jdk141_05
export CLASSPATH=.:$WEBLOGIC_HOME/server/lib/weblogic.jar:$WEBLOGIC_HOME/server/lib/webservices.jar:./wsTester.jar
echo "::  BEA_HOME = $BEA_HOME"  
echo "::  WEBLOGIC_HOME = $WEBLOGIC_HOME"
echo "::  JAVA_HOME = $JAVA_HOME" 
echo "::  CLASSPATH = $CLASSPATH" 
export PATH=$JAVA_HOME/bin:$WEBLOGIC_HOME/server/bin:$PATH
