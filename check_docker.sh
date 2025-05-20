#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for Docker..."
if ! command -v docker &> /dev/null; then
  print_info "Docker not found. Installing Docker Desktop via Homebrew..."
  brew install --cask docker || {
    print_error "Failed to install Docker Desktop."
    exit 1
  }
  print_success "Docker Desktop installed successfully."
else
  print_success "Docker is already installed."
fi

# Start Docker Desktop if not running
print_info "Checking if Docker Desktop is running..."
if ! pgrep -x "Docker" > /dev/null; then
  print_info "Starting Docker Desktop..."
  open -a Docker || {
    print_error "Failed to start Docker Desktop."
    exit 1
  }
  print_success "Docker Desktop started."
else
  print_success "Docker Desktop is already running."
fi

print_success "Docker setup complete!"

