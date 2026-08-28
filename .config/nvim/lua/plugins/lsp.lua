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
                    { "<c-j>", function() return vim.lsp.buf.hover() end, mode = "i", desc = "Hover" },
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

