#!/bin/bash
set -e

echo "Starting Google Cloud SDK installation..."

# 1. Update and install prerequisites
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates gnupg curl

# 2. Import the Google Cloud public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

# 3. Add the gcloud CLI distribution URI as a package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list

# 4. Update and install the gcloud CLI
sudo apt-get update
sudo apt-get install -y google-cloud-cli

echo "Google Cloud SDK installed successfully!"
echo "Run 'gcloud init' or 'gcloud auth login' to get started."
