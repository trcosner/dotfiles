function file_exists(name)
  local f = io.open(name, "r")
  if f then
    f:close()
    return true
  end
  return false
end

-- Dynamically find the correct Zsh path
function find_zsh()
  local paths = {
    "/opt/homebrew/bin/zsh",  -- Apple Silicon Homebrew
    "/usr/local/bin/zsh",     -- Intel Mac Homebrew
    "/bin/zsh",               -- System Zsh
  }

  for _, path in ipairs(paths) do
    if file_exists(path) then
      return path
    end
  end
  return "/bin/zsh"  -- Fallback to system Zsh if not found
end

local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.font=wezterm.font("Hasklug Nerd Font")
config.font_size = 19
config.enable_tab_bar = false
config.launch_menu = {
    {label="Zsh", args={find_zsh(), "-l"}},
    {label="Bash", args={"/bin/bash", "-l"}},
    {label="Neovim", args={"nvim"}},
    {label="Htop", args={"htop"}},
  }
config.default_prog = {find_zsh(), "-l"}
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9
config.macos_window_background_blur = 10

config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}
return config
