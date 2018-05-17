# Azure CI/CD with Terraform
This project aims to deploy a complete CI/CD Pipeline without user interaction. That pipeline will be using Jenkins and Azure Container Services / Registry.
![Azure infrastructure example](docs/az_infra.png?raw=true)

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites
Things you will need to install:
* **Terraform;**
* **Azure CLI;**
* **Kubectl (optional);**

### Installing
To start using Terraform, you'll have to prepare your environment. To setup Azure credentials and Terraform, go to:
https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure

To set up, some operations must be done first:
#### Generate the **credentials** file:
Create a file on the project root dir and add the following values that you got from Azure Cli:
```
subscription_id = "Subscription ID"
client_id = "Application ID"
client_secret = "Password"
tenant_id = "Tenant ID"
```

#### Generate the keys for SSH access:
Use **ssh_keygen**. The default path where the scripts will look for the keys is **keys/***.

By default, the modules depend on **linux_key** and **container_key**. You can change the names with variables.
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

#### Installing Kubectl in your machine
**Important:** This step can only be done after your Kubernetes cluster is built!

First you will have to login on Azure, via AzureCLI. You can use the credentials you generated:
```
az login --service-principal -u <client_id> -p <client_secret> --tenant <tenant_id>
```
Then you'll have to download the Kubectl. You can either download form the official site or using the AzureCLI:
```
az acs kubernetes install-cli --install-location=<DIR_TO_INSTALL>\kubectl.exe
```
**Note:** You have to create the directory first. If you want to use kubectl from the shell directly, you'll have to add it to the $PATH.

Finally, you'll have to grab your *kube.conf* from your Kubernetes cluster:
```
az acs kubernetes get-credentials --resource-group=<Name of the Kubernetes resource group> --name=<Name of the Kubernetes cluster> --ssh-key-file=<Path to the SSH private key>
```
For the default values it should be:
```
az acs kubernetes get-credentials --resource-group=container_mgmt_rsgrp --name=azure_kubernetes --ssh-key-file=keys\container_key
```
This will be saved in $HOME/.kube/config:
```
ls -la ~/.kube
total 28
drwxr-xr-x 1 user 197121    0 May 16 14:36 ./
drwxr-xr-x 1 user 197121    0 May 16 14:33 ../
drwxr-xr-x 1 user 197121    0 May 16 14:36 cache/
-rw-r--r-- 1 user 197121 6355 May 16 14:35 config
drwxr-xr-x 1 user 197121    0 May 16 14:36 http-cache/
```
To test the config, you can run kubectl commands:

(If you added kubectl to your $PATH, just call the exe directly)
```
C:\kubernetes\kubectl.exe get nodes
NAME                    STATUS    ROLES     AGE       VERSION
k8s-agent-f59f746e-0    Ready     agent     1d        v1.7.7
k8s-agent-f59f746e-1    Ready     agent     1d        v1.7.7
k8s-agent-f59f746e-2    Ready     agent     1d        v1.7.7
k8s-master-f59f746e-0   Ready     master    1d        v1.7.7
k8s-master-f59f746e-1   Ready     master    1d        v1.7.7
k8s-master-f59f746e-2   Ready     master    1d        v1.7.7
```
To connect to the Cluster Management UI, you'll have to proxy that access. To do that, run:
```
C:\kubernetes\kubectl.exe proxy
Starting to serve on 127.0.0.1:8001
```
Then open your browser on http://localhost:8001/api/v1/proxy/namespaces/kube-system/services/kubernetes-dashboard.

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
This process should take around **15-20** minutes to run. In the end it will display all the values needed to access the infrastructure:
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
### Changing default values
To customize your installation, you can tweak certain values. This is import regarding the DNS, since they usually have to be unique to the region.

To tweak these values, edit the variables.tf in the project root directory and change the default values of the variables you wish to change. For deeper customization, check the variables.tf inside each module.

 **Important:** Careful when changing module specific variables, since it may lead to the modules breaking.

### Changing the Container Platform
You can also use the Swarm module to build a Swarm cluster instead of a Kubernetes cluster. Your Jenkins pipeline definition will have to change to take that into consideration.

To change it, edit the main.tf in the project root directory, comment out the Kubernetes module definition and outputs and uncomment the Swarm module configuration and its outputs.
