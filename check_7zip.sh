#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for 7-Zip (7zz)..."
if ! command -v 7zz &> /dev/null; then
  print_info "7zz not found. Installing official 7-Zip via Homebrew..."
  brew install 7zip || {
    print_error "Failed to install 7-Zip."
    exit 1
  }
  print_success "7-Zip installed successfully."
  print_success "7zz path: $(command -v 7zz)"
else
  print_success "7-Zip (7zz) already installed."
fi

