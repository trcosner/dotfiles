#!/usr/bin/env bash

source ./utils.sh

# SSH Key Path
SSH_KEY_PATH="${HOME}/.ssh/id_ed25519"

# Cleanup function to remove created files on critical failure
cleanup() {
  print_error "Cleaning up due to critical failure..."
  if [ -f "$SSH_KEY_PATH" ]; then
    rm -f "$SSH_KEY_PATH" "$SSH_KEY_PATH.pub"
    print_info "Deleted SSH keys: $SSH_KEY_PATH and $SSH_KEY_PATH.pub"
  fi
  exit 1
}

# Check if GitHub SSH is already set up
check_github_ssh_setup() {
  if [ -f "$SSH_KEY_PATH" ] && ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    print_success "GitHub SSH is already set up and working. Exiting..."
    exit 0
  fi
}

# Prompt for GitHub login if not authenticated
prompt_for_github_login() {
  print_warning "GitHub CLI is not authenticated."
  print_warning "You need to log in to continue. Please follow the prompts:"
  if gh auth login; then
    print_success "GitHub authentication successful."
    print_info "Refreshing GitHub token to include public key management permissions..."
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
  while true; do
    print_info "Enter a name for your SSH key (required):"
    read -r SSH_KEY_NAME
    if [ -n "$SSH_KEY_NAME" ]; then
      print_success "Using custom SSH key name: $SSH_KEY_NAME"
      break
    else
      print_error "SSH key name cannot be empty. Please enter a valid name."
    fi
  done
}


# Check GitHub SSH setup before proceeding
check_github_ssh_setup

verify_homebrew_installed

# Install Git if not present
if ! command -v git &> /dev/null; then
  print_info "Installing Git..."
  brew install git || { print_error "Failed to install Git."; cleanup; }
else
  print_success "Git already installed."
fi

# Install GitHub CLI if not present
if ! command -v gh &> /dev/null; then
  print_info "Installing GitHub CLI..."
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

# Generate SSH key if it doesn't already exist
if [ ! -f "$SSH_KEY_PATH" ]; then
  print_info "Generating SSH key..."
  ssh-keygen -t ed25519 -C "$(git config user.email)" -f "$SSH_KEY_PATH" -N "" || { print_error "SSH key generation failed."; cleanup; }
else
  print_success "SSH key already exists at $SSH_KEY_PATH."
fi

# Start SSH agent and add the key
eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY_PATH" || { print_error "Failed to add SSH key to agent."; cleanup; }

# Print the public key
print_info "Your SSH public key is:"
cat "$SSH_KEY_PATH.pub"

# Upload the SSH key to GitHub if authenticated
if gh auth status &>/dev/null; then
  print_info "Uploading SSH key to GitHub with name: $SSH_KEY_NAME..."

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
print_info "Adding GitHub to known_hosts to prevent SSH prompt..."
if ! grep -q "github.com" ~/.ssh/known_hosts 2>/dev/null; then
  ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts 2>/dev/null
  print_success "GitHub host key added to known_hosts."
else
  print_success "GitHub host key already exists in known_hosts."
fi

# Test GitHub SSH connection
print_info`` "Testing SSH connection to GitHub..."
SSH_OUTPUT=$(ssh -T git@github.com 2>&1)

if echo "$SSH_OUTPUT" | grep -q "successfully authenticated"; then
  print_success "SSH connection to GitHub successful!"
else
  print_error "Failed to connect to GitHub via SSH. Output was:"
  print_error "$SSH_OUTPUT"
  print_error "Please check your SSH key configuration and try again."
  exit 1
fi

print_success "GitHub SSH setup completed successfully!"
