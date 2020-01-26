#!/usr/bin/env bash
set -eEuo pipefail

gcloud --quiet services enable --async \
  cloudapis.googleapis.com \
  cloudbuild.googleapis.com \
  cloudmonitoring.googleapis.com \
  cloudresourcemanager.googleapis.com \
  container.googleapis.com \
  containerregistry.googleapis.com \
  iam.googleapis.com \
  logging.googleapis.com \
  monitoring.googleapis.com \
  serviceusage.googleapis.com \
  sourcerepo.googleapis.com \
  stackdriver.googleapis.com
