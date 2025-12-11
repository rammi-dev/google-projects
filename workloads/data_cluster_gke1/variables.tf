variable "project_id" {
  description = "The Project ID where the cluster will be deployed (output from infrastructure step)."
  type        = string
}

variable "region" {
  description = "The region for the cluster."
  type        = string
  default     = "europe-central2"  # Warsaw
}
