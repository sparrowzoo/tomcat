SERVICE_NAME=$1

echo -e "Starting the $SERVICE_NAME ...\n"

#JAVA_OPTS=" $JAVA_OPTS -Xmx256m -Xms256m -Xmn128m -XX:PermSize=64m -XX:MaxPermSize=64m -Xss256k "
#JAVA_OPTS=" $JAVA_OPTS -Xmx512m -Xms512m -Xmn128m -XX:PermSize=64m -XX:MaxPermSize=64m -Xss256k "
JAVA_OPTS=" -Xmx2g -Xms2g -Xmn300m -XX:PermSize=128m -XX:MaxPermSize=128m -Xss256k "
JAVA_OPTS=" $JAVA_OPTS -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=70 -XX:+PrintGCDateStamps -XX:+HeapDumpOnOutOfMemoryError "
echo nohup java -jar jenkins/$SERVICE_NAME.jar $JAVA_OPTS "> /dev/null 2>&1 &"

nohup java -jar jenkins/$SERVICE_NAME.jar $JAVA_OPTS > /dev/null 2>&1 &
