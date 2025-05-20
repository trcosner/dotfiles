#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for kubectl..."
if ! command -v kubectl &> /dev/null; then
  print_info "kubectl not found. Installing via Homebrew..."
  brew install kubectl || {
    print_error "Failed to install kubectl."
    exit 1
  }
  print_success "kubectl installed successfully."
else
  print_success "kubectl already installed."
fi

print_success "kubectl setup complete!"

