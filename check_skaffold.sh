#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for Skaffold..."
if ! command -v skaffold &> /dev/null; then
  print_info "Skaffold not found. Installing via Homebrew..."
  brew install skaffold || {
    print_error "Failed to install Skaffold."
    exit 1
  }
  print_success "Skaffold installed successfully."
else
  print_success "Skaffold already installed."
fi

# Verify installation
print_info "Verifying Skaffold installation..."
skaffold_version=$(skaffold version || true)

if [ -n "$skaffold_version" ]; then
  print_success "Skaffold version: $skaffold_version"
else
  print_error "Failed to verify Skaffold installation."
  exit 1
fi

print_success "Skaffold setup complete!"

