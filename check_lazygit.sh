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

print_success "Checking for LazyGit..."
if ! command -v lazygit &> /dev/null; then
  print_success "LazyGit not found. Installing via Homebrew..."
  if brew install lazygit; then
    print_success "LazyGit successfully installed."
  else
    print_error "Failed to install LazyGit."
    exit 1
  fi
else
  print_success "LazyGit already installed."
fi

print_success "Verifying LazyGit installation..."
if command -v lazygit &> /dev/null; then
  lazygit_version=$(lazygit --version | head -n 1)
  print_success "LazyGit version: $lazygit_version"
else
  print_error "LazyGit installation verification failed."
  exit 1
fi

print_success "LazyGit setup complete!"
echo "Run 'lazygit' to start using the tool."

