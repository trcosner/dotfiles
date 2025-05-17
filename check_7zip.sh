#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for 7-Zip..."
if ! command -v 7zz &> /dev/null; then
  print_success "7-Zip not found. Installing via Homebrew..."
  brew install p7zip || print_error "Failed to install 7-Zip."
else
  print_success "7-Zip already installed."
fi

