#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for Resvg..."
if ! command -v resvg &> /dev/null; then
  print_success "Resvg not found. Installing via Homebrew..."
  brew install resvg || print_error "Failed to install Resvg."
else
  print_success "Resvg already installed."
fi

