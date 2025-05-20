UBISERVICE_DIR=/usr/share/tomcat-http/webapps/ROOT/UbiService

GREP_STR=$UBISERVICE_DIR/lib/UbiServer.jar

#For SunOS
#if [ `/usr/ucb/ps -auxwww | grep $GREP_STR | grep -v grep | awk '{print $2}'` ];then
#	kill -9 `/usr/ucb/ps -auxwww | grep $GREP_STR | grep -v grep | awk '{print $2}'`

if [ `ps -ef | grep $GREP_STR | grep -v grep | awk '{print $2}'` ];then
	kill -9 `ps -ef | grep $GREP_STR | grep -v grep | awk '{print $2}'`
	echo ""
	echo ">>> UbiService has shutdown."
	echo ""
else
	echo ""
	echo ">>> UbiService is not running."
	echo ""
fi
