#!/usr/bin/env bash

set -e

# Load utility functions
source ./utils.sh

print_success "Starting Hyperkey setup..."

print_success "Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
  print_error "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || print_error "Failed to install Homebrew."
  print_error "Homebrew installation initiated. Please complete the installation manually if required. Exiting script."
  exit 1
else
  print_success "Homebrew already installed."
fi

print_success "Checking for Hyperkey..."
if ! brew list --cask hyperkey &> /dev/null; then
  print_success "Hyperkey not found. Installing via Homebrew..."

  # Install Hyperkey without sudo
  if brew install --cask hyperkey; then
    print_success "Hyperkey successfully installed."
  else
    print_error "Failed to install Hyperkey."
    exit 1
  fi
else
  print_success "Hyperkey already installed."
fi

print_success "Verifying Hyperkey installation..."
if brew list --cask | grep -q "^hyperkey\$"; then
  print_success "Hyperkey is installed via Homebrew."
else
  print_error "Hyperkey installation verification failed. Please check manually."
  exit 1
fi

print_success "Configuring Hyperkey to use Caps Lock..."

CONFIG_DIR="$HOME/Library/Application Support/Hyperkey"
CONFIG_FILE="$CONFIG_DIR/config.json"

# Create configuration directory if not exists
mkdir -p "$CONFIG_DIR"

# Write the configuration file to set Caps Lock as a Hyperkey
cat > "$CONFIG_FILE" <<EOF
{
    "mappings": {
        "caps_lock": {
            "hyper": true,
            "modifiers": ["command", "control", "option", "shift"]
        }
    }
}
EOF

print_success "Hyperkey configuration created at $CONFIG_FILE."

print_success "Restarting Hyperkey to apply changes..."
pkill Hyperkey || print_error "Hyperkey was not running."
open -a "Hyperkey" || print_error "Failed to launch Hyperkey."

print_success "Hyperkey setup complete!"
echo "You can open Hyperkey from your Applications folder or by running 'open -a Hyperkey'."
