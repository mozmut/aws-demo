terraform init
terraform plan -var-file=credentials.tfvars
terraform apply -var-file=credentials.tfvars