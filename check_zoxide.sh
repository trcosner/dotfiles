#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for Zsh..."
if ! command -v zsh &> /dev/null; then
  print_error "Zsh not found. Installing via Homebrew..."
  brew install zsh || print_error "Failed to install Zsh."
else
  print_success "Zsh already installed."
fi

print_success "Checking for Zoxide..."
if ! command -v zoxide &> /dev/null; then
  print_success "Zoxide not found. Installing via Homebrew..."
  brew install zoxide || print_error "Failed to install Zoxide."
else
  print_success "Zoxide already installed."
fi

print_success "Updating .zshrc for Zoxide..."

# Check if .zshrc already includes Zoxide configuration
if ! grep -q "zoxide init" ~/.zshrc; then
  print_success "Adding Zoxide configuration to .zshrc..."
  {
    echo ''
    echo '# Zoxide configuration'
    echo 'eval "$(zoxide init zsh)"'
    echo ''
    echo '# Alias to make cd behave like z'
    echo 'alias cd="z"'
  } >> ~/.zshrc
  print_success "Zoxide configuration and alias added to .zshrc."
else
  print_success "Zoxide already configured in .zshrc."
fi

print_success "Reloading .zshrc to apply changes..."
zsh -c "source ~/.zshrc"

print_success "Zoxide setup complete!"
echo "You can now use Zoxide for fast directory navigation."
echo "Use 'cd' as an alias for 'z'."
