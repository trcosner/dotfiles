#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
  print_warning "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || print_error "Failed to install Homebrew."
  print_error "Homebrew installation initiated. Please complete the installation manually if required. Exiting script."
  exit 1
else
  print_success "Homebrew already installed."
fi

print_success "Checking for eza..."
if command -v eza &> /dev/null; then
  print_success "eza is already installed."
else
  print_success "eza not found. Installing via Homebrew..."
  if brew install eza; then
    print_success "eza successfully installed."
  else
    print_error "Failed to install eza."
    exit 1
  fi
fi

# Add eza alias to .zshrc if not already present
ZSHRC_PATH="$HOME/.zshrc"
EZA_ALIAS="alias ls='eza -alF --icons'"

print_success "Checking if eza alias is already in .zshrc..."
if ! grep -qxF "$EZA_ALIAS" "$ZSHRC_PATH"; then
  echo "$EZA_ALIAS" >> "$ZSHRC_PATH"
  print_success "Added eza alias to $ZSHRC_PATH."
else
  print_success "eza alias already configured in $ZSHRC_PATH."
fi

print_success "Installation complete! Restart your terminal or run 'exec zsh' to apply changes."
