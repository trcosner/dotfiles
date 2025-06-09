#!/usr/bin/env bash

set -e
source ./utils.sh

TOOL_NAME="Helm"

if command -v helm &> /dev/null; then
    print_success "$TOOL_NAME is already installed"
    helm version
else
    print_info "Installing $TOOL_NAME..."
    
    if command -v brew &> /dev/null; then
        brew install helm
    else
        print_error "Homebrew not found. Please install Homebrew first."
        exit 1
    fi
    
    if command -v helm &> /dev/null; then
        print_success "$TOOL_NAME installed successfully"
        helm version
    else
        print_error "Failed to install $TOOL_NAME"
        exit 1
    fi
fi

print_success "$TOOL_NAME setup complete"
