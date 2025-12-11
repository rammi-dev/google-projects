# GCP GKE Workloads

This repository contains GKE workload configurations for different environments.

## Structure

```
workloads/
└── data_cluster_gke1/     # Data platform GKE cluster
    ├── scripts/           # Deployment scripts for this workload
    ├── *.tf              # Terraform configuration
    └── README.md         # Workload-specific documentation
```

Each workload is self-contained with its own scripts and configuration.

**Current Workloads:**
- `data_cluster_gke1/` - High-performance ephemeral GKE cluster for daily sandbox use

## Getting Started

1. Create a GCP project manually in Console
2. Create a Service Account with Owner/Editor permissions
3. Download the JSON key
4. Navigate to the workload directory and follow its README
