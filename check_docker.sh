#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for Docker..."
if ! command -v docker &> /dev/null; then
  print_success "Docker not found. Installing Docker Desktop via Homebrew..."
  brew install --cask docker || print_error "Failed to install Docker."
else
  print_success "Docker already installed."
fi

# Start Docker Desktop if not running
if ! pgrep -x "Docker" > /dev/null; then
  print_success "Starting Docker Desktop..."
  open -a Docker || print_error "Failed to start Docker Desktop."
else
  print_success "Docker Desktop is already running."
fi

print_success "Docker setup complete!"

