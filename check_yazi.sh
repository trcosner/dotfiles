#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for Yazi..."
if ! command -v yazi &> /dev/null; then
  print_success "Yazi not found. Installing via Homebrew..."
  brew install yazi || print_error "Failed to install Yazi."
else
  print_success "Yazi already installed."
fi

print_success "Verifying Yazi installation..."
yazi_version=$(yazi --version)

if [ -n "$yazi_version" ]; then
  print_success "Yazi version: $yazi_version"
else
  print_error "Failed to verify Yazi installation."
fi

print_success "Setting up Yazi configuration..."

# Yazi config directory
CONFIG_DIR="$HOME/.config/yazi"

# Create config directory if it doesn't exist
if [ ! -d "$CONFIG_DIR" ]; then
  print_success "Creating Yazi configuration directory..."
  mkdir -p "$CONFIG_DIR"
fi

# Symlink configuration files
for file in yazi.toml keymap.toml theme.toml; do
  if [ -L "$CONFIG_DIR/$file" ]; then
    print_success "Removing existing symlink for $file..."
    rm "$CONFIG_DIR/$file"
  elif [ -f "$CONFIG_DIR/$file" ]; then
    print_warning "$file exists and is not a symlink. Backing up to $file.bak..."
    mv "$CONFIG_DIR/$file" "$CONFIG_DIR/$file.bak"
  fi
  print_success "Creating symlink for $file..."
  ln -s "$HOME/.dotfiles/yazi/$file" "$CONFIG_DIR/$file"
done

print_success "Yazi setup complete!"

