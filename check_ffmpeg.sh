#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

print_info "Checking for FFmpeg..."
if ! command -v ffmpeg &> /dev/null; then
  print_info "FFmpeg not found. Installing via Homebrew..."
  brew install ffmpeg || {
    print_error "Failed to install FFmpeg."
    exit 1
  }
  print_success "FFmpeg installed successfully."
else
  print_success "FFmpeg already installed."
fi

