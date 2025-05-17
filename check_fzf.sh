#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for FZF..."
if ! command -v fzf &> /dev/null; then
  print_success "FZF not found. Installing via Homebrew..."
  brew install fzf || print_error "Failed to install FZF."
else
  print_success "FZF already installed."
fi

