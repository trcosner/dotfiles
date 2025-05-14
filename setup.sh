#!/bin/bash

set -e

source ./utils.sh

print_success "Ensuring sub-scripts are executable"
chmod +x \
	utils.sh \
	check_xcode.sh \
	check_homebrew.sh \
	check_zsh.sh \
	check_github.sh \
	check_wezterm.sh \
	check_docker.sh	\
	|| print_error

# Check for Xcode Command Line Tools
./check_xcode.sh

# Check for Homebrew
./check_homebrew.sh

# Check for ZSH
./check_zsh.sh

#Check for Git
./check_github.sh

#Check for wezterm
./check_wezterm.sh

#Check for docker
./check_docker.sh
print_success "Initial setup complete!"

