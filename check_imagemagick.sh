#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for ImageMagick..."
if ! command -v magick &> /dev/null; then
  print_success "ImageMagick not found. Installing via Homebrew..."
  brew install imagemagick || print_error "Failed to install ImageMagick."
else
  print_success "ImageMagick already installed."
fi

