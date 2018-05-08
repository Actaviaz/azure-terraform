To setup Azure and Terraform, go to:  
https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure
  
To set up, two operations must be done first:  
1) Generate the credentials file:  
Create a file on the root folder and add the following values that you got from Azure Cli:  
subscription_id = "Subscription ID"  
client_id = "Application ID"  
client_secret = "Password"  
tenant_id = "Tenant ID"  
  
2) Generate the keys for linux machines:  
Use ssh_keygen. The default path is keys/linux_key.pub  

To run just:
1) terraform init
2) terraform plan -var-file=credentials
3) terraform apply -var-file=credentials
