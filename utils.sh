#!/usr/bin/env bash

print_success() {
  local GREEN="\033[0;32m"
  local NC="\033[0m"
  echo -e "${GREEN}$1${NC}"
}

print_error() {
  local RED="\033[0;31m"
  local NC="\033[0m"
  echo -e "${RED}$1${NC}"
}

print_warning() {
  local YELLOW="\033[0;33m"
  local NC="\033[0m"
  echo -e "${YELLOW}$1${NC}"
}

print_info() {
  local BLUE="\033[0;34m"
  local NC="\033[0m"
  echo -e "${BLUE}$1${NC}"
}

verify_homebrew_installed() {
  if ! command -v brew &> /dev/null; then
    print_warning "Homebrew not found. Attempting installation..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
      print_error "Failed to install Homebrew."
      print_error "Manual installation may be required: https://brew.sh"
      exit 1
    }
    print_success "Homebrew installed successfully."
  fi
}

verify_git_installed() {
  print_info "Checking for Git..."
  if ! command -v git &> /dev/null; then
    print_info "Git not found. Installing via Homebrew..."
    if brew install git; then
      print_success "Git successfully installed."
    else
      print_error "Failed to install Git."
      exit 1
    fi
  else
    print_success "Git already installed."
  fi
}

