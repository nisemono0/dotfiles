return {
    "saghen/blink.cmp",
    opts = {
        completion = {
            list = {
                selection = {
                    preselect = false
                }
            }
        },
        keymap = {
            preset = "enter",
            ["<C-y>"] = { "select_and_accept" },
            ["<Tab>"] = {
                "snippet_forward",
                "select_next",
                "fallback",
            },
            ["<S-Tab>"] = {
                "snippet_backward",
                "select_prev",
                "fallback",
            },

        },
    }
}

