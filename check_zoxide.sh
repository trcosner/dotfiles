#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for zoxide..."
if ! command -v zoxide &> /dev/null; then
  print_info "zoxide not found. Installing via Homebrew..."
  brew install zoxide || {
    print_error "Failed to install zoxide."
    exit 1
  }
  print_success "zoxide successfully installed."
  zoxide_version=$(zoxide --version | head -n1)
  print_success "zoxide version: $zoxide_version"
else
  print_success "zoxide already installed."
fi

print_success "zoxide setup complete!"

