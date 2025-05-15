#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for Homebrew..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  print_warning "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || print_error "Failed to install Homebrew."
  print_error "Homebrew installation initiated. Please complete the installation manually if required. Exiting script."
  exit 1
else
  print_success "Homebrew already installed."
fi

print_success "Updating Homebrew..."
brew update && brew upgrade || print_error "Failed to update/upgrade Homebrew."

# Add Homebrew bin directory to PATH if not already present
ZSHRC_PATH="$HOME/.zshrc"
HOMEBREW_PATH='export PATH="/opt/homebrew/bin:$PATH"'

print_success "Checking if Homebrew path is already in .zshrc..."
if ! grep -qxF "$HOMEBREW_PATH" "$ZSHRC_PATH"; then
  echo "$HOMEBREW_PATH" >> "$ZSHRC_PATH"
  print_success "Added Homebrew bin directory to PATH in $ZSHRC_PATH."
else
  print_success "Homebrew bin directory already in PATH."
fi

print_success "Script execution complete!"
