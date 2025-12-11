#!/bin/bash
# Destroy cluster to stop billing
set -e

WORKLOAD_DIR="$(cd "$(dirname "$0")/../workloads/data_cluster_gke1" && pwd)"

export GOOGLE_APPLICATION_CREDENTIALS="/home/rami/Work/secrets/data-cluster-gke1-7bad8b712669.json"

echo "💰 Estimated cost today: ~\$0.16/hr × hours_used"
echo "⚠️  This will DELETE the cluster. All data will be lost."
echo ""
read -p "Continue? (yes/no): " confirm

if [ "$confirm" = "yes" ]; then
  cd "$WORKLOAD_DIR"
  terraform destroy -auto-approve
  echo ""
  echo "✅ Cluster destroyed. Billing stopped."
else
  echo "❌ Cancelled."
fi
