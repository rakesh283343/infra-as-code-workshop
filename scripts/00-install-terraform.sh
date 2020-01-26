#!/usr/bin/env bash
set -eEuo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)"

NAME="terraform"
VERSION="0.12.20"
BUCKET="${GOOGLE_CLOUD_PROJECT}-terraform-state"

echo "--> Installing terraform"
mkdir -p "${HOME}/bin"
docker run -v ${HOME}/bin:/software sethvargo/hashicorp-installer "${NAME}" "${VERSION}"
sudo chown -R $(whoami):$(whoami) "${HOME}/bin"
sudo chmod +x "${HOME}/bin/${NAME}"

echo "--> Installing completions"
"${HOME}/bin/${NAME}" -install-autocomplete || true

echo "--> Creating storage bucket"
gsutil -q mb "gs://${BUCKET}"

echo "--> Configuring Terraform to talk to bucket"
cat > "${DIR}/terraform/state.tf" <<EOF
# This configures Terraform to store it state in the Google Cloud Storage bucket
# named ${BUCKET}. This is important so that the state can be
# accessed by multiple people or services (like Google Cloud Build).
terraform {
  backend "gcs" {
    bucket = "${BUCKET}"
  }
}
EOF

echo "--> Done!"
exec -l $SHELL
