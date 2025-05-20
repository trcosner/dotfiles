#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for Powerlevel10k..."

# Check if Powerlevel10k is installed and up-to-date
if brew list powerlevel10k &> /dev/null; then
  current_version=$(brew info powerlevel10k --json | jq -r '.[0].installed[0].version')
  latest_version=$(brew info powerlevel10k --json | jq -r '.[0].versions.stable')
  if [ "$current_version" == "$latest_version" ]; then
    print_success "Powerlevel10k is already installed and up-to-date (version $current_version)."
  else
    print_info "Updating Powerlevel10k..."
    if brew upgrade powerlevel10k; then
      print_success "Powerlevel10k successfully updated to version $latest_version."
    else
      print_error "Failed to update Powerlevel10k."
      exit 1
    fi
  fi
else
  print_info "Installing Powerlevel10k..."
  if brew install romkatv/powerlevel10k/powerlevel10k; then
    print_success "Powerlevel10k successfully installed."
  else
    print_error "Failed to install Powerlevel10k."
    exit 1
  fi
fi

print_success "Installation complete! Restart your terminal or run 'exec zsh' to apply changes."
