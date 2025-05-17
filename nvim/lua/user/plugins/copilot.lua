return {
    "github/copilot.vim",
    cmd = "Copilot",
    build = ":Copilot setup",
    config = function()
        -- Enable Copilot globally
        vim.g.copilot_enabled = true

        -- Disable automatic tab completion
        vim.g.copilot_no_tab_map = true

        -- Manually accept Copilot suggestion with Hyper+C
        vim.api.nvim_set_keymap("i", "<C-M-C>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

        -- Optional: Manually trigger Copilot suggestion with <C-Space>
        vim.api.nvim_set_keymap("i", "<C-Space>", "copilot#Complete()", { silent = true, expr = true })

        -- Disable automatic trigger of suggestions
        vim.g.copilot_auto_trigger = false

        -- Comprehensive filetype support for a full-stack engineer
        vim.g.copilot_filetypes = {
            ["*"] = true,

            -- Web Development
            ["javascript"] = true,
            ["typescript"] = true,
            ["typescriptreact"] = true,
            ["html"] = true,
            ["css"] = true,
            ["scss"] = true,
            ["sass"] = true,
            ["vue"] = true,
            ["react"] = true,
            ["jsx"] = true,
            ["tsx"] = true,
            ["json"] = true,
            ["yaml"] = true,
            ["xml"] = true,
            ["markdown"] = true,

            -- Backend Development
            ["python"] = true,
            ["go"] = true,
            ["rust"] = true,
            ["java"] = true,
            ["kotlin"] = true,
            ["ruby"] = true,
            ["php"] = true,
            ["perl"] = true,
            ["c"] = true,
            ["cpp"] = true,
            ["csharp"] = true,
            ["r"] = true,
            ["sql"] = true,
            ["plsql"] = true,

            -- DevOps and Scripting
            ["bash"] = true,
            ["sh"] = true,
            ["zsh"] = true,
            ["dockerfile"] = true,
            ["terraform"] = true,
            ["hcl"] = true,
            ["ansible"] = true,
            ["make"] = true,
            ["ini"] = true,
            ["toml"] = true,
            ["systemd"] = true,
            ["powershell"] = true,

            -- Data and Infrastructure
            ["yaml"] = true,
            ["jsonnet"] = true,
            ["protobuf"] = true,
            ["graphql"] = true,
            ["sql"] = true,

            -- Cloud and Configuration
            ["docker-compose"] = true,
            ["gitignore"] = true,
            ["dotenv"] = true,
            ["env"] = true,

            -- Documentation and Markup
            ["markdown"] = true,
            ["rst"] = true,
            ["latex"] = true,
            ["vimwiki"] = true,

            -- Miscellaneous
            ["vim"] = true,
            ["lua"] = true,
            ["text"] = true,
            ["plaintext"] = true,
            ["config"] = true,
            ["gitcommit"] = true,
        }

        -- Custom keymaps for Copilot control
        vim.api.nvim_set_keymap("n", "<leader>co", ":Copilot enable<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>cd", ":Copilot disable<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>cs", ":Copilot status<CR>", { noremap = true, silent = true })

        -- Display Copilot status in the status line
        vim.cmd([[
            function! CopilotStatus() abort
                return copilot#Enabled() ? "ﮧ Copilot On" : "ﮧ Copilot Off"
            endfunction
            set statusline+=%{CopilotStatus()}
        ]])
    end,
}
