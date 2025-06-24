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

echo "📦 Installing Docker Compose via pip..."
sudo pip3 install docker-compose

echo "🔍 Verifying installations..."
docker --version
docker-compose --version

echo "✅ Docker and Docker Compose installed successfully."
echo "🚨 You must reboot or log out and log in again for group changes to take effect."
