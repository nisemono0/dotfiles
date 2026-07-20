return {
    "neovim/nvim-lspconfig",
    opts = {
        inlay_hints = {
            enabled = false,
        },
        diagnostics = {
            -- Adds icons to diagnostics
            virtual_text = {
                prefix = "icons"
            }
        },
        servers = {
            ['*'] = {
                keys = {
                    -- Disabled since C-k is set to move Up in insert mode
                    { "<C-k>", false, mode = "i" }
                }
            },
            clangd = {
                cmd = {
                    "clangd",
                    "--background-index",
                    "-j=4",
                    "--clang-tidy",
                    "--header-insertion=never",
                    "--completion-style=detailed",
                    "--function-arg-placeholders=0",
                    "--fallback-style=llvm"
                }
            },
            pylsp = {
                cmd = {
                    "pylsp"
                }
            }
        }
    }
}

