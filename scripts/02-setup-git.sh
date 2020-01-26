#!/usr/bin/env bash
set -eEuo pipefail

if [ ! -f "${HOME}/.gitconfig" ]; then
  echo ""
  echo "==> Configuring git user"

  read -p "What is your name? (e.g. Jane Smith): " NAME
  read -p "What is your email? (e.g. jane@smith.com): " EMAIL

  git config --global user.name "${NAME}"
  git config --global user.email "${EMAIL}"
fi

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)"

git -C "${DIR}" init
git -C "${DIR}" remote add origin "https://source.developers.google.com/p/${GOOGLE_CLOUD_PROJECT}/r/my-infrastructure"
git -C "${DIR}" add .
git -C "${DIR}" commit -m "Initial commit"
