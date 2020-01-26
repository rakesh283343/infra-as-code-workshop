#!/usr/bin/env bash
set -eEuo pipefail

echo "--> Creating Cloud Build Trigger"
gcloud beta builds triggers create cloud-source-repositories \
  --repo "my-infrastructure" \
  --branch-pattern "^master$" \
  --build-config "cloudbuild.yaml"
