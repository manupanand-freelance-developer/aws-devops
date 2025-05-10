#!/bin/bash

touch /tmp/newfile.sh
# Define log file
LOG_FILE="/var/log/startup_script.log"
sudo touch $LOG_FILE
sudo chmod 666 $LOG_FILE
export AWS_USER=${AWS_USER}
export AWS_PASSWORD=${AWS_PASSWORD}
export role_name=${role_name}
export ANSIBLE_HOST_KEY_CHECKING=False
echo $AWS_USER | tee -a $LOG_FILE
echo $AWS_PASSWORD | tee -a $LOG_FILE
echo $role_name | tee -a $LOG_FILE