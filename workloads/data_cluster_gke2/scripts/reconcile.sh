#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Navigate to the terraform directory
cd "$(dirname "$0")/.."

echo -e "${BLUE}=== Terraform State Reconciliation ===${NC}\n"

# Check what mode to run
MODE=${1:-"plan"}

case $MODE in
  "plan")
    echo -e "${GREEN}Running plan to detect drift...${NC}"
    terraform plan -refresh-only
    echo ""
    echo -e "${YELLOW}To apply this refresh, run: $0 refresh${NC}"
    ;;
    
  "refresh")
    echo -e "${GREEN}Refreshing state to match actual infrastructure...${NC}"
    terraform apply -refresh-only -auto-approve
    echo -e "${GREEN}✓ State refreshed successfully${NC}"
    ;;
    
  "apply")
    echo -e "${GREEN}Applying configuration to update infrastructure...${NC}"
    terraform plan
    echo ""
    read -p "Do you want to apply these changes? (yes/no): " confirm
    if [ "$confirm" = "yes" ]; then
      terraform apply
      echo -e "${GREEN}✓ Infrastructure updated successfully${NC}"
    else
      echo -e "${YELLOW}Apply cancelled${NC}"
    fi
    ;;
    
  *)
    echo -e "${RED}Invalid mode: $MODE${NC}"
    echo "Usage: $0 [plan|refresh|apply]"
    echo "  plan    - Show what would change (default)"
    echo "  refresh - Update state to match actual infrastructure"
    echo "  apply   - Update infrastructure to match configuration"
    exit 1
    ;;
esac
