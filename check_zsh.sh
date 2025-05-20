#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for Zsh..."
# Check if Zsh is installed via Homebrew
if [ -x "/opt/homebrew/bin/zsh" ] || [ -x "/usr/local/bin/zsh" ]; then
  print_success "Zsh installed via Homebrew."
else
  print_warning "Zsh not found via Homebrew. Installing with Homebrew..."
  brew install zsh || print_error "Failed to install Zsh."
fi

# Add Homebrew Zsh to /etc/shells if not present
if ! grep -q "/bin/zsh" /etc/shells; then
  print_info "Adding Homebrew Zsh to /etc/shells..."
  echo "/bin/zsh" | sudo tee -a /etc/shells
fi

# Change default shell to Homebrew Zsh
if [ "$SHELL" != "/bin/zsh" ]; then
  print_info "Changing default shell to Homebrew Zsh..."
  chsh -s /bin/zsh
fi

# Symlink Zsh configuration
ZSH_CONFIG_DIR="$HOME/.dotfiles/zsh"
if [ ! -d "$ZSH_CONFIG_DIR" ]; then
  mkdir -p "$ZSH_CONFIG_DIR"
fi

print_info "Symlinking Zsh configuration..."
ln -sf "$ZSH_CONFIG_DIR/.zshrc" "$HOME/.zshrc"

print_info "Installing zsh-autosuggestions and zsh-syntax-highlighting..."

# Install zsh-autosuggestions
if ! brew list zsh-autosuggestions &> /dev/null; then
  if brew install zsh-autosuggestions; then
    print_success "zsh-autosuggestions installed successfully."
  else
    print_error "Failed to install zsh-autosuggestions."
    exit 1
  fi
else
  print_success "zsh-autosuggestions already installed."
fi

# Install zsh-syntax-highlighting
print_info "installing zsh syntax highlighting"
if ! brew list zsh-syntax-highlighting &> /dev/null; then
  if brew install zsh-syntax-highlighting; then
    print_success "zsh-syntax-highlighting installed successfully."
  else
    print_error "Failed to install zsh-syntax-highlighting."
    exit 1
  fi
else
  print_success "zsh-syntax-highlighting already installed."
fi

print_success "Zsh setup complete!"

