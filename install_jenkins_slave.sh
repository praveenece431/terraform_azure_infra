#!/bin/bash
sudo apt update -y
sudo apt install openjdk-11-jdk -y
sudo useradd -m -s /bin/bash jenkins-slave
echo "jenkins-slave:password" | sudo chpasswd
sudo mkdir /home/jenkins-slave/.ssh
echo "ssh-rsa AAAA..." > /home/jenkins-slave/.ssh/authorized_keys
sudo chown -R jenkins-slave:jenkins-slave /home/jenkins-slave/.ssh
sudo chmod 600 /home/jenkins-slave/.ssh/authorized_keys