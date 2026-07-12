#!/usr/bin/env bash
set -euo pipefail

if command -v helm &>/dev/null; then
  echo "helm is already installed: $(helm version --short)"
  exit 0
fi

INSTALL_SCRIPT="$(mktemp)"

# cleanups right before termination
trap 'rm -f "$TMP_SCRIPT"' EXIT

curl -fsSL -o "$INSTALL_SCRIPT" https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
chmod 700 "$INSTALL_SCRIPT"
"$INSTALL_SCRIPT"
