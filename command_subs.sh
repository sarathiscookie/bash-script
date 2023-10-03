#!/bin/bash

echo "Welcome $USER on $HOSTNAME"
echo

FREE_RAM=$(free -m | grep Mem | awk '{print $4}')
echo "Available free RAM is $FREE_RAM"

echo
LOAD_AVG=$(uptime | awk '{print $9}')
echo "Current load average is $LOAD_AVG"

echo
PARTITION=$(df -h | grep /dev/sda1 | awk '{print $4}')
echo "Current root partition size is $PARTITION"
