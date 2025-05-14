#!/usr/bin/env bash

set -e

# Source utility functions
source ./utils.sh

echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc


print_success "Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
  print_success "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || print_error "Failed to install Homebrew."
  print_error "Homebrew installation initiated. Please complete the installation manually if required. Exiting script."
  exit 1
else
  print_success "Homebrew already installed."
fi

print_success "Updating Homebrew..."
brew update && brew upgrade || print_error "Failed to update/upgrade Homebrew."


