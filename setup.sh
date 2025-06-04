#!/usr/bin/env bash

set -e

source ./utils.sh

print_info "Ensuring sub-scripts are executable"
chmod +x \
	utils.sh \
	check_xcode.sh \
	check_homebrew.sh \
  check_zsh.sh \
	check_nerdfonts.sh \
	check_powerlevel10k.sh \
	check_starship.sh \
	check_wezterm.sh \
	check_hyperkey.sh \
	check_jankyborders.sh \
	check_github.sh \
	check_node.sh \
	check_fzf.sh \
	check_ripgrep.sh \
	check_fd.sh \
	check_jq.sh \
	check_eza.sh \
	check_zoxide.sh \
	check_lazygit.sh \
	check_tmux.sh \
	check_nvim.sh \
	check_docker.sh \
	check_kubernetes.sh \
	check_skaffold.sh \
	check_terraform.sh \
	check_ffmpeg.sh \
	check_imagemagick.sh \
	check_poppler.sh \
	check_resvg.sh \
	check_7zip.sh \
	check_xsel.sh \
	check_raycast.sh \
	check_yazi.sh \
  	check_python.sh \
  	check_aws.sh \
	# || print_error

# Core Dependencies
./check_xcode.sh             # Xcode CLI tools (compilers, headers)
./check_homebrew.sh          # Package manager
./check_zsh.sh               # Shell setup

# Terminal & Shell Appearance
./check_nerdfonts.sh         # Fonts for terminal/prompt
./check_powerlevel10k.sh     # Zsh prompt theme
./check_starship.sh          # Prompt (optional replacement or addition)
./check_wezterm.sh           # Terminal emulator
./check_hyperkey.sh          # Capslock → Hyper key
./check_jankyborders.sh      # Window border visuals

# Git & GitHub Auth
./check_github.sh            # SSH and GitHub CLI setup

# CLI Developer Tools
./check_node.sh              # JS runtime and CLI tool support
./check_fzf.sh               # Fuzzy finder
./check_ripgrep.sh           # Fast recursive search
./check_fd.sh                # User-friendly alternative to `find`
./check_jq.sh                # JSON processor
./check_eza.sh               # Modern `ls` replacement
./check_zoxide.sh            # Smarter `cd` navigation
./check_lazygit.sh           # TUI Git interface
./check_tmux.sh              # Terminal multiplexer
./check_nvim.sh              # Code editor
./check_python.sh            # python installation
# DevOps & Infra Tools
./check_docker.sh            # Container engine
./check_kubernetes.sh        # k8s CLI tools
./check_skaffold.sh          # Local k8s build/deploy tool
./check_terraform.sh         # Infrastructure as code
./check_aws.sh               # AWS CLI tools

# Media & Format Utilities
./check_ffmpeg.sh            # Media conversion
./check_imagemagick.sh       # Image manipulation
./check_poppler.sh           # PDF tools
./check_resvg.sh             # SVG rendering
./check_7zip.sh              # Archive utility
./check_xsel.sh              # Clipboard utility for X11 (for Yazi)

# Optional UX/Utilities
./check_raycast.sh           # Spotlight-like app launcher
./check_yazi.sh              # TUI file manager

print_success "Initial setup complete!"

