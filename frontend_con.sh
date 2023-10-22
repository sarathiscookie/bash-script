#!/bin/bash

# Log file path
log_file="/var/log/frontend_configuration.log"

# Redirect all output to the log file
exec &> "$log_file" 

# Read .env file and fill variables.
company_dir=$(cat .env | grep COMPANY_DIR | awk -F'=' '{print $2}')
project_dir=$(cat .env | grep PROJECT_DIR | awk -F'=' '{print $2}')
user=$(cat .env | grep USER | awk -F'=' '{print $2}')
group=$(cat .env | grep GROUP | awk -F'=' '{print $2}')

# Create user
create_user() {
    sudo useradd $user

    if [ $? == 0 ]
        then 
            echo "### User $user created successfully. ###"
    fi                         
}

# Create group
create_group() {
    sudo groupadd $group

    if [ $? == 0 ]
        then 
            echo "### Group $group created successfully. ###"
    fi
}

# Add user to group
add_user_to_group() {
    sudo usermod -aG $group $user
    if [ $? == 0 ]
        then 
            echo "### User $user added to Group $group. ###"
    fi
}

echo $(create_user)
echo $(create_group)
echo $(add_user_to_group)

#: '
cat /etc/hostname
if [ $? == 0 ]
    then
        # Checking project directory.
        ls -ld /usr/local/$company_dir/$project_dir

        if [ $? == 0 ]
            then 
                echo "### Project directory already existing ###"
                exit
        else
            sudo mkdir -p /usr/local/$company_dir/$project_dir
            if [ $? == 0 ]
                then
                    project_dir_path=$(ls -ld /usr/local/$company_dir/$project_dir)
                    echo "### Directory created. Path: $project_dir_path. ###"
                    echo

                    # Add user and group to directory
                    sudo chown -R $user:$group /usr/local/$company_dir

                    if [ $? == 0 ] 
                        then
                            echo "### Added USER $user and GROUP $group ###"

                            # clone project from repo.
                    else
                        echo "### Failed: USER $user and GROUP $group not added. ###"        
                    fi 
            fi
        fi            
else
    echo "Hostname not found!"        
fi
#'


#[root@vm01 local]# groupdel devgroup; userdel devadmin; rm -rf /home/devadmin; rm -rf company