#
# This file contains all the interactions with Google Cloud
#

# This queries GCP for the latest Kubernetes engine version.
data "google_container_engine_versions" "versions" {
  location = var.region
}

# This creates a new Google Kubernetes Engine (GKE) cluster inside our project.
# This operation can take a few minutes to complete, but Terraform will show
# output and updates as the creation progresses.
resource "google_container_cluster" "my-cluster" {
  name     = "my-cluster"
  location = var.region

  initial_node_count = 1

  min_master_version = data.google_container_engine_versions.versions.latest_master_version
  node_version       = data.google_container_engine_versions.versions.latest_node_version

  node_config {
    machine_type = var.instance_type
  }
}
resource "google_compute_address" "default" {
  name   = "my-address"
  region = var.region
}