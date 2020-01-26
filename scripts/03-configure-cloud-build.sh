#!/usr/bin/env bash
set -eEuo pipefail

PROJECT_NUMBER="$(gcloud projects describe ${GOOGLE_CLOUD_PROJECT} --format='value(projectNumber)')"
SERVICE_ACCOUNT="${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com"

echo "--> Granting access to project"
gcloud --quiet projects add-iam-policy-binding "${GOOGLE_CLOUD_PROJECT}" \
  --member "serviceAccount:${SERVICE_ACCOUNT}" \
  --role "roles/editor"

echo "--> Granting access to Terraform state bucket"
gsutil -q iam ch serviceAccount:${SERVICE_ACCOUNT}:objectAdmin gs://${GOOGLE_CLOUD_PROJECT}-terraform-state

echo "--> Done"
