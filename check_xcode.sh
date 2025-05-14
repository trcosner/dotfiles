#!/usr/bin/env bash

set -e

# Source utility functions
source ./utils.sh

print_success "Checking for Xcode Command Line Tools..."
if ! xcode-select -p &> /dev/null; then
  print_success "Xcode Command Line Tools not found. Installing..."
  xcode-select --install || print_error "Failed to install Xcode Command Line Tools."
  print_error "Xcode Command Line Tools installation initiated. Please complete the installation manually. Exiting script."
  exit 1
else
  print_success "Xcode Command Line Tools already installed."
fi

