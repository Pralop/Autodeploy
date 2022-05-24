#!/bin/sh
sudo yum update -y
echo "Latest security patch of Amazon Linux"
sudo amazon-linux-extras install docker -y
sudo service docker start
echo "Install Docker and Start service completed"
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo chmod 666 /var/run/docker.sock
sudo chown ec2-user /var/run/docker.sock
echo "Install Docker-Compose completed"
echo "Please run docker info and docker-compose --version for check version and service after install"
