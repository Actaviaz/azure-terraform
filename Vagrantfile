# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "Terraform-local"
  config.vm.box = "ubuntu/xenial64"
  config.vm.synced_folder "terra_infra", "/home/ubuntu/terra_infra/",
       owner: "ubuntu",
       group: "ubuntu",
       mount_options:["dmode=775,fmode=600"]
  config.vm.provision "file", source: "terraform_0.11.7_linux_amd64.zip", destination: "terraform.zip"
  config.vm.boot_timeout = 600
  config.vm.provider "virtualbox" do |vb|
      vb.name = "Terraform"
      vb.memory = "4096"
      vb.cpus = "4"
  end
  config.vm.provision "shell", inline: <<-SHELL
     apt update
     apt install unzip -y
     mkdir /opt/terraform
     unzip terraform.zip -d /opt/terraform/
     ln -s /opt/terraform /usr/local/bin/
     rm terraform.zip
  SHELL
end
