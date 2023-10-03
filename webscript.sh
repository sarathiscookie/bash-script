#!/bin/bash

# Exit on error 
set -e

# Log file path
log_file="/var/log/web_setup.log"

# Redirect all output to the log file
exec &> "$log_file" 

echo "### Scripts begins. ###"
sudo yum install wget unzip httpd -y > /dev/null
echo

echo "#### Starting and Enabling httpd service ####"
sudo systemctl start httpd
sudo systemctl enable httpd
echo

echo "### Creating temp webfiles directory ###"
mkdir -p /tmp/webfiles
cd /tmp/webfiles
echo

wget https://www.tooplate.com/zip-templates/2098_health.zip > /dev/null
unzip 2098_health.zip > /dev/null
sudo cp -r 2098_health/* /var/www/html/
echo

echo "Restarting httpd service"
sudo systemctl restart httpd
echo 

echo "Removing temp files"
sudo rm -rf /tmp/webfiles

sudo systemctl status httpd
ls -l /var/www/html

echo "### Script completed. Check the log file for the details: $log_file"

