#!/usr/bin/env bash

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
	check_kubernetes.sh \
	check_node.sh \
	check_skaffold.sh \
	check_terraform.sh \
	check_nerdfonts.sh \
	check_powerlevel10k.sh \
	check_eza.sh \
	check_zoxide.sh \
	check_nvim.sh \
	|| print_error

./check_xcode.sh
./check_homebrew.sh
./check_zsh.sh
./check_github.sh
./check_wezterm.sh
./check_docker.sh
./check_kubernetes.sh
./check_node.sh
./check_skaffold.sh
./check_terraform.sh
./check_nerdfonts.sh
./check_powerlevel10k.sh
./check_eza.sh
./check_zoxide.sh
./check_nvim.sh

print_success "Initial setup complete!"

