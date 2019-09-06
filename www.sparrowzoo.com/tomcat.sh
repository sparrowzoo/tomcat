#!/bin/bash
# chkconfig: - 96 14
# description: Tht Apache Tomcat Servlet/JSP container.
#

source /etc/profile
export CATALINA_BASE="$PWD"
export JAVA_OPTS="-server -Xms2G -Xmx2G"

export JAVA_HOME=/home/jdk1.8.0_20
export CATALINA_HOME=/usr/java/apache-tomcat-8.0.22
export PATH=$PATH:$JAVA_HOME/bin

STARTUP=$CATALINA_HOME/bin/startup.sh
SHUTDOWN=$CATALINA_HOME/bin/shutdown.sh
case $1 in
start)
   result=$(ps -ef |grep "$CATALINA_BASE"  |  grep -v grep &>/dev/null)
   if [ -n "$result" ];then
       echo -e "\033[0;31;2mWaring:\\t\t$prog has been start\033[0m"
   else
       echo -n "Starting $prog: "
       su tomcat -s /bin/bash $STARTUP
   fi
   ;;
stop)
   if ps -ef |grep "$CATALINA_BASE"  |  grep -v grep &>/dev/null;then
       echo -n "Stopping $prog: "
       ps -ef |grep "$CATALINA_BASE"  |  grep -v grep |awk '{print $2}' | xargs kill -9
       RETVAL=$?
       [ $RETVAL -eq 0 ]  && echo -e "\t\t\033[0;32;2m[ok]\033[0m"
   else
       echo -e "\033[0;31;2mWaring:\\t\t$prog not start\033[0m"
   fi
   ;;
restart)
    if ps -ef |grep "$CATALINA_BASE"  |  grep -v grep &>/dev/null;then
       echo -n "Stopping $prog: "
       ps -ef |grep "$CATALINA_BASE"  |  grep -v grep |awk '{print $2}' | xargs kill -9
       RETVAL=$?
       [ $RETVAL -eq 0 ]  && echo -e "\t\t\033[0;32;2m[ok]\033[0m"

        result=$(ps -ef |grep "$CATALINA_BASE"  |  grep -v grep &>/dev/null)
        if [ -n "$result" ];then
            echo -e "\033[0;31;2mWaring:\\t\t$prog has been start\033[0m"
        else
            echo -n "Starting $prog: "
            su tomcat -s /bin/bash $STARTUP
        fi
        echo -n "Restart complete"
   else
       echo -e "\033[0;31;2mWaring:\\t\t$prog not start\033[0m"
   fi
    ;;
*)
   echo "Usage: tomcat [start|stop|reload|restart]"
   exit 1
esac
exit 0