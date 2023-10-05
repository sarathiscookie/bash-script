#!/bin/bash

echo ############################################

date

cat /var/run/httpd/httpd.pid > /dev/null

if [ $? == 0 ]
then
    echo "Httpd process is running"
else
    echo "Httpd process not running"

    systemctl start httpd
    
    if [ $? == 0 ]
    then
	echo "Process started by script"
    else
	echo "Whoops! Script tried to start the httpd process but something happend"
    fi
fi		

echo ############################################
