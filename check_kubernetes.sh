#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for kubectl"
if ! command -v kubectl &> /dev/null; then
    print_success "kubectl not found. Installing via Homebrew..."
    brew install kubectl || print_error "Failed to install kubectl."
else
    print_success "kubectl already installed."
fi
print_success "kubectl setup complete!"