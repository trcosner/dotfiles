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
	check_ripgrep.sh \
  check_nvim.sh \
  check_lazygit.sh \
  check_raycast.sh \
  check_hyperkey.sh \
  check_starship.sh \
  check_tmux.sh \
  check_ffmpeg.sh \
  check_7zip.sh \
  check_jq.sh \
  check_poppler.sh \
  check_fd.sh \
  check_fzf.sh \
  check_resvg.sh \
  check_imagemagick.sh \
  check_xsel.sh \
  check_yazi.sh \
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
./check_ripgrep.sh
./check_nvim.sh
./check_lazygit.sh
./check_raycast.sh
./check_hyperkey.sh
./check_starship.sh
./check_tmux.sh
./check_ffmpeg.sh
./check_7zip.sh
./check_jq.sh
./check_poppler.sh
./check_fd.sh
./check_fzf.sh
./check_resvg.sh
./check_imagemagick.sh
./check_xsel.sh
./check_yazi.sh
print_success "Initial setup complete!"

