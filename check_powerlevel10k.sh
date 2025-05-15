#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for Zsh..."
if ! command -v zsh &> /dev/null; then
  print_warning "Zsh not found. Installing via Homebrew..."
  if brew install zsh; then
    print_success "Zsh successfully installed."
  else
    print_error "Failed to install Zsh."
    exit 1
  fi
else
  print_success "Zsh already installed."
fi

print_success "Checking for Powerlevel10k..."

# Check if Powerlevel10k is installed and up-to-date
if brew list powerlevel10k &> /dev/null; then
  current_version=$(brew info powerlevel10k --json | jq -r '.[0].installed[0].version')
  latest_version=$(brew info powerlevel10k --json | jq -r '.[0].versions.stable')
  if [ "$current_version" == "$latest_version" ]; then
    print_success "Powerlevel10k is already installed and up-to-date (version $current_version)."
  else
    print_warning "Powerlevel10k is installed but not up-to-date (current: $current_version, latest: $latest_version)."
    print_success "Updating Powerlevel10k..."
    if brew upgrade powerlevel10k; then
      print_success "Powerlevel10k successfully updated to version $latest_version."
    else
      print_error "Failed to update Powerlevel10k."
      exit 1
    fi
  fi
else
  print_success "Installing Powerlevel10k..."
  if brew install romkatv/powerlevel10k/powerlevel10k; then
    print_success "Powerlevel10k successfully installed."
  else
    print_error "Failed to install Powerlevel10k."
    exit 1
  fi
fi

# Path to your custom .zshrc file and predefined config
ZSHRC_PATH="$HOME/.dotfiles/zsh/.zshrc"
P10K_CONFIG_PATH="$HOME/.dotfiles/zsh/.p10k.zsh"

print_success "Updating $ZSHRC_PATH to use Powerlevel10k..."
if ! grep -q 'source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme' "$ZSHRC_PATH"; then
  echo "source \$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >> "$ZSHRC_PATH"
  print_success "Updated $ZSHRC_PATH with Powerlevel10k theme."
else
  print_success "$ZSHRC_PATH already configured for Powerlevel10k."
fi

# Ensure the predefined .p10k.zsh file exists
if [ -f "$P10K_CONFIG_PATH" ]; then
  print_success "Using predefined configuration from $P10K_CONFIG_PATH"
  ln -sf "$P10K_CONFIG_PATH" ~/.p10k.zsh
  print_success "Linked preconfigured .p10k.zsh to home directory."
else
  print_error "Predefined configuration not found at $P10K_CONFIG_PATH."
  print_error "Please create the config manually or place it in your dotfiles directory."
  exit 1
fi

print_success "Installation complete! Restart your terminal or run 'exec zsh' to apply changes."
