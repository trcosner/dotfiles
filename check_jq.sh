#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for jq..."
if ! command -v jq &> /dev/null; then
  print_info "jq not found. Installing via Homebrew..."
  brew install jq || print_error "Failed to install jq."
  print_success "jq successfully installed."
  jq_version=$(jq --version)
  print_success "jq version: $jq_version"
else
  print_success "jq already installed."
fi

