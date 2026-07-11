#!/usr/bin/env bash
#
# Install K3s and bootstrap a single-node cluster as the first control-plane node.
#
# Reference: https://docs.k3s.io/quick-start
#
# To join additional nodes as agents, see install-k3s-agent.sh.

set -euo pipefail

log() { 
  echo "[install-k3s-server] $*"; 
}

print_agent_join_info() {
  local ip
  ip="$(hostname -I | awk '{print $1}')"
  log "To join an agent node, run on the agent host (see install-k3s-agent.sh):"
  echo " make install-k3s-agent URL=https://${ip}:6443 TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)"
}

if command -v k3s >/dev/null 2>&1; then
  log "k3s is already installed ($(k3s --version | head -n1)); skipping install."
  print_agent_join_info
  exit 0
fi

log "Installing k3s server..."
curl -sfL https://get.k3s.io | sh -

log "Waiting for the node to become Ready..."
until sudo k3s kubectl get nodes 2>/dev/null | grep -q " Ready"; do
  sleep 2
done

log "Configuring kubeconfig for user '${USER}'..."
mkdir -p "${HOME}/.kube"
sudo cp /etc/rancher/k3s/k3s.yaml "${HOME}/.kube/config"
sudo chown "$(id -u)":"$(id -g)" "${HOME}/.kube/config"
chmod 600 "${HOME}/.kube/config"

print_agent_join_info

log "Cluster nodes:"
kubectl get nodes -o wide

log "Done."
