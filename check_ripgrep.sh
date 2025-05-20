#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for Ripgrep (rg)..."
if ! command -v rg &> /dev/null; then
  print_info "Ripgrep not found. Installing via Homebrew..."
  brew install ripgrep || print_error "Failed to install Ripgrep."
  print_success "Ripgrep successfully installed."
else
  print_success "Ripgrep already installed."
fi

print_success "Ripgrep setup complete!"
