#!/usr/bin/env bash

if ! command -v brew &>/dev/null; then
  echo "brew is not installed. Run 'make install-brew' first."
  exit 1
fi

brew install derailed/k9s/k9s
