#!/usr/bin/env bash
set -euo pipefail

NAME="${NAME:-k3s-server}"
IMAGE="${IMAGE:-24.04}"
CPUS="${CPUS:-1}"
MEMORY="${MEMORY:-1G}"
DISK="${DISK:-20G}"

if ! command -v multipass &>/dev/null; then
  echo "multipass is not installed. Run 'make install-multipass-macos' first."
  exit 1
fi

if multipass info "$NAME" &>/dev/null; then
  echo "instance '$NAME' already exists"
  multipass info "$NAME"
  exit 0
fi

BRIDGED_NETWORK="$(multipass get local.bridged-network)"
if [[ -z "$BRIDGED_NETWORK" || "$BRIDGED_NETWORK" == "<empty>" ]]; then
  echo "no bridged network configured. Run ./create-bridged-network.sh first."
  exit 1
fi

multipass launch "$IMAGE" --name "$NAME" --bridged --cpus "$CPUS" --memory "$MEMORY" --disk "$DISK"
multipass info "$NAME"