#!/usr/bin/env bash
#
# Install Argo CD into the cluster (argocd namespace).
#
# Reference: https://argo-cd.readthedocs.io/en/stable/getting_started/

set -euo pipefail

NAMESPACE="argocd"
MANIFEST_URL="https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"

log() {
  echo "[install-argocd] $*";
}

if ! command -v kubectl >/dev/null 2>&1; then
  log "kubectl not found; install k3s first (make install-k3s-server)."
  exit 1
fi

if kubectl get deployment argocd-server -n "${NAMESPACE}" >/dev/null 2>&1; then
  log "Argo CD is already installed in namespace '${NAMESPACE}'; skipping install."
else
  log "Creating namespace '${NAMESPACE}'..."
  kubectl create namespace "${NAMESPACE}" --dry-run=client -o yaml | kubectl apply -f -

  log "Installing Argo CD..."
  kubectl apply -n "${NAMESPACE}" -f "${MANIFEST_URL}"
fi

log "Waiting for the Argo CD API server to become ready..."
kubectl rollout status deployment/argocd-server -n "${NAMESPACE}" --timeout=300s

if kubectl -n "${NAMESPACE}" get secret argocd-initial-admin-secret >/dev/null 2>&1; then
  log "Initial admin password (user: admin):"
  kubectl -n "${NAMESPACE}" get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
  echo
else
  log "Initial admin secret not found (password was already changed or the secret was deleted)."
fi

log "To access the UI, port-forward the API server and open https://<node-ip>:8080"
echo "  kubectl port-forward --address 0.0.0.0 svc/argocd-server -n ${NAMESPACE} 8080:443"

log "Done."