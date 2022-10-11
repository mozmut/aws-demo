## Create EC2 Ubuntu Instance For Jenkins

First need to change diretory to mozmut-aws-instances
```sh
cd jenkins-aws-instance
```

Then need to create your credentials.tfvars for your sensitive variables
```sh
vpc = "VPC_ID"
subnet = "SUBNET_ID"
keyname = "KEYNAME_NAME"
```

Then need to apply commands below

```sh
terraform init
terraform plan -var-file=credentials.tfvars
```

If everything is OK with the commands above you can create your instace with terrform apply
```sh
terraform apply -var-file=credentials.tfvars
```

## Install Jenkins with Ansible

```sh
cd jenkins-ansible
```

Edit inventory file with IP and pem file then execute the ansible with this command below

```sh
ansible-playbook -i inventory install-jenkins.yaml
```

## Destroy EC2 Instance

Try not to forget to destroy the instance when you finished your work

```sh
terraform destroy -var-file=credentials.tfvars
```


