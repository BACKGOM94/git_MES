JAVA_DIR=/usr/local/jdk1.6.0
UBISERVICE_DIR=/usr/share/tomcat-http/webapps/ROOT/UbiService
PROPERTY_DIR=$UBISERVICE_DIR
FONT_DIR=$UBISERVICE_DIR/fonts/
CLASSPATH=$UBISERVICE_DIR/lib/UbiServer.jar
XMS=1024M
XMX=2048M

GREP_STR=$UBISERVICE_DIR/lib/UbiServer.jar

#For SunOS
#if [ `/usr/ucb/ps -auxwww | grep $GREP_STR | grep -v grep | awk '{print $2}'` ];then
#	kill -9 `/usr/ucb/ps -auxwww | grep $GREP_STR | grep -v grep | awk '{print $2}'`

if [ `ps -ef | grep $GREP_STR | grep -v grep | awk '{print $2}'` ];then
	kill -9 `ps -ef | grep $GREP_STR | grep -v grep | awk '{print $2}'`
	echo ""
	echo ">>> UbiService has shutdown."
	$JAVA_DIR/bin/java -Xms$XMS -Xmx$XMX -Dfile.encoding=UTF-8 -Djava.awt.headless=true -Dsun.java2d.fontpath=$FONT_DIR -classpath $CLASSPATH:. com.ubireport.service.UbiService4 $PROPERTY_DIR &
	echo ">>> UbiService has started."
	echo ""
else
	echo ""
	echo ">>> UbiService is not running."
	echo ""
fi
