#!/usr/bin/env bash

set -e

# Load utility functions
source ./utils.sh

print_success "Starting Tmux and TPM setup..."

print_success "Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
  print_error "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || print_error "Failed to install Homebrew."
  print_error "Homebrew installation initiated. Please complete the installation manually if required. Exiting script."
  exit 1
else
  print_success "Homebrew already installed."
fi

print_success "Checking for Git..."
if ! command -v git &> /dev/null; then
  print_success "Git not found. Installing via Homebrew..."
  if brew install git; then
    print_success "Git successfully installed."
  else
    print_error "Failed to install Git."
    exit 1
  fi
else
  print_success "Git already installed."
fi

print_success "Checking for Tmux..."
if ! brew list tmux &> /dev/null; then
  print_success "Tmux not found. Installing via Homebrew..."
  if brew install tmux; then
    print_success "Tmux successfully installed."
  else
    print_error "Failed to install Tmux."
    exit 1
  fi
else
  print_success "Tmux already installed."
fi

print_success "Verifying Tmux installation..."
if command -v tmux &> /dev/null; then
  print_success "Tmux is correctly installed."
else
  print_error "Tmux installation verification failed. Please check manually."
  exit 1
fi

print_success "Configuring Tmux..."

# Configuration directories
DOTFILES_DIR="$HOME/.dotfiles"
TMUX_CONFIG_DIR="$DOTFILES_DIR/tmux"
TMUX_CONFIG_FILE="$TMUX_CONFIG_DIR/.tmux.conf"
TARGET_CONFIG_FILE="$HOME/.tmux.conf"

# Check if the custom configuration exists in .dotfiles
if [ -f "$TMUX_CONFIG_FILE" ]; then
  print_success "Found Tmux configuration in $TMUX_CONFIG_FILE."
else
  print_error "Tmux configuration not found in $TMUX_CONFIG_FILE. Please add your .tmux.conf to $TMUX_CONFIG_DIR."
  exit 1
fi

# Symlink the Tmux configuration
if [ -L "$TARGET_CONFIG_FILE" ]; then
  print_success "Tmux configuration symlink already exists."
  if [ "$(readlink "$TARGET_CONFIG_FILE")" != "$TMUX_CONFIG_FILE" ]; then
    print_success "Updating existing symlink to point to $TMUX_CONFIG_FILE."
    ln -sf "$TMUX_CONFIG_FILE" "$TARGET_CONFIG_FILE"
    print_success "Updated symlink for Tmux configuration."
  else
    print_success "Symlink already points to the correct configuration."
  fi
else
  ln -sf "$TMUX_CONFIG_FILE" "$TARGET_CONFIG_FILE"
  print_success "Symlinked Tmux configuration: $TARGET_CONFIG_FILE -> $TMUX_CONFIG_FILE"
fi

print_success "Checking for Tmux Plugin Manager (TPM)..."
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  print_success "TPM not found. Installing..."
  if git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"; then
    print_success "TPM successfully installed at $TPM_DIR."
  else
    print_error "Failed to install TPM."
    exit 1
  fi
else
  print_success "TPM already installed."
fi

print_success "Ensuring TPM is correctly referenced in Tmux config..."
if ! grep -q "run -b '~/.tmux/plugins/tpm/tpm'" "$TMUX_CONFIG_FILE"; then
  echo "run -b '~/.tmux/plugins/tpm/tpm'" >> "$TMUX_CONFIG_FILE"
  print_success "Added TPM initialization to Tmux configuration."
fi

print_success "Restarting Tmux to apply changes..."
if tmux ls &> /dev/null; then
  tmux source-file "$TARGET_CONFIG_FILE"
  print_success "Tmux configuration reloaded."
else
  print_success "Tmux is not currently running. Start Tmux using 'tmux' to apply the configuration."
fi

print_success "Tmux and TPM setup complete!"
echo "You can customize your Tmux configuration at: $TMUX_CONFIG_FILE"

