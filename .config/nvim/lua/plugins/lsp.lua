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
                    -- Set it to <c-i> instead
                    { "<C-k>", false, mode = "i" },
                    { "<c-i>", function() return vim.lsp.buf.signature_help() end, mode = "i", desc = "Signature Help", has = "signatureHelp" },
                    { "<c-i>", function() return vim.lsp.buf.hover() end, mode = "n", desc = "Hover" },
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

