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

# Check if .zshrc already includes Ripgrep alias
if ! grep -q "alias rg" ~/.zshrc; then
  print_success "Adding Ripgrep alias to .zshrc..."
  {
    echo ''
    echo '# Ripgrep alias for convenience'
    echo 'alias grep="rg"'
  } >> ~/.zshrc
  print_success "Ripgrep alias added to .zshrc."
else
  print_success "Ripgrep alias already configured in .zshrc."
fi

print_success "Reloading .zshrc to apply changes..."
zsh -c "source ~/.zshrc"

print_success "Ripgrep setup complete!"
echo "You can now use 'grep' as an alias for 'rg' (Ripgrep)."
