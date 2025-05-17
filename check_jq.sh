#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for JQ..."
if ! command -v jq &> /dev/null; then
  print_success "JQ not found. Installing via Homebrew..."
  brew install jq || print_error "Failed to install JQ."
else
  print_success "JQ already installed."
fi

