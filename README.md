# GCP Workloads

This repository contains Terraform configurations for deploying workloads to manually created GCP projects.

## Structure

### `workloads/` - Application Deployments
Deploy actual applications (GKE clusters, VMs, etc.) into your manually created projects.

**Current Workloads:**
- `data_cluster_gke1/` - High-performance ephemeral GKE cluster for daily sandbox use

## Getting Started

1. Create a GCP project manually in Console
2. Create a Service Account with Owner/Editor permissions
3. Download the JSON key
4. Navigate to the workload directory and follow its README
