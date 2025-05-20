#!/usr/bin/env bash
set -e

source ./utils.sh

print_info "Setting up jankyborders (FelixKratz/borders)..."

verify_homebrew_installed

CONFIG_SOURCE="$HOME/.dotfiles/jankyborders/bordersrc"
CONFIG_DEST="$HOME/.config/borders/bordersrc"

borders_installed=false
config_updated=false

# Install borders if not already installed
if ! brew list borders &>/dev/null; then
  print_info "Installing borders via Homebrew..."
  brew tap FelixKratz/formulae
  brew install felixkratz/formulae/borders
  print_success "borders (jankyborders) installed successfully."
  borders_installed=true
else
  print_success "borders (jankyborders) already installed."
fi

# Ensure bordersrc exists and is executable
if [ -f "$CONFIG_SOURCE" ]; then
  chmod +x "$CONFIG_SOURCE"
else
  print_error "Missing bordersrc at $CONFIG_SOURCE"
  exit 1
fi

# Ensure config directory exists
mkdir -p "$(dirname "$CONFIG_DEST")"

# Create or update symlink if necessary
if [ ! -L "$CONFIG_DEST" ] || [ "$(readlink "$CONFIG_DEST")" != "$CONFIG_SOURCE" ]; then
  ln -sf "$CONFIG_SOURCE" "$CONFIG_DEST"
  print_success "Symlinked bordersrc to $CONFIG_DEST."
  config_updated=true
else
  print_success "bordersrc symlink already in place."
fi

# Restart only if something changed
if $borders_installed || $config_updated; then
  print_info "Restarting borders service to apply changes..."
  brew services restart borders
else
  print_info "No changes made — skipping borders restart."
fi

print_success "jankyborders setup complete!"

