# Data Cluster GKE1

High-performance ephemeral GKE cluster for daily sandbox use.

## Quick Start

### Daily Workflow

**Start your day:**
```bash
cd /home/rami/Work/google/workloads/data_cluster_gke1
scripts/start.sh
```

**Port-forward services:**
```bash
scripts/connect.sh
```

**End your day:**
```bash
scripts/stop.sh
```

## Prerequisites
1. **Project**: `data-cluster-gke1` (created manually)
2. **Service Account**: Owner permissions, key at `/home/rami/Work/secrets/data-cluster-gke1-7bad8b712669.json`
3. **Terraform**: Installed
4. **gcloud CLI**: Installed

```bash
scripts/start.sh
```
- Deploys GKE cluster (~3-5 minutes)
- Configures kubectl on your laptop automatically
- Cost: ~$0.16/hour

### During Day: Access Services (On Your Laptop)
```bash
# Port-forward to your laptop
scripts/connect.sh minio      # MinIO on localhost:9000, :9001
scripts/connect.sh vault      # Vault on localhost:8200
scripts/connect.sh keycloak   # Keycloak on localhost:8080

# Or custom port-forward
kubectl port-forward svc/YOUR_SERVICE LOCAL_PORT:REMOTE_PORT
```

### Evening: Stop Cluster
```bash
scripts/stop.sh
```
- Destroys cluster
- Stops all billing
- **Important**: All data is lost (ephemeral by design)

## Manual Commands

If you prefer manual control:

```bash
# Start
export GOOGLE_APPLICATION_CREDENTIALS="/home/rami/Work/secrets/data-cluster-gke1-7bad8b712669.json"
terraform apply

# Connect kubectl
gcloud container clusters get-credentials data-cluster-gke1 \
  --zone europe-central2-b \
  --project data-cluster-gke1

# Stop
terraform destroy
```

## Configuration

Edit `terraform.tfvars` to change settings:
```hcl
project_id = "data-cluster-gke1"
region     = "europe-central2"  # Warsaw (cost-effective)
```

## Cost Tracking

| Duration | Cost (Preemptible) |
|----------|-------------------|
| 1 hour   | $0.16 |
| 4 hours  | $0.64 |
| 8 hours  | $1.28 |
| Full day | $3.84 |

## Troubleshooting

**Cluster creation fails?**
- Verify service account has Owner/Editor role
- Check `GOOGLE_APPLICATION_CREDENTIALS` is set
- Ensure APIs are enabled (script does this automatically)

**kubectl not connecting?**
- Run: `gcloud container clusters get-credentials data-cluster-gke1 --region europe-central2 --project data-cluster-gke1`

**Port-forward fails?**
- Ensure service exists: `kubectl get svc`
- Check service name matches: `kubectl get svc SERVICE_NAME`
