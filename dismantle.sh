#!/bin/bash
sudo systemctl stop httpd
sudo rm -rf /var/www/html/$1
sudo yum remove httpd wget unzip -y
