#!/bin/bash
set -e

echo "🛑 Stopping GKE cluster..."

# Export service account credentials
export GOOGLE_APPLICATION_CREDENTIALS="/home/rami/Work/secrets/data-cluster-gke1-7bad8b712669.json"

# Navigate to the workload directory (parent of scripts/)
cd "$(dirname "$0")/.."
echo "⚠️  This will DELETE the cluster. All data will be lost."
echo ""
read -p "Continue? (yes/no): " confirm

if [ "$confirm" = "yes" ]; then
  terraform destroy -auto-approve
  echo ""
  echo "✅ Cluster destroyed. Billing stopped."
else
  echo "❌ Cancelled."
fi
