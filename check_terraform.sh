#!/usr/bin/env bash

set -e

source ./utils.sh

verify_homebrew_installed

# Install Terraform
print_info "Checking for Terraform..."
if ! command -v terraform &> /dev/null; then
  print_info "Terraform not found. Installing via Homebrew..."
  brew install terraform || {
    print_error "Failed to install Terraform."
    exit 1
  }
  print_success "Terraform installed successfully."
else
  print_success "Terraform already installed."
fi

# Verify Terraform installation
print_info "Verifying Terraform installation..."
terraform_version=$(terraform version 2>/dev/null | head -n 1)
if [ -n "$terraform_version" ]; then
  print_success "Terraform version: $terraform_version"
else
  print_error "Failed to verify Terraform installation."
  exit 1
fi

# Install Terragrunt
print_info "Checking for Terragrunt..."
if ! command -v terragrunt &> /dev/null; then
  print_info "Terragrunt not found. Installing via Homebrew..."
  brew install terragrunt || {
    print_error "Failed to install Terragrunt."
    exit 1
  }
  print_success "Terragrunt installed successfully."
else
  print_success "Terragrunt already installed."
fi

# Verify Terragrunt installation
print_info "Verifying Terragrunt installation..."
terragrunt_version=$(terragrunt --version 2>/dev/null)
if [ -n "$terragrunt_version" ]; then
  print_success "Terragrunt version: $terragrunt_version"
else
  print_error "Failed to verify Terragrunt installation."
  exit 1
fi

# Install terraform-docs
print_info "Checking for terraform-docs..."
if ! command -v terraform-docs &> /dev/null; then
  print_info "terraform-docs not found. Installing via Homebrew..."
  brew install terraform-docs || {
    print_error "Failed to install terraform-docs."
    exit 1
  }
  print_success "terraform-docs installed successfully."
else
  print_success "terraform-docs already installed."
fi

# Verify terraform-docs installation
print_info "Verifying terraform-docs installation..."
terraform_docs_version=$(terraform-docs version 2>/dev/null)
if [ -n "$terraform_docs_version" ]; then
  print_success "terraform-docs version: $terraform_docs_version"
else
  print_error "Failed to verify terraform-docs installation."
  exit 1
fi

print_success "Terraform, Terragrunt, and terraform-docs setup complete!"
