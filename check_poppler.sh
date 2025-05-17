#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for Poppler..."
if ! command -v pdftotext &> /dev/null; then
  print_success "Poppler not found. Installing via Homebrew..."
  brew install poppler || print_error "Failed to install Poppler."
else
  print_success "Poppler already installed."
fi

