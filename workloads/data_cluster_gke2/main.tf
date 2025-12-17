resource "google_container_cluster" "primary" {
  name     = "data-cluster-gke1"
  location = var.location
  project  = var.project_id

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  
  # Allow deletion for ephemeral clusters
  deletion_protection = false

  # Ensure APIs are enabled before creating the cluster
  depends_on = [
    google_project_service.apis
  ]
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  location   = var.location  # Same zone as cluster
  cluster    = google_container_cluster.primary.name
  project    = var.project_id
  
  node_count = 2

  node_config {
    preemptible  = true
    machine_type = var.machine_type
    disk_type    = "pd-standard"     # Standard persistent disk
    disk_size_gb = 100               # 100GB boot disk
    
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
