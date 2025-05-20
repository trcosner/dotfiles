#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for NVM installation..."
action_taken=false

if [ ! -d "/opt/homebrew/opt/nvm" ]; then
  print_info "NVM not found. Installing via Homebrew..."
  brew install nvm || print_error "Failed to install NVM."
  print_info "Setting up NVM environment..."
  mkdir -p "$HOME/.nvm"
  action_taken=true
else
  print_success "NVM already installed."
fi

# Load NVM for the current session
print_info "Loading NVM..."
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"

# Ensure Node.js is installed
if ! command -v node &> /dev/null; then
  print_info "Node.js not found. Installing via NVM..."
  nvm install node || print_error "Failed to install Node.js."
  action_taken=true
else
  print_success "Node.js already installed."
fi

# Set default Node version
if ! nvm alias default | grep -q 'node'; then
  print_info "Setting NVM to use the latest Node.js version..."
  nvm alias default node || print_error "Failed to set default Node.js version."
  nvm use node || print_error "Failed to use default Node.js version."
  action_taken=true
else
  print_success "Default Node.js version already set."
fi

# Ensure npm is available
if ! command -v npm &> /dev/null; then
  print_info "npm not found. Installing latest via NVM..."
  nvm install-latest-npm || print_error "Failed to install npm."
  action_taken=true
else
  print_success "npm already installed."
fi

# Only verify versions if changes were made
if $action_taken; then
  print_info "Verifying installation..."
  node_version=$(node -v)
  npm_version=$(npm -v)
  nvm_version=$(nvm --version)

  print_success "NVM version: $nvm_version"
  print_success "Node.js version: $node_version"
  print_success "npm version: $npm_version"
else
  print_info "Node.js environment already up to date. Skipping re-verification."
fi

