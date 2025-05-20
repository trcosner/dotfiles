#!/usr/bin/env bash

set -e

source ./utils.sh
verify_homebrew_installed

print_info "Checking for Hyperkey..."
hyperkey_installed=false

if ! brew list --cask hyperkey &> /dev/null; then
  print_info "Hyperkey not found. Installing via Homebrew..."
  if brew install --cask hyperkey; then
    print_success "Hyperkey successfully installed."
    hyperkey_installed=true
  else
    print_error "Failed to install Hyperkey."
    exit 1
  fi
else
  print_success "Hyperkey is already installed."
fi

# Define paths
CONFIG_DIR="$HOME/Library/Application Support/Hyperkey"
CONFIG_FILE="$CONFIG_DIR/config.json"
DOTFILES_CONFIG="$HOME/.dotfiles/hyperkey/config.json"

# Ensure config directory exists
mkdir -p "$CONFIG_DIR"

# Remove existing config file if not a symlink
if [ -e "$CONFIG_FILE" ] && [ ! -L "$CONFIG_FILE" ]; then
  rm "$CONFIG_FILE"
fi

# Symlink the config file from dotfiles
ln -sf "$DOTFILES_CONFIG" "$CONFIG_FILE"
print_success "Hyperkey configuration linked from dotfiles."

# Restart Hyperkey only if it was freshly installed
if $hyperkey_installed; then
  print_info "Launching Hyperkey for the first time..."
  if ! open -a "Hyperkey"; then
    print_warning "Default launch failed. Trying fallback location..."
    APP_PATH=$(find /opt/homebrew/Caskroom/hyperkey -maxdepth 1 -type d -name "[0-9]*" | sort -V | tail -1)
    if [ -n "$APP_PATH" ] && [ -d "$APP_PATH/Hyperkey.app" ]; then
      open "$APP_PATH/Hyperkey.app" && print_success "Hyperkey launched from fallback path." || print_error "Fallback Hyperkey launch failed."
    else
      print_error "Could not find Hyperkey.app in any known location."
    fi
  fi
fi

