# Azure CI/CD with Terraform  
This project aims to deploy a complete CI/CD Pipeline without user interaction. That pipeline will be using Jenkins and Azure Container Services / Registry.  
![Azure infrastructure example](docs/az_infra.png?raw=true)  
## Getting Started  
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.  
### Prerequisites  
Things you will need to install:  
1) Terraform;  
2) Azure CLI;  
3) Kubectl (optional);  
### Installing  
To start using Terraform, you'll have to prepare your environment. To setup Azure credentials and Terraform, go to:  
https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure  

To set up, some operations must be done first:  
1) Generate the credentials file:  
Create a file on the project root dir and add the following values that you got from Azure Cli:  
```
subscription_id = "Subscription ID"  
client_id = "Application ID"  
client_secret = "Password"  
tenant_id = "Tenant ID"  
```
2) Generate the keys for Jenkins Linux machines and Azure Container Service Master (in this case, Kubernetes masters):  
Use ssh_keygen. The default path where the scripts will look for the keys is keys/*  
By default, the modules depend on "linux_key" and "container_key". You can change the names with variables.  
The keys folder should look like this:
```
ls -la keys/
total 18
drwxr-xr-x 1 user 197121    0 May  8 15:52 ./
drwxr-xr-x 1 user 197121    0 May 16 15:54 ../
-rw-r--r-- 1 user 197121 1679 May  8 15:52 container_key
-rw-r--r-- 1 user 197121  402 May  8 15:52 container_key.pub
-rw-r--r-- 1 user 197121 1675 May  8 11:27 linux_key
-rw-r--r-- 1 user 197121  402 May  8 11:27 linux_key.pub
```
## Building the cloud environment
To initialize the modules run:
```
terraform init
```
To test your configuration before applying run:
```
terraform plan -var-file=<credentials>
```
To apply the configuration to your Azure cloud run:
```
terraform apply -var-file=<credentials>
```
### Outputs
This process should take around 15-20 minutes to run. In the end it will display all the values needed to access the infrastructure:  
```
Container Registry Admin Password = <container registry password>  
Container Registry Admin User = <container registry admin user>  
Container Registry Login Server = <container registry login server>  
Jenkins Admin account name = <jenkins ssh user>  
Jenkins Admin account password = Use private key  
Jenkins Public IP = <jenkins public IP>  
Jenkins Public IP FQDN = <jenkins public IP FQDN>  
Kubernetes Master FQDN = <Kubernetes master public IP FQDN>  
Kubernetes admin username = <Kubernetes master ssh user>  
```
## Alternative builds
You can also use the Swarm module to build a Swarm cluster instead of a Kubernetes cluster. Your Jenkins pipeline definition will have to change to take that into consideration.
