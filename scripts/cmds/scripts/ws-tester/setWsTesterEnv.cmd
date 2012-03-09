@echo off
@rem set the environment for building the module
@set BEA_HOME=c:\bea
@set WEBLOGIC_HOME=%BEA_HOME%\weblogic81
@set JAVA_HOME=%BEA_HOME%\jdk141_05
@set CLASSPATH=.;%WEBLOGIC_HOME%\server\lib\weblogic.jar;%WEBLOGIC_HOME%\server\lib\webservices.jar;.\wsTester.jar
@rem  print the info
@echo ::  BEA_HOME      = %BEA_HOME%     
@echo ::  WEBLOGIC_HOME = %WEBLOGIC_HOME%
@echo ::  JAVA_HOME     = %JAVA_HOME%    
@echo ::  CLASSPATH     = %CLASSPATH%
@set PATH=%JAVA_HOME%\bin;%WEBLOGIC_HOME%\server\bin;%PATH%
title ws_tester
