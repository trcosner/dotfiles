#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for NVM installation..."
if [ ! -d "/opt/homebrew/opt/nvm" ]; then
  print_success "NVM not found. Installing via Homebrew..."
  brew install nvm || print_error "Failed to install NVM."

  # Setting up NVM environment
  print_success "Setting up NVM environment..."
  NVM_DIR="$HOME/.nvm"
  mkdir -p "$NVM_DIR"

  # Add NVM to the shell profile if not already present
  if ! grep -q "NVM_DIR" ~/.zshrc; then
    print_success "Updating shell profile with NVM configuration..."
    {
      echo 'export NVM_DIR="$HOME/.nvm"'
      echo '[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"'
      echo '[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"'
    } >> ~/.zshrc
    print_success "Reloading shell profile..."
    source ~/.zshrc
  fi
else
  print_success "NVM already installed."
fi

print_success "Loading NVM..."
# Load NVM for the current session
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"

print_success "Checking for Node.js..."
if ! command -v node &> /dev/null; then
  print_success "Node.js not found. Installing via NVM..."
  nvm install node || print_error "Failed to install Node.js."
else
  print_success "Node.js already installed."
fi

print_success "Setting NVM to use the latest Node.js version..."
nvm alias default node || print_error "Failed to set Node.js as the default."
nvm use node || print_error "Failed to switch to the latest Node.js version."

print_success "Checking for npm..."
if ! command -v npm &> /dev/null; then
  print_success "npm not found. Installing via Node.js..."
  nvm install-latest-npm || print_error "Failed to install npm."
else
  print_success "npm already installed."
fi

print_success "Verifying installation..."
node_version=$(node -v)
npm_version=$(npm -v)
nvm_version=$(nvm --version)

print_success "NVM version: $nvm_version"
print_success "Node.js version: $node_version"
print_success "npm version: $npm_version"

print_success "NVM, Node.js, and npm setup complete!"
