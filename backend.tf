terraform {
  backend "gcs" {
    bucket = "terraform-state-gke-tf"
  }
}