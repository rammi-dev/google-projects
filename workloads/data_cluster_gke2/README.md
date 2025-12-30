# Data Cluster GKE1

This project deploys a 2-node GKE cluster on Google Cloud Platform.

## Configuration

- **Cluster Name**: data-cluster-gke1
- **Location**: us-central1-a (Iowa)
- **Node Count**: 2 nodes
- **Machine Type**: e2-standard-4 (4 vCPU, 16GB RAM per node)
- **Disk**: 100GB Standard Persistent Disk per node
- **Preemptible**: Yes (cost savings)

## Prerequisites

1. Google Cloud CLI (`gcloud`) installed
2. Terraform installed
3. Service account credentials file at `/home/rami/Work/secrets/data-cluster-gke1-7bad8b712669.json`

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

- **2x e2-standard-4 preemptible nodes**
- **Approximate cost**: ~$0.08/hour (preemptible pricing)

## Notes

- This cluster uses preemptible VMs for cost savings
- The cluster has deletion protection disabled for easy cleanup
- Standard persistent disks are used (pd-standard)
