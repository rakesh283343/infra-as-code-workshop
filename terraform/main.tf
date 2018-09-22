#
# This file contains all the interactions with Google Cloud
#

# This configures the Google Cloud provider to talk to Google Cloud in the
# proper region, zone, and project. It's possible to configure the Google Cloud
# provider multiple times, each with different configuration. For simplicity,
# this example only uses one provider.
provider "google" {
  region = "${var.region}"
  zone   = "${var.zone}"
}

# This queries GCP for the latest Kubernetes engine version.
data "google_container_engine_versions" "versions" {
  zone = "${var.zone}"
}

# This creates a new Google Kubernetes Engine (GKE) cluster inside our project.
# This operation can take a few minutes to complete, but Terraform will show
# output and updates as the creation progresses.
resource "google_container_cluster" "my-cluster" {
  name = "my-cluster"
  zone = "${var.zone}"

  initial_node_count = "3"

  min_master_version = "${data.google_container_engine_versions.versions.latest_master_version}"
  node_version       = "${data.google_container_engine_versions.versions.latest_node_version}"

  node_config {
    machine_type = "${var.instance_type}"
  }
}
