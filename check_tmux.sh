#!/usr/bin/env bash

set -e

# Load utility functions
source ./utils.sh

verify_homebrew_installed
verify_git_installed

print_info "Installing Tmux and TPM..."

# --- Tmux Installation ---
if ! command -v tmux &> /dev/null; then
  print_info "Tmux not found. Installing via Homebrew..."
  brew install tmux || {
    print_error "Failed to install Tmux."
    exit 1
  }
  print_success "Tmux installed."
else
  print_success "Tmux already installed."
fi

# --- Symlink Configuration ---
DOTFILES_DIR="$HOME/.dotfiles"
TMUX_CONFIG_FILE="$DOTFILES_DIR/tmux/.tmux.conf"
TARGET_CONFIG_FILE="$HOME/.tmux.conf"

ln -sf "$TMUX_CONFIG_FILE" "$TARGET_CONFIG_FILE"
print_success "Symlinked Tmux config: $TARGET_CONFIG_FILE → $TMUX_CONFIG_FILE"

# --- TPM Installation ---
TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ ! -d "$TPM_DIR" ]; then
  print_info "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR" || {
    print_error "Failed to clone TPM."
    exit 1
  }
  print_success "TPM installed at $TPM_DIR."
else
  print_success "TPM already installed."
fi

print_info "Skipping tmux config reload — run 'tmux' and press <prefix> + I to finish setup."

print_success "Tmux and TPM setup complete!"

