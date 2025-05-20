#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for clipboard tool (xsel)..."
if ! command -v xsel &> /dev/null; then
  print_info "xsel not found. Installing via Homebrew..."
  brew install xsel || {
    print_error "Failed to install xsel."
    exit 1
  }
  print_success "xsel installed successfully."
else
  print_success "xsel already installed."
fi

