#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for Neovim..."

if brew list neovim &> /dev/null; then
  current_version=$(brew info neovim --json | jq -r '.[0].installed[0].version')
  latest_version=$(brew info neovim --json | jq -r '.[0].versions.stable')

  if [ "$current_version" == "$latest_version" ]; then
    print_success "Neovim is already up-to-date (version $current_version)."
  else
    print_info "Neovim is outdated (current: $current_version, latest: $latest_version). Updating..."
    brew upgrade neovim || {
      print_error "Failed to update Neovim."
      exit 1
    }
    print_success "Neovim updated to version $latest_version."
  fi
else
  print_info "Neovim not found. Installing..."
  brew install neovim || {
    print_error "Failed to install Neovim."
    exit 1
  }
  print_success "Neovim installed successfully."
fi

# --- Symlink Configuration ---
DOTFILES_CONFIG_DIR="$HOME/.dotfiles/nvim"
NVIM_CONFIG_DIR="$HOME/.config/nvim"

print_info "Linking Neovim configuration..."

if [ ! -d "$DOTFILES_CONFIG_DIR" ]; then
  print_error "Missing config directory: $DOTFILES_CONFIG_DIR"
  exit 1
fi

rm -rf "$NVIM_CONFIG_DIR"
ln -sf "$DOTFILES_CONFIG_DIR" "$NVIM_CONFIG_DIR"

print_success "Neovim configuration symlinked to $NVIM_CONFIG_DIR."
print_success "Neovim setup complete! Run 'nvim' to start."

