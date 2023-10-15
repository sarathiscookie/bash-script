#!/bin/bash

TEMPDIR="/tmp/webfiles"
ART_NAME="2098_health"
URL="https://www.tooplate.com/zip-templates/2098_health.zip"

yum --help &> /dev/null

if [ $? == 0 ]
then
    PACKAGE="wget unzip httpd"
    SVC="httpd"

    echo "### Running setup on Centos. ###"
    sudo yum install $PACKAGE -y > /dev/null
    echo

    echo "#### Starting and Enabling httpd service ####"
    sudo systemctl start $SVC
    sudo systemctl enable $SVC
    echo

    echo "### Creating temp webfiles directory ###"
    mkdir -p $TEMPDIR
    cd $TEMPDIR
    echo

    wget $URL > /dev/null
    unzip $ART_NAME.zip > /dev/null
    sudo cp -r $ART_NAME/* /var/www/html/
    echo

    echo "Restarting httpd service"
    sudo systemctl restart $SVC
    echo 

    echo "Removing temp files"
    sudo rm -rf $TEMPDIR

    sudo systemctl status $SVC
    ls -l /var/www/html

    echo "### Script completed. Check the log file for the details: $log_file"
else
    PACKAGE="wget unzip apache2"
    SVC="apache2"

    echo "### Running setup on Ubuntu. ###"
    sudo apt update
    sudo apt install $PACKAGE -y > /dev/null
    echo

    echo "#### Starting and Enabling httpd service ####"
    sudo systemctl start $SVC
    sudo systemctl enable $SVC
    echo

    echo "### Creating temp webfiles directory ###"
    mkdir -p $TEMPDIR
    cd $TEMPDIR
    echo

    wget $URL > /dev/null
    unzip $ART_NAME.zip > /dev/null
    sudo cp -r $ART_NAME/* /var/www/html/
    echo

    echo "Restarting httpd service"
    sudo systemctl restart $SVC
    echo 

    echo "Removing temp files"
    sudo rm -rf $TEMPDIR

    sudo systemctl status $SVC
    ls -l /var/www/html

fi	
