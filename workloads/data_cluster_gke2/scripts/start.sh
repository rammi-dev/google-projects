#!/bin/bash
set -e

echo "🚀 Starting GKE Cluster Deployment..."

# Configuration
PROJECT_ID="data-cluster-gke1"
CLUSTER_NAME="data-cluster-gke2"
ZONE="europe-central2-b"  # Using zone with unlimited SSD quota
CREDENTIALS_PATH="/home/rami/Work/secrets/data-cluster-gke1-7bad8b712669.json"

# Export credentials
export GOOGLE_APPLICATION_CREDENTIALS="$CREDENTIALS_PATH"

# Navigate to workload directory (parent of scripts/)
cd "$(dirname "$0")/.."

echo "📋 Running terraform plan..."
terraform plan

echo ""
read -p "Do you want to apply this plan? (yes/no): " confirm
if [ "$confirm" != "yes" ]; then
    echo "❌ Deployment cancelled"
    exit 0
fi

echo "🔨 Deploying cluster..."
terraform apply -auto-approve

echo "⏳ Waiting for cluster to be ready..."
sleep 10

echo "🔑 Configuring kubectl access..."
gcloud container clusters get-credentials "$CLUSTER_NAME" \
    --zone "$ZONE" \
    --project "$PROJECT_ID"

echo "⏳ Waiting for node pool to be ready..."
for i in {1..30}; do
    NODE_COUNT=$(kubectl get nodes --no-headers 2>/dev/null | grep -c "Ready" || echo "0")
    if [ "$NODE_COUNT" -ge 2 ]; then
        echo "✅ Node pool is ready with 2 nodes!"
        break
    fi
    echo "   Waiting for nodes... ($i/30) [Current: $NODE_COUNT/2]"
    sleep 10
done

echo ""
echo "✅ GKE Cluster deployed successfully!"
echo ""
echo "📊 Cluster Info:"
kubectl cluster-info
echo ""
echo "🖥️  Nodes:"
kubectl get nodes
echo ""
echo "📦 Namespaces:"
kubectl get namespaces
echo ""
echo "💡 Next steps:"
echo "   1. Deploy your applications: kubectl apply -f your-app.yaml"
echo "   2. Port-forward services: scripts/connect.sh"
echo "   3. When done: scripts/stop.sh"
echo ""
