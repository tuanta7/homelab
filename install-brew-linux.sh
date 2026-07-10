#!/usr/bin/env bash
set -euo pipefail

if command -v brew &>/dev/null; then
  echo "brew is already installed: $(brew --version | head -1)"
  exit 0
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

if ! grep -q 'brew shellenv' ~/.bashrc; then
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc
fi

echo "brew installed: $(brew --version | head -1)"
