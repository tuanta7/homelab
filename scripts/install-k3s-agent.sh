#!/usr/bin/env bash
#
# Join this host to an existing K3s cluster as an agent (worker) node.
#
# Reference: https://docs.k3s.io/quick-start
#
# Usage:
#   K3S_URL=https://<server-ip>:6443 K3S_TOKEN=<token> ./install-k3s-agent.sh
#
# K3S_TOKEN can be obtained on the server node via:
#   sudo cat /var/lib/rancher/k3s/server/node-token

set -euo pipefail

K3S_URL="${K3S_URL:-}"
K3S_TOKEN="${K3S_TOKEN:-}"

log() { echo "[02-k3s-agent-install] $*"; }

if [[ -z "${K3S_URL}" || -z "${K3S_TOKEN}" ]]; then
  log "K3S_URL and K3S_TOKEN must both be set."
  exit 1
fi

if command -v k3s >/dev/null 2>&1; then
  log "k3s is already installed ($(k3s --version | head -n1)); skipping install."
  exit 0
fi

log "Joining cluster at ${K3S_URL}..."
curl -sfL https://get.k3s.io | K3S_URL="${K3S_URL}" K3S_TOKEN="${K3S_TOKEN}" sh -

log "Done."
