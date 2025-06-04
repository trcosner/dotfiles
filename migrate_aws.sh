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

# Check for existing AWS configuration and migrate if needed
if [ -d ~/.aws ]; then
    print_info "Found existing AWS configuration directory"
    
    # Handle existing config file
    if [ -f ~/.aws/config ] && [ ! -L ~/.aws/config ]; then
        print_info "Found existing AWS config file"
        
        # Create config directory if it doesn't exist
        mkdir -p "./config/aws"
        
        if [ -f "./config/aws/config" ]; then
            print_warning "Dotfiles AWS config already exists. Comparing with existing..."
            echo "=== Current ~/.aws/config ==="
            cat ~/.aws/config
            echo "=== Dotfiles config/aws/config ==="
            cat ./config/aws/config
            echo "=========================="
            read -p "Replace dotfiles config with current ~/.aws/config? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                cp ~/.aws/config ./config/aws/config
                print_success "Copied existing config to dotfiles"
            fi
        else
            print_info "Copying existing AWS config to dotfiles..."
            cp ~/.aws/config ./config/aws/config
            print_success "AWS config copied to dotfiles"
        fi
        
        # Backup and symlink
        print_info "Creating symlink for AWS config..."
        mv ~/.aws/config ~/.aws/config.backup
        ln -sf "$(pwd)/config/aws/config" ~/.aws/config
        print_success "AWS config symlinked (original backed up to ~/.aws/config.backup)"
    fi
    
    # Handle existing credentials file
    if [ -f ~/.aws/credentials ] && [ ! -L ~/.aws/credentials ]; then
        print_warning "Found existing AWS credentials file"
        print_info "Credentials contain sensitive data and won't be copied to dotfiles"
        print_info "Your existing credentials file will remain at ~/.aws/credentials"
        
        # Create credentials template if it doesn't exist
        if [ ! -f "./config/aws/credentials.template" ]; then
            print_info "Creating credentials template..."
            mkdir -p "./config/aws"
            cat > ./config/aws/credentials.template << 'EOF'
# Copy this file to ~/.aws/credentials and fill in your actual values
# DO NOT commit the actual credentials file to git

[default]
aws_access_key_id = YOUR_ACCESS_KEY_HERE
aws_secret_access_key = YOUR_SECRET_KEY_HERE

[dev]
aws_access_key_id = YOUR_DEV_ACCESS_KEY_HERE
aws_secret_access_key = YOUR_DEV_SECRET_KEY_HERE

[prod]
aws_access_key_id = YOUR_PROD_ACCESS_KEY_HERE
aws_secret_access_key = YOUR_PROD_SECRET_KEY_HERE
EOF
            print_success "Created credentials template"
        fi
    fi
else
    print_info "No existing AWS configuration found"
fi

# Set up config symlink if dotfiles config exists
if [ -f "./config/aws/config" ]; then
    print_info "Setting up AWS config symlink..."
    mkdir -p ~/.aws
    
    if [ -L ~/.aws/config ]; then
        print_info "AWS config symlink already exists"
    elif [ -f ~/.aws/config ]; then
        print_warning "AWS config file exists but is not a symlink. This was handled above."
    else
        ln -sf "$(pwd)/config/aws/config" ~/.aws/config
        print_success "AWS config symlinked"
    fi
fi

# Check for credentials template
if [ -f "./config/aws/credentials.template" ]; then
    print_info "AWS credentials template available"
    if [ ! -f ~/.aws/credentials ]; then
        print_info "No credentials file found. You can copy the template:"
        print_info "cp $(pwd)/config/aws/credentials.template ~/.aws/credentials"
        print_info "Then edit ~/.aws/credentials with your actual AWS credentials"
    fi
fi

print_success "$TOOL_NAME setup complete"