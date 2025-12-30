#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Terraform State Check ===${NC}\n"

# Navigate to the terraform directory
cd "$(dirname "$0")/.."

echo -e "${GREEN}1. Listing all managed resources:${NC}"
terraform state list
echo ""

echo -e "${GREEN}2. Checking for configuration drift:${NC}"
terraform plan -detailed-exitcode || {
  exit_code=$?
  if [ $exit_code -eq 2 ]; then
    echo -e "${YELLOW}⚠️  Drift detected! Infrastructure differs from configuration.${NC}"
  elif [ $exit_code -eq 1 ]; then
    echo -e "${YELLOW}⚠️  Error running terraform plan${NC}"
  fi
}
echo ""

echo -e "${GREEN}3. Current state summary:${NC}"
terraform show -no-color | head -50
echo ""

echo -e "${BLUE}=== State Check Complete ===${NC}"
echo ""
echo "To reconcile differences, run:"
echo "  - 'terraform apply' to update infrastructure to match configuration"
echo "  - 'terraform apply -refresh-only' to update state to match infrastructure"
