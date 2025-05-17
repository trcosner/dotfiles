#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for clipboard tools..."
brew install xsel || print_error "Failed to install clipboard tools."
print_success "Clipboard tools installed."

