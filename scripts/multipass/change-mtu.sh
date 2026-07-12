#!/usr/bin/env bash
set -euo pipefail

INSTANCE="${INSTANCE:-k3s-server}"
INTERFACE="${INTERFACE:-eth0}"
MTU="${MTU:-1450}"

# Find a workable value first: ping -D -s <MTU - 28> google.com
multipass exec "$INSTANCE" -- sudo ip link set "$INTERFACE" mtu "$MTU"
multipass exec "$INSTANCE" -- ip link show "$INTERFACE"

echo "MTU of $INTERFACE on '$INSTANCE' set to $MTU (not persistent across reboots)"