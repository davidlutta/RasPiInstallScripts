#!/bin/bash

# Stop on error
set -e

echo "📦 Updating and upgrading system..."
sudo apt update && sudo apt full-upgrade -y

echo "🐳 Installing Docker using official script..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

echo "👤 Adding current user to Docker group..."
sudo usermod -aG docker $USER

echo "🔁 Enabling Docker service to start on boot..."
sudo systemctl enable docker
sudo systemctl start docker

echo "🔧 Installing dependencies for Docker Compose..."
sudo apt install -y libffi-dev libssl-dev python3 python3-pip python3-dev

echo "🔧 Installing Docker Compose plugin..."

DOCKER_COMPOSE_VERSION="v2.24.6"

mkdir -p ~/.docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-linux-aarch64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose

sudo systemctl restart docker
docker compose version


echo "✅ Docker and Docker Compose installed successfully."
echo "🚨 You must reboot or log out and log in again for group changes to take effect."
