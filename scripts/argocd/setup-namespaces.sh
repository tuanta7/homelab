#!/usr/bin/env bash

# Create the application namespaces (dev, prod) and grant
# Argo CD permission to manage them.

set -euo pipefail

NAMESPACES=(dev prod)

log() {
  echo "[setup-namespaces] $*";
}

if ! command -v kubectl >/dev/null 2>&1; then
  log "kubectl not found; install k3s first (make install-k3s-server)."
  exit 1
fi

for ns in "${NAMESPACES[@]}"; do
  log "Creating namespace '${ns}'..."
  kubectl create namespace "${ns}" --dry-run=client -o yaml | kubectl apply -f -

  log "Granting Argo CD access to '${ns}'..."
  kubectl label namespace "${ns}" argocd.argoproj.io/managed-by=argocd --overwrite
done

log "Namespaces:"
kubectl get namespaces -l argocd.argoproj.io/managed-by=argocd

log "Done."