#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for Resvg..."
if ! command -v resvg &> /dev/null; then
  print_info "Resvg not found. Installing via Homebrew..."
  brew install resvg || {
    print_error "Failed to install Resvg."
    exit 1
  }
  print_success "Resvg installed successfully."
  resvg_version=$(resvg --version 2>/dev/null || true)
  if [ -n "$resvg_version" ]; then
    print_success "Resvg version: $resvg_version"
  fi
else
  print_success "Resvg already installed."
fi

