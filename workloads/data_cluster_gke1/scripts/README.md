# Daily Workflow Scripts

Automation scripts for managing your ephemeral GKE cluster.

## Scripts

### `start.sh`
Deploys the GKE cluster and configures kubectl on your laptop.

**Usage:**
```bash
./start.sh
```

**What it does:**
1. Exports service account credentials
2. Runs `terraform apply` in the workload directory
3. Configures kubectl to connect to the cluster
4. Shows cluster status

**Time:** 3-5 minutes

---

### `stop.sh`
Destroys the cluster to stop billing.

**Usage:**
```bash
./stop.sh
```

**What it does:**
1. Shows estimated daily cost
2. Prompts for confirmation
3. Runs `terraform destroy` in the workload directory
4. Stops all billing

**Time:** 2-3 minutes

---

### `connect.sh`
Port-forwards services from the cluster to your laptop.

**Usage:**
```bash
./connect.sh [SERVICE]
```

**Available services:**
- `minio` - MinIO on localhost:9000 (API), localhost:9001 (Console)
- `vault` - Vault on localhost:8200
- `keycloak` - Keycloak on localhost:8080

**Example:**
```bash
./connect.sh minio
# Now access MinIO at http://localhost:9000
```

**Custom port-forward:**
```bash
kubectl port-forward svc/YOUR_SERVICE LOCAL_PORT:REMOTE_PORT
```

**Important:** 
- This runs on YOUR LAPTOP, not in the cloud
- kubectl must be configured (start.sh does this automatically)
- Press Ctrl+C to stop port-forwarding

---

## Quick Reference

```bash
# Morning
cd /home/rami/Work/google
scripts/start.sh

# During day
scripts/connect.sh minio

# Evening
scripts/stop.sh
```
