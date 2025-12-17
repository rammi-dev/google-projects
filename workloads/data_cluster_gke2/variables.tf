variable "project_id" {
  description = "The Project ID where the cluster will be deployed (output from infrastructure step)."
  type        = string
}

variable "region" {
  description = "The region for the cluster."
  type        = string
  default     = "europe-central2"  # Warsaw
}

variable "machine_type" {
  description = "The machine type for the GKE node pool."
  type        = string
  default     = "e2-standard-8"  # 4 vCPU, 16GB RAM
}

variable "location" {
  description = "Location for the cluster."
  type        = string
  default     = "us-central1-a"  # Iowa
}
