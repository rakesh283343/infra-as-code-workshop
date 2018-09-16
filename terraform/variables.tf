variable "region" {
  type    = "string"
  default = "asia-northeast1"
}

variable "zone" {
  type    = "string"
  default = "asia-northeast1-b"
}

variable "instance_type" {
  type    = "string"
  default = "n1-standard-1"
}

variable "kubernetes_version" {
  type    = "string"
  default = "1.10.7-gke.1"
}
