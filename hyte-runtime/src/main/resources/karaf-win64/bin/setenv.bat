@echo off
rem
rem
rem    Licensed to the Apache Software Foundation (ASF) under one or more
rem    contributor license agreements.  See the NOTICE file distributed with
rem    this work for additional information regarding copyright ownership.
rem    The ASF licenses this file to You under the Apache License, Version 2.0
rem    (the "License"); you may not use this file except in compliance with
rem    the License.  You may obtain a copy of the License at
rem
rem       http://www.apache.org/licenses/LICENSE-2.0
rem
rem    Unless required by applicable law or agreed to in writing, software
rem    distributed under the License is distributed on an "AS IS" BASIS,
rem    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem    See the License for the specific language governing permissions and
rem    limitations under the License.
rem

rem Get Current DateTime stamp
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined NOW set NOW=%%x
SET KARAF_STARTDATE=%NOW:~0,14%

rem
rem handle specific scripts; the SCRIPT_NAME is exactly the name of the Karaf
rem script; for example karaf.bat, start.bat, stop.bat, admin.bat, client.bat, ...
rem
rem if "%KARAF_SCRIPT%" == "SCRIPT_NAME" (
rem   Actions go here...
rem )

IF "%KARAF_SCRIPT%" == "client.bat" OR "%KARAF_SCRIPT%" == "status.bat" OR "%KARAF_SCRIPT%" == "stop.bat" (
    set JAVA_MIN_MEM=16M
    set JAVA_MAX_MEM=128M
) ELSE (
    set JAVA_MIN_MEM=512M
    set JAVA_MAX_MEM=2G
)

rem
rem general settings which should be applied for all scripts go here; please keep
rem in mind that it is possible that scripts might be executed more than once, e.g.
rem in example of the start script where the start script is executed first and the
rem karaf script afterwards.
rem

rem Begin HYTE
set JAVA_CMS_GC_OPTS=-XX:ParallelGCThreads=2 -XX:+UseConcMarkSweepGC -XX:+UseParNewGC
set JAVA_CMS_GC_ADV_OPTS=-XX:+CMSConcurrentMTEnabled -XX:+CMSClassUnloadingEnabled -XX:+CMSParallelRemarkEnabled -XX:+ExplicitGCInvokesConcurrent -XX:+ExplicitGCInvokesConcurrentAndUnloadsClasses -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70 -XX:+ScavengeBeforeFullGC -XX:+CMSScavengeBeforeRemark
set JAVA_G1_GC_OPTS=-XX:+UseG1GC -XX:+UseStringDeduplication -XX:MaxGCPauseMillis=800 
set JAVA_GC_LOG_OPTS=-verbose:gc -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+PrintGCDetails -Xloggc:data\log\gc-%KARAF_STARTDATE%.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=16 -XX:GCLogFileSize=16M 
set JAVA_HEAPDUMP_OPTS=-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=data\log\%KARAF_STARTDATE%.hprof
set JAVA_MISC_OPTS=-server
set JAVA_NET_OPTS=-Dsun.net.inetaddr.ttl=60 -Dsun.net.client.defaultConnectTimeout=300000 -Dsun.net.client.defaultReadTimeout=600000
rem END HYTE

set EXTRA_JAVA_OPTS=%JAVA_G1_GC_OPTS% %JAVA_GC_LOG_OPTS% %JAVA_HEAPDUMP_OPTS% %JAVA_MISC_OPTS% %JAVA_NET_OPTS%
rem SET KARAF_HOME
rem SET KARAF_DATA
rem SET KARAF_BASE
rem SET KARAF_ETC
rem SET KARAF_OPTS

rem
rem The following section shows the possible configuration options for the default 
rem karaf scripts
rem
rem Window name of the windows console
rem SET KARAF_TITLE
rem Location of Java installation
rem SET JAVA_HOME
rem Minimum memory for the JVM
rem SET JAVA_MIN_MEM
rem Maximum memory for the JVM
rem SET JAVA_MAX_MEM
rem Minimum perm memory for the JVM
rem SET JAVA_PERM_MEM
rem Maximum perm memory for the JVM
rem SET JAVA_MAX_PERM_MEM
rem Additional JVM options
rem SET EXTRA_JAVA_OPTS 
rem Karaf home folder
rem SET KARAF_HOME
rem Karaf data folder
rem SET KARAF_DATA
rem Karaf base folder
rem SET KARAF_BASE
rem Karaf etc folder
rem SET KARAF_ETC
rem First citizen Karaf options
rem SET KARAF_SYSTEM_OPTS
rem Additional available Karaf options
rem SET KARAF_OPTS
rem Enable debug mode
rem SET KARAF_DEBUG

