# Azure CI/CD with Terraform
This project aims to deploy a complete CI/CD Pipeline without user interaction. That pipeline will be using Jenkins and Azure Container Services / Registry.
![Azure infrastructure example](docs/az_infra.png?raw=true)

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites
Things you will need to install:
* **Terraform** - Terraform v0.11.7 with provider.azurerm v1.4.0
* **Azure CLI** - Azure-cli v2.0.32 with Python (Windows) 3.6.1
* **Kubectl (optional)** - Kubectl v1.10.2 on Windows

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

If you get an error "no endpoints available for service \"kubernetes-dashboard\"", wait a bit.

Kubernetes takes a while to run all the pods necessary to the cluster. You can login to the Kubernetes master and run:
```
kubectl get pods --all-namespaces=true
NAME                                            READY     STATUS    RESTARTS   AGE
heapster-2888171832-vb3bp                       0/2       Pending   0          14m
kube-addon-manager-k8s-master-5c375e5e-0        1/1       Running   0          13m
kube-apiserver-k8s-master-5c375e5e-0            1/1       Running   0          13m
kube-controller-manager-k8s-master-5c375e5e-0   1/1       Running   0          14m
kube-dns-v20-3003781527-54qsx                   0/3       Pending   0          14m
kube-dns-v20-3003781527-mt0n9                   0/3       Pending   0          14m
kube-proxy-nwq8p                                1/1       Running   0          14m
kube-scheduler-k8s-master-5c375e5e-0            1/1       Running   0          13m
kubernetes-dashboard-924040265-n8xhl            0/1       Pending   0          14m
tiller-deploy-677436516-n6q3d                   0/1       Pending   0          14m
```
When all is running, the Web UI should start working.

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
Container Registry Admin Password = <Container Registry password>
Container Registry Admin User = <Container Registry admin user>
Container Registry Login Server = <Container Registry login server>
Jenkins Public IP = <Jenkins public IP>
Jenkins Public IP FQDN = <Jenkins public IP FQDN>
Jenkins SSH Username = <Jenkins ssh user>
Jenkins usage = <How to access the Jenkins server through SSH>
Jenkins web access = <How to access Jenkins server through Web UI>
Kubernetes Master FQDN = <Kubernetes master public IP FQDN>
Kubernetes SSH Username = <Kubernetes master ssh user>
Kubernetes usage = <How to access the Kubernetes master through SSH>
```
## Alternative builds
### Changing default values
To customize your installation, you can tweak certain values. This is import regarding the DNS, since they usually have to be unique to the region.

To tweak these values, edit the variables.tf in the project root directory and change the default values of the variables you wish to change. For deeper customization, check the variables.tf inside each module.

 **Important:** Careful when changing module specific variables, since it may lead to the modules breaking.

### Changing the Container Platform
You can also use the Swarm module to build a Swarm cluster instead of a Kubernetes cluster. Your Jenkins pipeline definition will have to change to take that into consideration.

To change it, edit the main.tf in the project root directory, comment out the Kubernetes module definition and outputs and uncomment the Swarm module configuration and its outputs.

## Destroying the environment
If you wish to destroy the environment, just run:
```
terraform destroy -var-file=<credentials>
```
Assuming you didn't make changes without scripting them in Terraform, everything should be deleted without issues.

This process should take around **10-15** minutes.

## Accessing Jenkins
### Complete the setup operations.
To access your Jenkins server Web UI, open the browser on http://< Jenkins FQDN\>:8080.

The first step you have to do is to create an Admin Account and add the base plugins. You will be prompted to insert a secret located on the Jenkins instance. Access it through SSH and find the secret located on the file described on the UI. Install the suggested plugins. The specific ones will be coming later.

Create the Admin account for the Web UI and login on the portal.

### Install the required plugins
Access the **Manage Jenkins** menu and go to **Manage Plugins**. Select the **Available** tab. Install the following plugins:
* **Azure Container Service** - tested on v0.2.3
* **Azure Credentials** - tested on v1.6.0
* **Azure Commons** - tested on v0.2.6
* **Docker API** - tested on v3.0.14
* **Docker** - tested on v1.1.4
* **Kubernetes Continuous Deploy** - tested on v0.2.1
* **GitHub Authentication** - tested on v0.29
* **GitHub Integration** - tested on v0.1.0-rc29

Press download and install and click the *Restart Jenkins when installation is complete and no jobs are running* checkbox. After your Jenkins service restarts, the plugins should all be installed.

### Add the credentials required for the pipelines
Access the **Credentials** menu, then **System** and finally **Global credentials**. It's best practice to use domains but for now it's not going to be used.

On the **Global credentials (unrestricted)**, click on **Add Credentials** on the left. You need to add the following credentials:
#### Azure Container Registry
The type should be **Username with password**, where your username and password are the information return in the Terraform outputs:
* *Container Registry Admin User*
* *Container Registry Admin Password*

Give that account a friendly ID since you will use it on your pipeline scripts.
#### Kubernetes Master SSH credentials
The type should be **SSH Username with private key**, where your username and key are the ones used in Terraform:
* *Kubernetes SSH Username*
* The private key that you used. By default it uses the container_key.

You can choose to add that key directly to avoid uploads. If you added a passphrase, add it here too. If not, leave it blank.

Give that account a friendly ID since you will use it on your pipeline scripts.

#### Azure Service Account
The type should be **Microsoft Azure Service Principal**. You can either generate a new service principal (same process you used to generate the credentials file) or use the credentials file. The values you will have to fill are:
* Subscription ID
* Client ID
* Client Secret
* Tenant ID

The environment should be Azure.

Give that account a friendly ID since you will use it on your pipeline scripts.

#### GitHub Secrect
You will need a secret to assure the communication with GitHub webhooks. You can generate a secret for your GitHub account. That way, all your projects will be integrated easily. The basics should be: *public_repo, repo:status, write:repo_hook*

The type should be **Secret Text**. You will have to fill:
* Secret

Give that account a friendly ID since you will use it on your pipeline scripts.

#### General Credentials Layout
This image should give you a general idea on what it should look like after you're done.
![Jenkins Credentials example](docs/jenkins_creds_layout.png?raw=true)

### Setting up GitHub
The next step is to configure the communication with the GitHub server. To do that go to **Manage Jenkins** > **Configure System**. Find the GitHub  configuration. Click on **Add GitHub Server** and then **GitHub Server**. Give it a name (for ID purposes) and set the credentials as your secret. The API server should be already set as https://api.github.com.

Test your connection. It should say something like *"Credentials verified for user xxxxxx, rate limit: 4998"*

Expand the hooks section and set your GitHub secret there too. Save the configurations when you're done.

**Jenkins should now be ready for you to create your pipelines!**

## Creating a Kubernetes Secret for ACR access
Since we are using a private Container Registry, Kubernetes will need a secret with the ACR credentials to be able to pull the images.

To create one you can either use kubectl on your local machine or login to the Kubernetes master and work there.

To create a secret do:
```
kubectl create secret docker-registry <secret name> --docker-server=http://<Container Registry Login Server> --docker-username=<Container Registry Admin User> --docker-password=<Container Registry Admin User> --docker-email=<Email>
```
You can add *--dry-run* to test the command before you commit.

It should return *secret "< secret name >" created*

**Important:** Make sure you remember the secret name. It will be used in your Jenkins pipeline and Kubernetes deployment.yaml file.
