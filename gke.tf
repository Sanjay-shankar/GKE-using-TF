data "google_container_engine_versions" "gke_version"{
    location       = var.zone
    version_prefix = "1.27."
}

resource "google_container_cluster" "primary" {
  name     = "${var.project}-gke"
  location = var.zone

  deletion_protection = true 
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

resource "google_container_node_pool" "primary_nodes" {
    name     = google_container_cluster.primary.name
    location = var.zone
    cluster  = google_container_cluster.primary.name

    version  = data.google_container_engine_versions.gke_version.latest_master_version
    node_count = var.gke_num_nodes

    node_config {
      oauth_scopes = [
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
      ]

      labels = {
        env = var.project
      }

      machine_type = "e2-medium"
      tags = ["gke-node","${var.project}-gke"]
      metadata = {
        disable-legacy-endpoints = "true"
      }
    }
        
}

