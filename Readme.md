# Azure CI/CD with Terraform  
This project aims to deploy a complete CI/CD Pipeline without user interaction. That pipeline will be using Jenkins and Azure Container Services / Registry.  
![Azure infrastructure example](https://raw.githubusercontent.com/j-furtado/azure-terraform/master/docs/az_infra.png)  
## Getting Started  
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.  
### Prerequisites  
Things you will need to install:  
1) Terraform;  
2) Azure CLI;  
3) Kubectl (optional);  
### Installing  
To start using Terraform, you'll have to prepare your environment.  
To setup Azure credentials and Terraform, go to:  
https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure  
To set up, some operations must be done first:  
1) Generate the credentials file:  
Create a file on the root folder and add the following values that you got from Azure Cli:  
subscription_id = "Subscription ID"  
client_id = "Application ID"  
client_secret = "Password"  
tenant_id = "Tenant ID"  
2) Generate the keys for Jenkins Linux machines and Azure Container Service Master (in this case, Kubernetes masters):  
Use ssh_keygen.  
The default path is keys/*  
By default, the modules depend on "linux_key" and "container_key". You can change the names with variables.  
## Building the environment
To start building your infrastructure just run:
1) terraform init (to initialize the modules)
2) terraform plan -var-file=credentials (to test the configuration)
3) terraform apply -var-file=credentials (to apply the configuration)  
### Outputs
This process should take around 15-20 minutes to run. In the end it will display all the values needed to access the infrastructure:  
Outputs:  
Container Registry Admin Password = <container registry password>  
Container Registry Admin User = <container registry admin user>  
Container Registry Login Server = <container registry login server>  
Jenkins Admin account name = <jenkins ssh user>  
Jenkins Admin account password = Use private key  
Jenkins Public IP = <jenkins public IP>  
Jenkins Public IP FQDN = <jenkins public IP FQDN>  
Kubernetes Master FQDN = <Kubernetes master public IP FQDN>  
Kubernetes admin username = <Kubernetes master ssh user>  
