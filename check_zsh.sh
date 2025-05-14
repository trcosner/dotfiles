#!/usr/bin/env bash

set -e

# Source utility functions
source ./utils.sh

print_success "Checking for Zsh..."
# Check if Zsh is installed via Homebrew
if [ -x "/opt/homebrew/bin/zsh" ] || [ -x "/usr/local/bin/zsh" ]; then
  echo "Zsh installed via Homebrew."
else
  echo "Zsh not found via Homebrew. Installing with Homebrew..."
  brew install zsh || echo "Error: Failed to install Zsh."
fi

# Add Homebrew Zsh to /etc/shells if not present
if ! grep -q "/bin/zsh" /etc/shells; then
  print_success "Adding Homebrew Zsh to /etc/shells..."
  echo "/bin/zsh" | sudo tee -a /etc/shells
fi

# Change default shell to Homebrew Zsh
if [ "$SHELL" != "/bin/zsh" ]; then
  print_success "Changing default shell to Homebrew Zsh..."
  chsh -s /bin/zsh
fi

# Symlink Zsh configuration
ZSH_CONFIG_DIR="$HOME/.dotfiles/zsh"
if [ ! -d "$ZSH_CONFIG_DIR" ]; then
  mkdir -p "$ZSH_CONFIG_DIR"
fi

print_success "Symlinking Zsh configuration..."
ln -sf "$ZSH_CONFIG_DIR/.zshrc" "$HOME/.zshrc"

print_success "Zsh setup complete!"

