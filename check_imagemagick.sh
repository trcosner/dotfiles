#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for ImageMagick..."
if ! command -v magick &> /dev/null; then
  print_info "ImageMagick not found. Installing via Homebrew..."
  brew install imagemagick || {
    print_error "Failed to install ImageMagick."
    exit 1
  }
  print_success "ImageMagick installed successfully."
  magick_version=$(magick --version | head -n 1)
  print_success "ImageMagick version: $magick_version"
else
  print_success "ImageMagick already installed."
fi

