return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
            prompts = {
                -- Error Explanation
                ExplainError = {
                    prompt = "Explain the error message or stack trace in the selected text and provide potential fixes.",
                    selection = function(source)
                        local select = require("CopilotChat.select")
                        return select.visual(source)
                    end,
                },

                -- Code Transformation: Minify Code
                Minify = {
                    prompt = "Minify the following code while preserving functionality.",
                    selection = function(source)
                        local select = require("CopilotChat.select")
                        return select.visual(source)
                    end,
                },

                -- Code Transformation: Beautify Code
                Beautify = {
                    prompt = "Format and beautify the following code to improve readability.",
                    selection = function(source)
                        local select = require("CopilotChat.select")
                        return select.visual(source)
                    end,
                },

                -- Algorithm Complexity Analysis
                AnalyzeComplexity = {
                    prompt = "Analyze the time and space complexity of the selected algorithm. Explain the reasoning.",
                    selection = function(source)
                        local select = require("CopilotChat.select")
                        return select.visual(source)
                    end,
                },

                -- Code Snippet Improvement
                Improve = {
                    prompt = "Improve the following code for readability, performance, and maintainability.",
                    selection = function(source)
                        local select = require("CopilotChat.select")
                        return select.visual(source)
                    end,
                },
            },
        },
        -- See Commands section for default commands if you want to lazy load on them
        keys = {
            { "<leader>zc", ":CopilotChat<CR>", mode = "n", desc = "Chat with Copilot" },
            { "<leader>ze", ":CopilotChatExplain<CR>", mode = "v", desc = "Explain code" },
            { "<leader>zr", ":CopilotChatReview<CR>", mode = "v", desc = "Review code" },
            { "<leader>zf", ":CopilotChatFix<CR>", mode = "v", desc = "Fix code issues" },
            { "<leader>zo", ":CopilotChatOptimize<CR>", mode = "v", desc = "Optimize code" },
            { "<leader>zd", ":CopilotChatDocs<CR>", mode = "v", desc = "Generate docs" },
            { "<leader>zt", ":CopilotChatTests<CR>", mode = "v", desc = "Generate tests" },
            { "<leader>zx", ":CopilotChatExplainError<CR>", mode = "v", desc = "Explain error message" },
            { "<leader>zm", ":CopilotChatMinify<CR>", mode = "v", desc = "Minify selected code" },
            { "<leader>zu", ":CopilotChatUnminify<CR>", mode = "v", desc = "Unminify selected code" },
            { "<leader>za", ":CopilotChatAnalyze<CR>", mode = "v", desc = "Analyze algorithm complexity" },
            { "<leader>zi", ":CopilotChatImprove<CR>", mode = "v", desc = "Improve selected code" },
        },
    },
}
