#!/bin/bash

echo "Set the directory and group"

read -p 'Group name: ' G_NAME
read -p 'Directory name:' D_NAME
echo

read -p 'Username: ' USR
read -sp 'Password: ' PASS
echo

echo "Login successfully!"
echo "Hello $USR, Directory name is $D_NAME and Group name is $G_NAME." 
