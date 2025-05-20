#!/usr/bin/env bash

set -e

# Load utility functions
source ./utils.sh

print_info "Starting Starship setup..."

# Check if Starship is available as a command
if ! command -v starship &> /dev/null; then
  print_info "Starship not found. Installing via Homebrew..."
  if brew install starship; then
    print_success "Starship successfully installed."
  else
    print_error "Failed to install Starship."
    exit 1
  fi
else
  print_success "Starship already installed."
fi

print_success "Starship setup complete!"

