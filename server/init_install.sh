#!/bin/bash

#################################################
#
# Author - Emmanuel Gyang
# Last Modified - 24/12/2024
# Usage - This scrip would install docker, mysql and nginx
#           on a new server
# Version - v1
#
##################################################


set -x 

# Run Update
sudo apt update -y

#Install Nginx
sudo apt install nginx -y

sudo ufw allow 'Nginx Http'

#Install Docker
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

sudo apt install ca-certificates curl -y

sudo install -m 0755 -d /etc/apt/keyrings

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y

sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Installing MySql
# sudo apt install mysql-server

sudo systemctl start mysql.service

sudo systemctl enable mysql.service

MYSQL_ROOT_PASSWORD='password'

sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY '${MYSQL_ROOT_PASSWORD}';"
sudo mysql -e "FLUSH PRIVILEGES;"

exit