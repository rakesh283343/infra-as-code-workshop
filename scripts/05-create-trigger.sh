#!/usr/bin/env bash
set -e
set -o pipefail

TOKEN="$(gcloud config config-helper --format='value(credential.access_token)')"

echo "--> Creating Cloud Build Trigger"
curl "https://cloudbuild.googleapis.com/v1/projects/${GOOGLE_CLOUD_PROJECT}/triggers" \
  --silent \
  --fail \
  --output /dev/null \
  --show-error \
  --request "POST" \
  --header "Authorization: Bearer ${TOKEN}" \
  --header "Content-Type: application/json" \
  --data @- <<EOF
{
  "trigger_template": {
    "repoName": "my-infrastructure",
    "branchName": "master"
  },
  "filename": "cloudbuild.yaml"
}
EOF
