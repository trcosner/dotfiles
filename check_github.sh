#!/bin/bash

# Import utility functions
source "$(dirname "$0")/utils.sh"

# Cleanup function to remove created files on critical failure
cleanup() {
  print_error "Cleaning up due to critical failure..."
  if [ -f "$SSH_KEY_PATH" ]; then
    rm -f "$SSH_KEY_PATH" "$SSH_KEY_PATH.pub"
    print_success "Deleted SSH keys: $SSH_KEY_PATH and $SSH_KEY_PATH.pub"
  fi
  exit 1
}

# Prompt for GitHub login if not authenticated
prompt_for_github_login() {
  print_error "GitHub CLI is not authenticated."
  print_success "You need to log in to continue. Please follow the prompts:"
  # Prompt for manual login and check success
  if gh auth login; then
    print_success "GitHub authentication successful."
    # Refresh permissions to ensure correct scopes
    print_success "Refreshing GitHub token to include public key management permissions..."
    if gh auth refresh -h github.com -s admin:public_key,write:public_key; then
      print_success "Token refreshed with required scopes."
    else
      print_error "Failed to refresh GitHub token with required scopes."
      exit 1
    fi
  else
    print_error "GitHub authentication failed or was skipped."
    exit 1
  fi
}

# Prompt for SSH key name
prompt_for_ssh_key_name() {
  print_success "Enter a name for your SSH key (default: TCMbpM1-16):"
  read -r SSH_KEY_NAME
  if [ -z "$SSH_KEY_NAME" ]; then
    SSH_KEY_NAME="TCMbpM1-16"
    print_success "Using default SSH key name: $SSH_KEY_NAME"
  else
    print_success "Using custom SSH key name: $SSH_KEY_NAME"
  fi
}

# Ensure Homebrew is installed
if ! command -v brew &> /dev/null; then
  print_error "Homebrew not found. Please install Homebrew first."
  exit 1
fi

# Install Git
if ! command -v git &> /dev/null; then
  print_success "Installing Git..."
  brew install git || { print_error "Failed to install Git."; cleanup; }
else
  print_success "Git already installed."
fi

# Install GitHub CLI if not present
if ! command -v gh &> /dev/null; then
  print_success "Installing GitHub CLI..."
  brew install gh || { print_error "Failed to install GitHub CLI."; cleanup; }
else
  print_success "GitHub CLI already installed."
fi

# Check GitHub authentication, prompt if not authenticated
if ! gh auth status &>/dev/null; then
  prompt_for_github_login
else
  print_success "GitHub CLI already authenticated."
fi

# Prompt for SSH key name
prompt_for_ssh_key_name

# SSH Key Setup
SSH_KEY_PATH="${HOME}/.ssh/id_ed25519"

# Generate SSH key if it doesn't already exist
if [ ! -f "$SSH_KEY_PATH" ]; then
  print_success "Generating SSH key..."
  ssh-keygen -t ed25519 -C "$(git config user.email)" -f "$SSH_KEY_PATH" -N "" || { print_error "SSH key generation failed."; cleanup; }
else
  print_success "SSH key already exists at $SSH_KEY_PATH."
fi

# Start SSH agent and add the key
eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY_PATH" || { print_error "Failed to add SSH key to agent."; cleanup; }

# Print the public key
print_success "Your SSH public key is:"
cat "$SSH_KEY_PATH.pub"

# Upload the SSH key to GitHub if authenticated
if gh auth status &>/dev/null; then
  print_success "Uploading SSH key to GitHub with name: $SSH_KEY_NAME..."
  if gh ssh-key add "$SSH_KEY_PATH.pub" --title "$SSH_KEY_NAME"; then
    print_success "SSH key uploaded to GitHub with title: $SSH_KEY_NAME"
  else
    print_error "Failed to upload SSH key to GitHub. Please manually add it if needed."
    exit 1
  fi
else
  print_error "GitHub is not authenticated. Skipping SSH key upload."
  exit 1
fi

# Add GitHub to known_hosts to prevent interactive SSH prompt
print_success "Adding GitHub to known_hosts to prevent SSH prompt..."
if ! grep -q "github.com" ~/.ssh/known_hosts 2>/dev/null; then
  ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts 2>/dev/null
  print_success "GitHub host key added to known_hosts."
else
  print_success "GitHub host key already exists in known_hosts."
fi

# Test GitHub SSH connection
print_success "Testing SSH connection to GitHub..."
SSH_OUTPUT=$(ssh -T git@github.com 2>&1)

if echo "$SSH_OUTPUT" | grep -q "successfully authenticated"; then
  print_success "SSH connection to GitHub successful!"
else
  print_error "Failed to connect to GitHub via SSH. Output was: $SSH_OUTPUT"
  exit 1
fi


print_success "GitHub SSH setup complete!"

