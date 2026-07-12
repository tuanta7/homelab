#!/usr/bin/env bash
set -euo pipefail

# Host network interface to bridge (see `multipass networks`), e.g. en1 for Wi-Fi
INTERFACE="${INTERFACE:-en1}"

if ! command -v multipass &>/dev/null; then
  echo "multipass is not installed. Run 'make install-multipass-macos' first."
  exit 1
fi

echo "Available networks:"
multipass networks

multipass set local.bridged-network="$INTERFACE"
echo "Bridged network is now set to: $(multipass get local.bridged-network)"