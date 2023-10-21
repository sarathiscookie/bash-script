#!/bin/bash

# Log file path
log_file="/var/log/frontend_configuration.log"

# Redirect all output to the log file
exec &> "$log_file" 

# Read .env file and fill variables.
company_dir=$(cat .env | grep COMPANY_DIR | awk -F'=' '{print $2}')

project_dir=$(cat .env | grep PROJECT_DIR | awk -F'=' '{print $2}')

hostname=$(cat /etc/hostname)

echo $company_dir
#: '
if [ $? == 0 ]
    then
        # Checking project directory.
        ls -ld /usr/local/$company_dir/$project_dir

        if [ $? == 0 ]
            then 
                echo "### Found project directory. Exiting... ###"
                exit
        else
            echo "### Creating project directory. ###"
            echo
            sudo mkdir -p /usr/local/$company_dir/$project_dir
            if [ $? == 0 ]
                then
                    project_dir_path=$(ls -ld /usr/local/$company_dir/$project_dir)
                    echo "### Directory created. Path: $project_dir_path. ###"
                    # Set user and group for project directory.
                    # If dir then pass the branch name, clone project from repo, .
                    # Check status of the clone using if condition. 
                    # If successfull then
            fi
        fi            
else
    echo "Hostname not found!"        
fi
#'