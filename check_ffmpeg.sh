#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for FFmpeg..."
if ! command -v ffmpeg &> /dev/null; then
  print_success "FFmpeg not found. Installing via Homebrew..."
  brew install ffmpeg || print_error "Failed to install FFmpeg."
else
  print_success "FFmpeg already installed."
fi

