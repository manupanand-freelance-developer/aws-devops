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

# Redirect stdout and stderr to log file


echo "Starting script execution at $(date)"
sudo dnf install -y git sshpass rsyslog ansible-core | tee -a $LOG_FILE



sudo systemctl enable rsyslog
sudo systemctl start rsyslog 

sudo sed -i 's/^#PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config 
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config 
sudo sed -i 's/^#ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config 
sudo sed -i 's/^ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config 
sudo sed -i 's/^#ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config 
sudo sed -i 's/^#UsePAM no/UsePAM yes/' /etc/ssh/sshd_config 
sudo sed -i 's/^UsePAM no/UsePAM yes/' /etc/ssh/sshd_config 
sudo sed -i 's/^#PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/50-cloud-init.conf 
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/50-cloud-init.conf 
sudo sed -i 's/^ssh_pwauth: false/ssh_pwauth: true/' /etc/cloud/cloud.cfg 
sleep 10
sudo cloud-init clean | tee -a $LOG_FILE
sudo cloud-init init | tee -a$LOG_FILE
sleep 10
sudo systemctl restart sshd | tee -a $LOG_FILE
sudo systemctl daemon-reload | tee -a $LOG_FILE
sleep 5
# Set the password for "ec2-user" (USE WITH CAUTION)
echo "${AWS_USER}:${AWS_PASSWORD}" | sudo chpasswd  | tee -a $LOG_FILE
sleep 5



ansible-pull -i localhost, -U https://github.com/manupanand-freelance-developer/aws-devops.git  sonarqube/ansible/playbook.yml  -e ansible_user=${AWS_USER} -e ansible_password=${AWS_PASSWORD} -e role_name=${role_name} | tee -a $LOG_FILE

