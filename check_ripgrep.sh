#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for Zsh..."
if ! command -v zsh &> /dev/null; then
  print_error "Zsh not found. Installing via Homebrew..."
  brew install zsh || print_error "Failed to install Zsh."
else
  print_success "Zsh already installed."
fi

print_success "Checking for Ripgrep..."
if ! command -v rg &> /dev/null; then
  print_success "Ripgrep not found. Installing via Homebrew..."
  brew install ripgrep || print_error "Failed to install Ripgrep."
else
  print_success "Ripgrep already installed."
fi

print_success "Updating .zshrc for Ripgrep alias..."

print_success "Reloading .zshrc to apply changes..."
zsh -c "source ~/.zshrc"

print_success "Ripgrep setup complete!"
echo "You can now use 'grep' as an alias for 'rg' (Ripgrep)."
