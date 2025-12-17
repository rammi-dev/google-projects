#!/bin/bash

echo "📋 GKE Cluster Status Check"
echo ""

# Configuration
PROJECT_ID="data-cluster-gke1"
CLUSTER_NAME="data-cluster-gke2"
ZONE="europe-central2-b"

# Check if cluster exists
echo "🔍 Checking cluster status..."
CLUSTER_STATUS=$(gcloud container clusters describe "$CLUSTER_NAME" \
    --zone "$ZONE" \
    --project "$PROJECT_ID" \
    --format="value(status)" 2>/dev/null || echo "NOT_FOUND")

if [ "$CLUSTER_STATUS" = "NOT_FOUND" ]; then
    echo "❌ Cluster not found"
    echo "   Run: scripts/start.sh to create the cluster"
    exit 1
fi

echo "✅ Cluster Status: $CLUSTER_STATUS"
echo ""

# Get cluster info
echo "📊 Cluster Information:"
gcloud container clusters describe "$CLUSTER_NAME" \
    --zone "$ZONE" \
    --project "$PROJECT_ID" \
    --format="table(name,location,currentMasterVersion,currentNodeCount,status)"

echo ""
echo "🖥️  Nodes:"
kubectl get nodes -o wide

echo ""
echo "📦 Pods by Namespace:"
kubectl get pods --all-namespaces

echo ""
echo "🌐 Services:"
kubectl get svc --all-namespaces

echo ""
echo "💰 Estimated Cost:"
echo "   Node: 2x e2-standard-8 preemptible"
echo "   Cost: ~\$0.16/hour (~\$1.28/day for 8 hours)"
