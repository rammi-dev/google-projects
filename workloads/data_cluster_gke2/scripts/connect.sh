#!/bin/bash
# Port-forward services from GKE cluster to your laptop
# This runs on YOUR LAPTOP, not in the cloud

if [ -z "$1" ]; then
  echo "Usage: ./connect.sh [SERVICE]"
  echo ""
  echo "Available services:"
  echo "  minio     - MinIO object storage (ports 9000, 9001)"
  echo "  vault     - HashiCorp Vault (port 8200)"
  echo "  keycloak  - Keycloak SSO (port 8080)"
  echo ""
  echo "Custom: kubectl port-forward svc/SERVICE LOCAL_PORT:REMOTE_PORT"
  exit 1
fi

# Verify kubectl is configured
if ! kubectl cluster-info &>/dev/null; then
  echo "❌ kubectl not connected to cluster"
  echo "Run: gcloud container clusters get-credentials data-cluster-gke2 --region europe-central2 --project data-cluster-gke1"
  exit 1
fi

case "$1" in
  minio)
    echo "🔗 Forwarding MinIO to your laptop..."
    echo "   API:     http://localhost:9000"
    echo "   Console: http://localhost:9001"
    echo ""
    echo "Press Ctrl+C to stop port-forwarding"
    kubectl port-forward svc/minio 9000:9000 9001:9001
    ;;
  vault)
    echo "🔗 Forwarding Vault to your laptop..."
    echo "   UI: http://localhost:8200"
    echo ""
    echo "Press Ctrl+C to stop port-forwarding"
    kubectl port-forward svc/vault 8200:8200
    ;;
  keycloak)
    echo "🔗 Forwarding Keycloak to your laptop..."
    echo "   UI: http://localhost:8080"
    echo ""
    echo "Press Ctrl+C to stop port-forwarding"
    kubectl port-forward svc/keycloak 8080:8080
    ;;
  *)
    echo "❌ Unknown service: $1"
    echo "Run './connect.sh' without arguments to see available services"
    exit 1
    ;;
esac
