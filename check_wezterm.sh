#!/bin/bash

set -e  # Exit on error

# Import your custom print functions
source ./utils.sh

# Step 1: Check for Homebrew and install if not present
if ! command -v brew &>/dev/null; then
  print_error "Homebrew not found. Please install Homebrew first."
  exit 1
else
  print_success "Homebrew found."
fi

# Step 2: Install WezTerm using Homebrew if not already installed
if ! brew list --cask wezterm &>/dev/null; then
  print_success  "Installing WezTerm..."
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
if [ ! -d "$DOTFILES_DIR" ]; then
  print_success "Creating WezTerm config directory: $DOTFILES_DIR"
  mkdir -p "$DOTFILES_DIR"
else
  print_success "WezTerm config directory already exists."
fi

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
  print_success "Creating symlink from $DOTFILES_DIR/wezterm.lua to ~/.wezterm.lua"
  ln -sf "$CONFIG_FILE" "$HOME/.wezterm.lua"
  print_success "Symlink created."
else
  print_success "Symlink already exists: ~/.wezterm.lua -> $CONFIG_FILE"
fi

# Step 6: Launch WezTerm to verify
print_success "Launching WezTerm..."
open -a wezterm || print_error "Failed to launch WezTerm."

print_success "WezTerm setup complete!"

