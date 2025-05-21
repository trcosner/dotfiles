# 🌱 Dotfiles Setup for macOS (Apple Silicon)

This repository provides a fully automated and modular setup for configuring a complete developer environment on Apple Silicon Macs. It ensures consistency, performance, and easy replication across machines. The system includes setup for Zsh, Neovim, Tmux, WezTerm, GitHub SSH, Docker, Kubernetes, and much more—fully automated using Bash.

---

## 📌 What Are Dotfiles?

Dotfiles are hidden configuration files in Unix-based systems that customize your command-line environment, editor behavior, terminal appearance, and many tools you use daily. Storing them in a version-controlled repository lets you recreate or share your environment easily.

---

## ⚙️ What’s Included

### Core Shell & Terminal

- Zsh with powerlevel10k theme and optional Starship prompt
- Nerd Font installation for UI glyphs
- WezTerm terminal configuration
- Hyper key mapping (Caps Lock remapped to Ctrl+Opt+Shift+Cmd)
- JankyBorders for focused window borders

### Editor & IDE

- Neovim with full plugin suite managed via lazy.nvim
- Modern LSP support, auto-completion, formatters, linters, snippet engines
- Telescope fuzzy finder, Treesitter, Git integration
- Copilot and CopilotChat integration
- Session management and welcome dashboard with Alpha
- Visual enhancements via bufferline, lualine, dressing, indent guides

### CLI Developer Tools

- Node.js and NVM
- FZF, Ripgrep, FD, jq, EZA, Zoxide
- Lazygit TUI Git client
- Tmux and plugins (Navigator, Resurrect, Continuum)
- Yazi terminal file manager

### DevOps & Infra Tools

- Docker
- Kubernetes CLI tools
- Skaffold
- Terraform

### Media & Utility Tools

- FFmpeg
- ImageMagick
- Poppler
- Resvg
- 7zip
- xsel (clipboard support for Yazi)

### UX & Productivity

- Raycast launcher

---

## 🚀 Setup Instructions

1. Clone the repository into `~/.dotfiles`
2. Run the `install.sh` script
3. Follow interactive prompts (e.g., GitHub SSH key generation)
4. Your shell, terminal, editor, and CLI will be configured automatically

The script delegates all work to modular `check_*.sh` scripts, each responsible for installing and verifying a tool.

---

## 📝 Key Configuration Files

- `.zshrc`: Shell behavior and plugin sourcing
- `.wezterm.lua`: Terminal emulator configuration
- `.config/nvim/init.lua`: Full Neovim config with plugins
- `.tmux.conf`: Tmux session persistence and keybindings
- `.config/borders/bordersrc`: Window border appearance
- `.ssh/id_ed25519`: GitHub SSH identity (auto-created if missing)

---

## 🕹️ Neovim Plugin Highlights

Your Neovim configuration includes over 50 curated plugins optimized for modern development:

### LSP & Completion

- `nvim-lspconfig`, `mason.nvim`, `mason-lspconfig`, `cmp-nvim-lsp`, `nvim-cmp`, `LuaSnip`, `friendly-snippets`

### Formatters & Linters

- `conform.nvim`, `nvim-lint`, `null-ls`, `mason-tool-installer`

### Git Integration

- `gitsigns.nvim`, `lazygit.nvim`, `vim-tmux-navigator`

### Search & Navigation

- `telescope.nvim`, `telescope-fzf-native.nvim`, `plenary.nvim`, `nvim-tree.lua`, `nvim-web-devicons`, `which-key.nvim`

### UI & Visuals

- `tokyonight.nvim`, `lualine.nvim`, `bufferline.nvim`, `alpha-nvim`, `dressing.nvim`, `indent-blankline.nvim`, `nvim-ts-context-commentstring`

### Productivity & Editing

- `nvim-autopairs`, `nvim-surround`, `substitute.nvim`, `vim-maximizer`, `todo-comments.nvim`, `nvim-treesitter`, `nvim-ts-autotag`, `live-preview.nvim`, `nvim-lsp-file-operations`, `neodev.nvim`

### AI Tools

- `copilot.vim`, `CopilotChat.nvim`

### Session Management

- `auto-session` with dashboard integration

These plugins are managed by `lazy.nvim`, which handles loading efficiency, update checking, and profiling.

---

## ⌨️ Features & Shortcuts

- GitHub CLI auto-authentication with SSH key setup
- Fuzzy file search with Telescope in Neovim
- Lazygit integration inside Neovim or standalone
- JankyBorders for visual window cues
- Hyper key remapping for advanced shortcuts
- Zoxide for fast directory jumping
- Tmux sessions saved/restored automatically
- Copilot for real-time AI coding assistance
- Neovim keybinds via `which-key` prompt all available options

---

## ☁️ Remote Development (Optional)

- Use Terraform scripts under `~/dotfiles/terraform/` to provision an EC2 dev box
- Persistent Tmux session support
- Connect remotely from any configured laptop using SSH

---

## ✅ Verification & Testing

- `tmux source-file ~/.tmux.conf` to reload config
- Launch `nvim` and verify plugin health via `:Lazy`
- `ssh -T git@github.com` to test SSH GitHub auth
- `yazi`, `lazygit`, or `fzf` to confirm tool behavior

---

## 💼 Maintenance

Each tool is managed independently through a `check_*.sh` script. To update or reinstall a specific tool, just rerun the associated script. Dotfiles can be updated and pushed to GitHub for synchronization across devices.

---

## 📄 License

MIT License. See LICENSE for details.

---

## 🙌 Credits

Inspired by dotfiles setups from:

- Josean Martinez (YouTube)
- Mathias Bynens
- Zach Holman
- ThePrimeagen
