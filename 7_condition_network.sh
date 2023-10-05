#!/bin/bash

echo "Script to check the active network interface"
echo

ACTIVE_COUNT=$(ip addr show | grep -v LOOPBACK | grep -c mtu)

if [ $ACTIVE_COUNT -eq 1 ]
then
    echo "1 Active network interface found."
elif [ $ACTIVE_COUNT -gt 1 ]
then
    echo "Found multiple active interface."
else
    echo "Not found any active interface."
fi		
