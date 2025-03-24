# Terraform init
 echo "Initializing terraform"
 terraform init
 #terraform plan
 terraform plan -var-file="env-dev/main.tfvars"
 # terrform apply 
 terraform apply -var-file="env-dev/main.tfvars" -auto-approve
