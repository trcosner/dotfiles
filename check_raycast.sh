#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
  print_error "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || print_error "Failed to install Homebrew."
  print_error "Homebrew installation initiated. Please complete the installation manually if required. Exiting script."
  exit 1
else
  print_success "Homebrew already installed."
fi

print_success "Checking for Raycast..."
if ! brew list --cask raycast &> /dev/null; then
  print_success "Raycast not found. Installing via Homebrew..."
  if brew install --cask raycast; then
    print_success "Raycast successfully installed."
  else
    print_error "Failed to install Raycast."
    exit 1
  fi
else
  print_success "Raycast already installed."
fi

print_success "Verifying Raycast installation..."
if [ -d "/Applications/Raycast.app" ]; then
    print_success "Raycast is installed and available in Applications."
else
    print_error "Raycast installation verification failed. Please check manually."
fi


print_success "Raycast setup complete!"
echo "You can open Raycast from your Applications folder or by running 'open -a Raycast'."
