#!/usr/bin/env bash

set -e
source ./utils.sh

TOOL_NAME="watch"

if command -v watch &> /dev/null; then
    print_success "$TOOL_NAME is already installed"
    watch --version
else
    print_info "Installing $TOOL_NAME..."
    
    if command -v brew &> /dev/null; then
        brew install watch
    else
        print_error "Homebrew not found. Please install Homebrew first."
        exit 1
    fi
    
    if command -v watch &> /dev/null; then
        print_success "$TOOL_NAME installed successfully"
        watch --version
    else
        print_error "Failed to install $TOOL_NAME"
        exit 1
    fi
fi

print_success "$TOOL_NAME setup complete"
