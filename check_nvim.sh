#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
  print_error "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || print_error "Failed to install Homebrew."
  print_error "Homebrew installation initiated. Please complete the installation manually if required. Exiting script."
  exit 1
else
  print_success "Homebrew already installed."
fi

print_success "Checking for Neovim..."

# Check if Neovim is installed and up-to-date
if brew list neovim &> /dev/null; then
  current_version=$(brew info neovim --json | jq -r '.[0].installed[0].version')
  latest_version=$(brew info neovim --json | jq -r '.[0].versions.stable')
  if [ "$current_version" == "$latest_version" ]; then
    print_success "Neovim is already installed and up-to-date (version $current_version)."
  else
    print_error "Neovim is installed but not up-to-date (current: $current_version, latest: $latest_version)."
    print_success "Updating Neovim..."
    if brew upgrade neovim; then
      print_success "Neovim successfully updated to version $latest_version."
    else
      print_error "Failed to update Neovim."
      exit 1
    fi
  fi
else
  print_success "Neovim not found. Installing via Homebrew..."
  if brew install neovim; then
    print_success "Neovim successfully installed."
  else
    print_error "Failed to install Neovim."
    exit 1
  fi
fi

# Neovim configuration symlink
DOTFILES_CONFIG_DIR="$HOME/.dotfiles/nvim"
NVIM_CONFIG_DIR="$HOME/.config/nvim"

print_success "Setting up Neovim configuration..."

# Create the Neovim config directory if not exists
if [ ! -d "$DOTFILES_CONFIG_DIR" ]; then
  print_error "Dotfiles Neovim config directory not found at $DOTFILES_CONFIG_DIR."
  print_error "Please ensure your configuration exists and rerun the script."
  exit 1
fi

# Remove existing config and create a symlink
if [ -d "$NVIM_CONFIG_DIR" ] || [ -L "$NVIM_CONFIG_DIR" ]; then
  print_error "Removing existing Neovim configuration..."
  rm -rf "$NVIM_CONFIG_DIR"
fi

print_success "Creating symlink from dotfiles to Neovim config directory..."
ln -sf "$DOTFILES_CONFIG_DIR" "$NVIM_CONFIG_DIR"

if [ -L "$NVIM_CONFIG_DIR" ]; then
  print_success "Neovim configuration successfully symlinked from $DOTFILES_CONFIG_DIR."
else
  print_error "Failed to symlink Neovim configuration."
  exit 1
fi


print_success "Neovim setup complete! Run 'nvim' to start."
