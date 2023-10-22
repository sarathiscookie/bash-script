#!/bin/bash

# Log file path
log_file="/var/log/frontend_configuration.log"

# Redirect all output to the log file
exec &> "$log_file" 

# Read .env file and fill variables.
company_dir=$(cat .env | grep COMPANY_DIR | awk -F'=' '{print $2}')
project_dir=$(cat .env | grep PROJECT_DIR | awk -F'=' '{print $2}')
user_name=$(cat .env | grep USER | awk -F'=' '{print $2}')
group_name=$(cat .env | grep GROUP | awk -F'=' '{print $2}')

# Create user
create_user_name() {
    useradd $user_name

    if [ $? -eq 0 ]
        then 
            echo "### User $user_name created successfully. ###"
    fi                         
}

# Create group
create_group_name() {
    groupadd $group_name

    if [ $? -eq 0 ]
        then 
            echo "Group $group_name created successfully."
    fi
}

# Add user to group
add_user_to_group() {
    usermod -aG $group_name $user_name
}

echo $(create_user_name)
echo $(create_group_name)
echo $(add_user_to_group)

#: '
hostname=$(cat /etc/hostname)
if [ $hostname -eq 0 ]
    then
        # Checking project directory.
        ls -ld /usr/local/$company_dir/$project_dir

        if [ $? -eq 0 ]
            then 
                echo "### Found project directory. Exiting... ###"
                exit
        else
            echo "### Creating project directory. ###"
            echo
            sudo mkdir -p /usr/local/$company_dir/$project_dir
            if [ $? -eq 0 ]
                then
                    project_dir_path=$(ls -ld /usr/local/$company_dir/$project_dir)
                    echo "### Directory created. Path: $project_dir_path. ###"
                    echo

                    # Add user and group to directory
                    chown -R $user_name:$group_name /usr/local/$company_dir
                    echo "### Added USER $user and GROUP $group ###"

                    # If dir then pass the branch name, clone project from repo, .
                    # Check status of the clone using if condition. 
                    # If successfull then
            fi
        fi            
else
    echo "Hostname not found!"        
fi
#'