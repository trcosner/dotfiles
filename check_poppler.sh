#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for Poppler (pdftotext)..."
if ! command -v pdftotext &> /dev/null; then
  print_info "Poppler not found. Installing via Homebrew..."
  brew install poppler || {
    print_error "Failed to install Poppler."
    exit 1
  }
  print_success "Poppler installed successfully."
  poppler_version=$(pdftotext -v 2>&1 | head -n 1)
  print_success "Poppler version: $poppler_version"
else
  print_success "Poppler already installed."
fi

