#!/bin/bash

# 🚀 Node.js Installation Script for Raspberry Pi
# This script installs the latest version of Node.js

echo "🔍 Starting Node.js installation..."
echo "=================================="

# Step 1: Update the system
echo "📦 Updating system packages..."
sudo apt update
sudo apt upgrade -y

# Step 2: Remove old Node.js if it exists
echo "🧹 Removing old Node.js versions..."
sudo apt remove -y nodejs npm
sudo apt autoremove -y

# Step 3: Install curl (needed for downloading)
echo "⬇️  Installing curl..."
sudo apt install -y curl

# Step 4: Download and install Node.js using NodeSource repository
echo "🌐 Adding NodeSource repository..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

echo "📥 Installing Node.js..."
sudo apt install -y nodejs

# Step 5: Verify installation
echo "✅ Checking installation..."
echo "Node.js version:"
node --version
echo "NPM version:"
npm --version

# Step 6: Set npm permissions (optional but recommended)
echo "🔧 Setting up npm permissions..."
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'

# Add to PATH (add this line to your ~/.bashrc file)
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc

echo "🎉 Installation complete!"
echo "=================================="
echo "✨ Node.js is now installed!"
echo "📝 Note: Restart your terminal or run 'source ~/.bashrc' to update PATH"
echo ""
echo "🔍 Quick test - try running:"
echo "   node --version"
echo "   npm --version"