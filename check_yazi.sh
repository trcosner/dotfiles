#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for Yazi..."
if ! command -v yazi &> /dev/null; then
  print_info "Yazi not found. Installing via Homebrew..."
  brew install yazi || {
    print_error "Failed to install Yazi."
    exit 1
  }
  print_success "Yazi installed successfully."
else
  print_success "Yazi already installed."
fi

# Verify version
print_info "Verifying Yazi installation..."
yazi_version=$(yazi --version 2>/dev/null || true)

if [ -n "$yazi_version" ]; then
  print_success "Yazi version: $yazi_version"
else
  print_error "Failed to verify Yazi installation."
  exit 1
fi

# Config setup
DOTFILES_YAZI_DIR="$HOME/.dotfiles/yazi"
CONFIG_DIR="$HOME/.config/yazi"

print_info "Setting up Yazi configuration..."
mkdir -p "$CONFIG_DIR"

for file in yazi.toml keymap.toml theme.toml; do
  target="$CONFIG_DIR/$file"
  source="$DOTFILES_YAZI_DIR/$file"

  if [ -L "$target" ]; then
    current_link=$(readlink "$target")
    if [ "$current_link" = "$source" ]; then
      print_success "$file symlink already correct."
      continue
    else
      print_info "Updating incorrect symlink for $file..."
      rm "$target"
    fi
  elif [ -f "$target" ]; then
    print_warning "$file exists and is not a symlink. Backing up to $file.bak..."
    mv "$target" "$target.bak"
  fi

  ln -s "$source" "$target"
  print_success "Symlinked $file → $source"
done

print_success "Yazi setup complete!"

