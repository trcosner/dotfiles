#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for FD..."
if ! command -v fd &> /dev/null; then
  print_info "FD not found. Installing via Homebrew..."
  brew install fd || print_error "Failed to install FD."
  print_success "FD successfully installed."
  fd_version=$(fd --version | head -n1)
  print_success "FD version: $fd_version"
else
  print_success "FD already installed."
fi

