#!/usr/bin/env bash

set -e

source ./utils.sh
verify_homebrew_installed

print_info "Checking for LazyGit..."
if ! command -v lazygit &> /dev/null; then
  print_info "LazyGit not found. Installing via Homebrew..."
  brew install lazygit || {
    print_error "Failed to install LazyGit."
    exit 1
  }
  print_success "LazyGit successfully installed."
  lazygit_version=$(lazygit --version | head -n 1)
  print_success "LazyGit version: $lazygit_version"
else
  print_success "LazyGit already installed."
fi

print_success "LazyGit setup complete!"

