#!/bin/bash
# Define log file
export AWS_USER=$TF_VAR_aws_user
export AWS_PASSWORD=$TF_VAR_aws_password
export role_name=$TF_VAR_role_name
LOG_FILE="/var/log/startup_script.log"
sudo touch $LOG_FILE
sudo chmod 666 $LOG_FILE

# Redirect stdout and stderr to log file
echo "Starting script execution at $(date)" | tee -a $LOG_FILE

# Update package lists
sudo apt-get update | tee -a $LOG_FILE

# Install sshpass
sudo apt-get install -y sshpass | tee -a $LOG_FILE

# Install rsyslog (usually pre-installed on Ubuntu)
sudo apt-get install -y rsyslog | tee -a $LOG_FILE
sudo systemctl enable rsyslog
sudo systemctl start rsyslog 

# Configure SSH for password authentication
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config 
sudo sed -i 's/^#PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config 
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config 
sudo sed -i 's/^#KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/' /etc/ssh/sshd_config 
sudo sed -i 's/^KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/' /etc/ssh/sshd_config 
sudo sed -i 's/^#UsePAM no/UsePAM yes/' /etc/ssh/sshd_config 
sudo sed -i 's/^UsePAM no/UsePAM yes/' /etc/ssh/sshd_config 

# Configure cloud-init SSH settings (if file exists)
if [ -f /etc/ssh/sshd_config.d/50-cloud-init.conf ]; then
    sudo sed -i 's/^#PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/50-cloud-init.conf 
    sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/50-cloud-init.conf 
fi

# Update cloud-init config
sudo sed -i 's/^ssh_pwauth: false/ssh_pwauth: true/' /etc/cloud/cloud.cfg 
sleep 30

# Clean and reinitialize cloud-init
sudo cloud-init clean | tee -a $LOG_FILE
sudo cloud-init init | tee -a $LOG_FILE
sleep 60

# Restart SSH service
sudo systemctl restart sshd | tee -a $LOG_FILE
sudo systemctl daemon-reload | tee -a $LOG_FILE

# Set the password for ubuntu user (default user on Ubuntu AMIs)
echo "ubuntu:${AWS_PASSWORD}" | sudo chpasswd | tee -a $LOG_FILE

# If you need to set password for a custom user, uncomment the line below
# echo "${AWS_USER}:${AWS_PASSWORD}" | sudo chpasswd | tee -a $LOG_FILE

sleep 60

# Update package lists again before installing ansible
sudo apt-get update | tee -a $LOG_FILE

# Install ansible-core
sudo apt-get install -y ansible-core | tee -a $LOG_FILE

# Uncomment and modify as needed for your ansible-pull command
# ansible-pull -i localhost, -U https://github.com/manupanand-freelance-developer/aws-devops.git ec2-instance/ansible/playbook.yml -e ansible_user=ubuntu -e ansible_password=${AWS_PASSWORD} -e role_name=${role_name} | tee -a $LOG_FILE

echo "Script execution completed at $(date)" | tee -a $LOG_FILE