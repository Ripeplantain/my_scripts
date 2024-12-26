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

sudo apt install mysql-server -y

sudo systemctl start mysql.service

sudo systemctl enable mysql.service

MYSQL_ROOT_USER=root
MYSQL_ROOT_PASSWORD='password'

NEW_USER=ubuntu
NEW_PASSWORD=password

DATABASED=test_db

sudo mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" <<EOF
CREATE DATABASE IF NOT EXISTS $DATABASE;
CREATE USER '$NEW_USER'@'localhost' IDENTIFIED BY '$NEW_PASSWORD';
GRANT ALL PRIVILEGES ON ${DATABASE}.* TO '$NEW_USER'@'localhost';
FLUSH PRIVILEGES;
EOF

if [ $? -eq 0 ]; then
    echo "User $NEW_USER created and granted privileges on $DATABASE successfully."
else
    echo "Failed to create user or grant privileges."
fi