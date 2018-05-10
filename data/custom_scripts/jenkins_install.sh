#!/usr/bin/env bash
# Gets the Jenkins repo key
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
# Adds the Jenkins repo source
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
# Updates the package list
sudo apt update
# Installs Java 8 (dependency)
sudo apt install openjdk-8-jdk
# Installs Jenkins
sudo apt install jenkins
