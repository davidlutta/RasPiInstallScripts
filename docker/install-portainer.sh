#!/bin/bash

# Stop on error
set -e

echo "📁 Creating Docker volumes and folders..."
# Create persistent volume for Portainer
docker volume create portainer_data

# Optional: Create MagicMirror config folder
mkdir -p ~/magic_mirror/config

echo "🚀 Running Portainer CE..."
docker run -d \
  -p 9000:9000 \
  -p 8000:8000 \
  --name=portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce

echo "✅ Portainer running on http://localhost:9000"