#!/usr/bin/env bash
set -e

source ./utils.sh

print_success "Installing jankyborders (FelixKratz/borders)..."

# Ensure Xcode CLT is installed
if ! xcode-select -p &>/dev/null; then
  print_success "Installing Xcode Command Line Tools..."
  xcode-select --install
fi

# Tap and install the correct formula
if ! brew list borders &>/dev/null; then
  brew tap FelixKratz/formulae
  brew install felixkratz/formulae/borders
else
  print_success "borders (jankyborders) already installed."
fi

# Make sure the source file exists and is executable
if [ -f "$HOME/.dotfiles/jankyborders/bordersrc" ]; then
  chmod +x "$HOME/.dotfiles/jankyborders/bordersrc"
else
  print_error "Missing bordersrc in ~/.dotfiles/jankyborders/"
  exit 1
fi

# Ensure config directory exists and symlink the config
mkdir -p "$HOME/.config/borders"
ln -sf "$HOME/.dotfiles/jankyborders/bordersrc" "$HOME/.config/borders/bordersrc"

# Restart the borders process
brew services restart borders

print_success "jankyborders (borders) setup complete!"

