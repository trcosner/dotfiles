#!/usr/bin/env bash

set -e
source ./utils.sh

TOOL_NAME="AWS CLI"

if command -v aws &> /dev/null; then
    print_success "$TOOL_NAME is already installed"
    aws --version
else
    print_info "Installing $TOOL_NAME..."
    
    if command -v brew &> /dev/null; then
        brew install awscli
    else
        print_error "Homebrew not found. Please install Homebrew first."
        exit 1
    fi
    
    if command -v aws &> /dev/null; then
        print_success "$TOOL_NAME installed successfully"
        aws --version
    else
        print_error "Failed to install $TOOL_NAME"
        exit 1
    fi
fi

# Symlink AWS config if it exists
if [ -f "./config/aws/config" ]; then
    print_info "Setting up AWS config symlink..."
    mkdir -p ~/.aws
    
    if [ -L ~/.aws/config ]; then
        print_info "AWS config symlink already exists"
    elif [ -f ~/.aws/config ]; then
        print_warning "AWS config file exists but is not a symlink. Backing up..."
        mv ~/.aws/config ~/.aws/config.backup
        ln -sf "$(pwd)/config/aws/config" ~/.aws/config
        print_success "AWS config symlinked (original backed up)"
    else
        ln -sf "$(pwd)/config/aws/config" ~/.aws/config
        print_success "AWS config symlinked"
    fi
fi

# Symlink AWS credentials template if it exists
if [ -f "./config/aws/credentials.template" ]; then
    print_info "AWS credentials template found"
    if [ ! -f ~/.aws/credentials ]; then
        print_info "No credentials file found. You can copy the template:"
        print_info "cp $(pwd)/config/aws/credentials.template ~/.aws/credentials"
        print_info "Then edit ~/.aws/credentials with your actual AWS credentials"
    fi
fi

print_success "$TOOL_NAME setup complete"