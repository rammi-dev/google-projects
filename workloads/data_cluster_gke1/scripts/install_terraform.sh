#!/bin/bash
set -e

# 1. Install dependencies
echo "Installing dependencies..."
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common wget

# 2. Install the HashiCorp GPG key
echo "Installing GPG key..."
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg --yes

# 3. Verify key (Optional, skipping for automation speed)

# 4. Add the official HashiCorp Linux repository
echo "Adding HashiCorp repository..."
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# 5. Update and install
echo "Installing Terraform..."
sudo apt-get update && sudo apt-get install terraform -y

echo "Terraform installation complete!"
terraform -version
