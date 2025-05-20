#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for Raycast..."
if ! brew list --cask raycast &> /dev/null; then
  print_info "Raycast not found. Installing via Homebrew..."
  if brew install --cask raycast; then
    print_success "Raycast successfully installed."
  else
    print_error "Failed to install Raycast."
    exit 1
  fi
else
  print_success "Raycast is already installed."
fi

print_info "Verifying Raycast installation..."
if [ -d "/Applications/Raycast.app" ]; then
  print_success "Raycast is installed and available in Applications."
else
  print_error "Raycast installation verification failed. Please check manually."
fi

print_success "Raycast setup complete!"
