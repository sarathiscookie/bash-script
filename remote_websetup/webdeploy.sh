#!/bin/bash

USER='devops'
WEB_SETUP_FILE='multios_websetup.sh'

for host in `cat remhosts`
do
  echo "###### $host: Process begins ######"
  echo
  echo "$host: Copying websetup file."
  scp $WEB_SETUP_FILE $USER@$host:/tmp/

  echo "$host: Websetup process started."
  ssh $USER@$host sudo /tmp/$WEB_SETUP_FILE

  echo "$host: Websetup process completed."
  echo
  echo "$host: Removed websetup files from tmp folder."
  ssh $USER@$host sudo rm -f /tmp/$WEB_SETUP_FILE 
  echo "###### $host: Process ends #######"
  echo
done   

