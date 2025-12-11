resource "google_compute_firewall" "nodeports" {
  name    = "allow-nodeports"
  network = "default" # GKE uses default network in our simple config
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  source_ranges = ["0.0.0.0/0"] # Open to world (simplest for playground)
  target_tags   = ["gke-node"]  # We need to ensure nodes have this tag
}
