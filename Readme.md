## Create EC2 Instance

First need to change diretory to mozmut-aws-instances
```sh
cd mozmut-aws-instances
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
```
```sh
terraform plan -var-file=credentials.tfvars
```

If everything is OK with the commands above you can create your instace with terrform apply
```sh
terraform apply -var-file=credentials.tfvars
```

## Destroy EC2 Instance

Try not to forget to destroy the instance when you finished your work

```sh
terraform destroy -var-file=credentials.tfvars
```
