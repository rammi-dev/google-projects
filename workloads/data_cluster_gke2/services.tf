resource "google_project_service" "apis" {
  project = var.project_id
  for_each = toset([
    "compute.googleapis.com",
    "container.googleapis.com"
  ])
  service            = each.key
  disable_on_destroy = false
}
