#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for eza..."
if command -v eza &> /dev/null; then
  print_success "eza is already installed."
else
  print_info "eza not found. Installing via Homebrew..."
  brew install eza || {
    print_error "Failed to install eza."
    exit 1
  }
  print_success "eza successfully installed."
  eza_version=$(eza --version | head -n1)
  print_success "eza version: $eza_version"
fi

