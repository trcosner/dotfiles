#!/usr/bin/env bash
set -e

source ./utils.sh

print_info "Checking for Python 3..."

if command -v python3 &>/dev/null; then
  print_success "Python 3 is already installed: $(python3 --version)"
else
  print_info "Installing Python 3 via Homebrew..."
  brew install python
  print_success "Python 3 installed successfully."
fi

print_info "Installing pipx for global Python CLI tools..."
if ! command -v pipx &>/dev/null; then
  brew install pipx
  pipx ensurepath
  print_success "pipx installed and PATH ensured."
else
  print_success "pipx already installed."
fi

print_info "Validating 'venv' functionality (built-in virtual environment)..."
TEST_VENV_PATH="./.dotfiles-venv-test"
python3 -m venv "$TEST_VENV_PATH"
if [[ -f "$TEST_VENV_PATH/bin/activate" ]]; then
  print_success "venv is working. Cleaning up test venv..."
  rm -rf "$TEST_VENV_PATH"
else
  print_error "venv is not working correctly. Please investigate."
  exit 1
fi

