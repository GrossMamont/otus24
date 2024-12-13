#!/bin/bash

# Add Docker's official GPG key:
echo "Add Docker's official GPG key"
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo "Add the repository to Apt sources"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update


echo "Install the Docker packages"
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Verify that the installation is successful by running the hello-world image"
docker run hello-world

echo "Create the docker group"
sudo groupadd docker
echo "Add your user to the docker group"
sudo usermod -aG docker vagrant
sudo usermod -aG docker otusadm
echo "Log out and log back in so that your group membership is re-evaluated"
newgrp docker
echo "Verify that you can run docker commands without sudo"
docker run hello-world
