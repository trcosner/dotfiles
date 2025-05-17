#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for FD..."
if ! command -v fd &> /dev/null; then
  print_success "FD not found. Installing via Homebrew..."
  brew install fd || print_error "Failed to install FD."
else
  print_success "FD already installed."
fi

