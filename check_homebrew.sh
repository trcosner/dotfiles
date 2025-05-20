#!/usr/bin/env bash

set -e

source ./utils.sh

print_info "Checking for Homebrew..."

verify_homebrew_installed

print_info "Updating Homebrew..."
brew update && brew upgrade || print_error "Failed to update/upgrade Homebrew."

# Add Homebrew bin directory to PATH if not already present
ZSHRC_PATH="$HOME/.zshrc"
HOMEBREW_PATH='export PATH="/opt/homebrew/bin:$PATH"'

print_info "Checking if Homebrew path is already in .zshrc..."
if ! grep -qxF "$HOMEBREW_PATH" "$ZSHRC_PATH"; then
  echo "$HOMEBREW_PATH" >> "$ZSHRC_PATH"
  print_success "Added Homebrew bin directory to PATH in $ZSHRC_PATH."
else
  print_info "Homebrew bin directory already in PATH."
fi

print_success "Homebrew setup complete!"
