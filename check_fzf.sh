#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for FZF..."
if ! command -v fzf &> /dev/null; then
  print_info "FZF not found. Installing via Homebrew..."
  brew install fzf || print_error "Failed to install FZF."

  print_info "Setting up FZF key bindings and shell completion..."
  "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc

  print_success "FZF installed and configured."
  fzf_version=$(fzf --version)
  print_success "FZF version: $fzf_version"
else
  print_success "FZF already installed."
fi

