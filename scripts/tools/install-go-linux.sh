#!/usr/bin/env bash
set -euo pipefail

GO_VERSION="${GO_VERSION:-1.26.5}"

if command -v go &>/dev/null && [[ "$(go version)" == *"go${GO_VERSION} "* ]]; then
  echo "go ${GO_VERSION} is already installed: $(go version)"
  exit 0
fi

case "$(uname -m)" in
  x86_64) ARCH="amd64" ;;
  aarch64 | arm64) ARCH="arm64" ;;
  *)
    echo "unsupported architecture: $(uname -m)"
    exit 1
    ;;
esac

TARBALL="go${GO_VERSION}.linux-${ARCH}.tar.gz"
TMP_TARBALL="$(mktemp)"

# cleanups right before termination
trap 'rm -f "$TMP_TARBALL"' EXIT

curl -fsSL -o "$TMP_TARBALL" "https://go.dev/dl/${TARBALL}"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "$TMP_TARBALL"

if ! grep -q '/usr/local/go/bin' ~/.bashrc; then
  echo 'export PATH=$PATH:/usr/local/go/bin' >>~/.bashrc
fi

/usr/local/go/bin/go version
