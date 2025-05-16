#!/usr/bin/env bash

set -e

# Load utility functions
source ./utils.sh

print_success "Starting Starship setup..."

print_success "Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
  print_error "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || print_error "Failed to install Homebrew."
  print_error "Homebrew installation initiated. Please complete the installation manually if required. Exiting script."
  exit 1
else
  print_success "Homebrew already installed."
fi

print_success "Checking for Starship..."
if ! brew list starship &> /dev/null; then
  print_success "Starship not found. Installing via Homebrew..."
  if brew install starship; then
    print_success "Starship successfully installed."
  else
    print_error "Failed to install Starship."
    exit 1
  fi
else
  print_success "Starship already installed."
fi

print_success "Verifying Starship installation..."
if command -v starship &> /dev/null; then
  print_success "Starship is correctly installed."
else
  print_error "Starship installation verification failed. Please check manually."
  exit 1
fi

# Configuration directories
DOTFILES_DIR="$HOME/.dotfiles"
STARSHIP_CONFIG_DIR="$DOTFILES_DIR/starship"
STARSHIP_CONFIG_FILE="$STARSHIP_CONFIG_DIR/starship.toml"
TARGET_CONFIG_DIR="$HOME/.config/starship"
TARGET_CONFIG_FILE="$TARGET_CONFIG_DIR/starship.toml"

# Ensure the starship config directory exists in dotfiles
mkdir -p "$STARSHIP_CONFIG_DIR"

# Check if a custom configuration exists
if [ -f "$STARSHIP_CONFIG_FILE" ]; then
  print_success "Found existing Starship config in dotfiles."
else
  print_success "Creating default Starship configuration..."

  # Default configuration template
  cat > "$STARSHIP_CONFIG_FILE" <<EOF
# Starship configuration file

[character]
success_symbol = "[✔️](bold green)"
error_symbol = "[✘](bold red)"

[battery]
full_symbol = "🔋"
charging_symbol = "⚡️"
discharging_symbol = "🔌"

[git_branch]
symbol = "🌿 "

[package]
symbol = "📦 "
EOF
  print_success "Default configuration created at $STARSHIP_CONFIG_FILE."
fi

# Ensure the target configuration directory exists
mkdir -p "$TARGET_CONFIG_DIR"

# Symlink the Starship configuration
if [ -L "$TARGET_CONFIG_FILE" ]; then
  print_success "Starship configuration symlink already exists."
else
  ln -sf "$STARSHIP_CONFIG_FILE" "$TARGET_CONFIG_FILE"
  print_success "Symlinked Starship configuration: $TARGET_CONFIG_FILE -> $STARSHIP_CONFIG_FILE"
fi

print_success "Updating shell profiles to use Starship..."

# Update Zsh configuration
ZSHRC="$DOTFILES_DIR/zsh/.zshrc"
if [ -f "$ZSHRC" ] && ! grep -q 'eval "$(starship init zsh)"' "$ZSHRC"; then
  echo 'eval "$(starship init zsh)"' >> "$ZSHRC"
  print_success "Added Starship to Zsh profile."
fi

# Update Bash configuration
BASHRC="$DOTFILES_DIR/bash/.bashrc"
if [ -f "$BASHRC" ] && ! grep -q 'eval "$(starship init bash)"' "$BASHRC"; then
  echo 'eval "$(starship init bash)"' >> "$BASHRC"
  print_success "Added Starship to Bash profile."
fi

# Update Fish configuration
FISH_CONFIG="$DOTFILES_DIR/fish/config.fish"
if [ -f "$FISH_CONFIG" ] && ! grep -q 'starship init fish' "$FISH_CONFIG"; then
  echo 'starship init fish | source' >> "$FISH_CONFIG"
  print_success "Added Starship to Fish shell profile."
fi

print_success "Starship setup complete!"
echo "You can customize your prompt by editing the configuration file at: $STARSHIP_CONFIG_FILE"

