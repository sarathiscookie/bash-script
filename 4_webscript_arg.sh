#!/bin/bash

# Exit on error 
set -e

# Log file path
log_file="/var/log/web_setup.log"

# Redirect all output to the log file
exec &> "$log_file" 

PACKAGE="wget unzip httpd"
TEMPDIR="/tmp/webfiles"

echo "### Scripts begins. ###"
sudo yum install $PACKAGE -y > /dev/null
echo

echo "#### Starting and Enabling httpd service ####"
sudo systemctl start httpd
sudo systemctl enable httpd
echo

echo "### Creating temp webfiles directory ###"
mkdir -p $TEMPDIR
cd $TEMPDIR
echo

wget $1 > /dev/null
unzip $2.zip > /dev/null
sudo cp -r $2/* /var/www/html/
echo

echo "Restarting httpd service"
sudo systemctl restart httpd
echo 

echo "Removing temp files"
sudo rm -rf $TEMPDIR

sudo systemctl status httpd
ls -l /var/www/html

echo "### Script completed. Check the log file for the details: $log_file"

