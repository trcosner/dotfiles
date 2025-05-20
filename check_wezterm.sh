#!/usr/bin/env bash

set -e  # Exit on error

source ./utils.sh

verify_homebrew_installed

# Step 2: Install WezTerm using Homebrew if not already installed
if ! brew list --cask wezterm &>/dev/null; then
  print_info  "Installing WezTerm..."
  if brew install --cask wezterm; then
    print_success "WezTerm installed successfully."
  else
    print_error "Failed to install WezTerm."
    exit 1
  fi
else
  print_success "WezTerm is already installed."
fi

# Step 3: Ensure the dotfiles directory structure exists
DOTFILES_DIR="$HOME/.dotfiles/wezterm"

# Step 4: Copy the Lua configuration file from your dotfiles repository
CONFIG_FILE="$DOTFILES_DIR/wezterm.lua"
if [ ! -f "$CONFIG_FILE" ]; then
  print_error "WezTerm configuration file not found at $CONFIG_FILE."
  exit 1
else
  print_success "WezTerm configuration file found."
fi

# Step 5: Create a symlink to the custom configuration in the WezTerm expected location
if [ ! -L "$HOME/.wezterm.lua" ]; then
  print_info "Creating symlink from $DOTFILES_DIR/wezterm.lua to ~/.wezterm.lua"
  ln -sf "$CONFIG_FILE" "$HOME/.wezterm.lua"
  print_success "Symlink created."
else
  print_success "Symlink already exists: ~/.wezterm.lua -> $CONFIG_FILE"
fi

# Step 6: Launch WezTerm to verify
print_info "Launching WezTerm..."
open -a wezterm || print_error "Failed to launch WezTerm."

print_success "WezTerm setup complete!"

