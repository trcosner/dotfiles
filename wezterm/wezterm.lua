local wezterm = require 'wezterm'

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

return {
  -- Launch Menu
  launch_menu = {
    {label="Zsh", args={find_zsh(), "-l"}},
    {label="Bash", args={"/bin/bash", "-l"}},
    {label="Neovim", args={"nvim"}},
    {label="Htop", args={"htop"}},
  },

  -- Shell Configuration
  default_prog = {find_zsh(), "-l"},
}

