# Data Cluster GKE2

This project deploys a 2-node GKE cluster on Google Cloud Platform.

## Configuration

- **Cluster Name**: data-cluster-gke2
- **Location**: europe-central2-b (Warsaw)
- **Node Count**: 2 nodes
- **Machine Type**: e2-standard-8 (8 vCPU, 32GB RAM per node)
- **Disk**: 100GB Standard Persistent Disk per node
- **Preemptible**: Yes (cost savings)

## Prerequisites

1. Google Cloud CLI (`gcloud`) installed
2. Terraform installed
3. Service account credentials file at `/home/rami/Work/secrets/data-cluster-gke2-credentials.json`

## Usage

### Deploy the cluster
```bash
cd /home/rami/Work/google/workloads/data_cluster_gke2
scripts/start.sh
```

### Check cluster status
```bash
scripts/status.sh
```

### Check Terraform state and drift
```bash
# Check current state and detect drift
scripts/check-state.sh

# Or use Terraform directly
terraform state list              # List all managed resources
terraform plan                    # Detect configuration drift
terraform show                    # View current state
```

### Reconcile Terraform state
```bash
# Plan mode (default) - show what would change
scripts/reconcile.sh plan

# Refresh mode - update state to match actual infrastructure
scripts/reconcile.sh refresh

# Apply mode - update infrastructure to match configuration
scripts/reconcile.sh apply
```

### Connect to services
```bash
scripts/connect.sh [SERVICE]
```

### Destroy the cluster
```bash
scripts/stop.sh
```

## Cost Estimate

- **2x e2-standard-8 preemptible nodes**
- **Approximate cost**: ~$0.16/hour (~$1.28/day for 8 hours)

## Notes

- This cluster uses preemptible VMs for cost savings
- The cluster has deletion protection disabled for easy cleanup
- Standard persistent disks are used (pd-standard)
