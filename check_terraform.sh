#!/usr/bin/env bash

set -e

source ./utils.sh

print_success "Checking for Terraform..."
if ! command -v terraform &> /dev/null; then
  print_success "Terraform not found. Installing via Homebrew..."
  brew install terraform || print_error "Failed to install Terraform."
else
  print_success "Terraform already installed."
fi

print_success "Verifying Terraform installation..."
terraform_version=$(terraform version | head -n 1)

if [ -n "$terraform_version" ]; then
  print_success "Terraform version: $terraform_version"
else
  print_error "Failed to verify Terraform installation."
fi

print_success "Terraform setup complete!"
