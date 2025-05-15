#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for Skaffold..."
if ! command -v skaffold &> /dev/null; then
  print_success "Skaffold not found. Installing via Homebrew..."
  brew install skaffold || print_error "Failed to install Skaffold."
else
  print_success "Skaffold already installed."
fi

print_success "Verifying Skaffold installation..."
skaffold_version=$(skaffold version)

if [ -n "$skaffold_version" ]; then
  print_success "Skaffold version: $skaffold_version"
else
  print_error "Failed to verify Skaffold installation."
fi

print_success "Skaffold setup complete!"
