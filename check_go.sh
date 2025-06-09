#!/usr/bin/env bash

set -e
source ./utils.sh

TOOL_NAME="Go"

if command -v go &> /dev/null; then
    print_success "$TOOL_NAME is already installed"
    go version
else
    print_info "Installing $TOOL_NAME..."
    
    if command -v brew &> /dev/null; then
        brew install go
    else
        print_error "Homebrew not found. Please install Homebrew first."
        exit 1
    fi
    
    if command -v go &> /dev/null; then
        print_success "$TOOL_NAME installed successfully"
        go version
    else
        print_error "Failed to install $TOOL_NAME"
        exit 1
    fi
fi

print_success "$TOOL_NAME setup complete"
