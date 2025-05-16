#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for fc-list..."
if ! command -v fc-list &> /dev/null; then
  print_error "fc-list not found. Installing fontconfig via Homebrew..."
  if brew install fontconfig; then
    print_success "fontconfig successfully installed."
  else
    print_error "Failed to install fontconfig."
    exit 1
  fi
else
  print_success "fc-list already installed."
fi

print_success "Checking for Hasklug Nerd Font..."
if fc-list | grep -qi "Hack Nerd Font"; then
  print_success "Hasklug Nerd Font already installed."




 else
  print_success "Hasklug Nerd Font not found. Installing via Homebrew..."
  if brew install --cask font-hack-nerd-font; then
    print_success "Hasklug Nerd Font successfully installed."
    print_success "Updating font cache..."
    fc-cache -fv
  else
    print_error "Failed to install Hasklug Nerd Font."
    exit 1
  fi
fi

print_success "Verifying Hasklug Nerd Font installation..."
if fc-list | grep -qi "Hack Nerd Font"; then
  print_success "Hasklug Nerd Font successfully installed and detected."
elif fc-list | grep -qi "Hasklug"; then
  print_success "Hasklug Nerd Font successfully installed and detected (alternative name)."
else
  print_error "Hasklug Nerd Font installation failed or not detected."
fi

print_success "Hasklug Nerd Font setup complete!"
