# Firewall rule for NodePort access (currently not needed - using kubectl port-forward)
# Uncomment this if you want to expose services via NodePort for public access
# without needing kubectl port-forward running on your laptop
#
# resource "google_compute_firewall" "nodeports" {
#   name    = "allow-nodeports"
#   network = "default" # GKE uses default network in our simple config
#   project = var.project_id
#
#   allow {
#     protocol = "tcp"
#     ports    = ["30000-32767"]
#   }
#
#   source_ranges = ["0.0.0.0/0"] # Open to world (simplest for playground)
#   target_tags   = ["gke-node"]  # We need to ensure nodes have this tag
# }
