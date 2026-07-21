return {
    {
        -- Tokyonight
        -- {
        --     "folke/tokyonight.nvim",
        --     opts = {
        --         style = "night",
        --         transparent = true,
        --         -- Comment to use the theme's term colors
        --         terminal_colors = false,
        --         styles = {
        --             comments = { italic = false },
        --             keywords = { italic = false },
        --             sidebars = "transparent",
        --             floats = "transparent",
        --         }
        --     }
        -- },

        -- Catppuccin
        -- {
        --     "catppuccin/nvim",
        --     opts = {
        --         transparent_background = true,
        --         float = {
        --             transparent = true,
        --             solid = false,
        --         },
        --         term_colors = false,
        --         no_italic = true,
        --         no_bold = true,
        --         no_underline = false
        --     },
        -- },

        -- Vague
        -- {
        --     "vague-theme/vague.nvim",
        --     opts = {
        --         transparent = true,
        --         bold = false,
        --         italic = false
        --     }
        -- },

        -- Alabaster
        -- NOTE: Always loaded for some reason
        -- {
        --     'mcncl/alabaster.nvim',
        --     name = "alabaster",
        --     opts = {
        --         style = "dark",
        --         transparent = true,
        --         italic_comments = false
        --     }
        -- },

        -- Rose pine
        -- {
        --     "rose-pine/neovim",
        --     name = "rose-pine",
        --     opts = {
        --         variant = "auto",
        --         dark_variant = "main",
        --         -- Comment to use the theme's term colors
        --         enable = {
        --             terminal = false
        --         },
        --         styles = {
        --             bold = false,
        --             italic = false,
        --             transparency = true,
        --         },
        --     }
        -- },

        -- Everforest
        -- {
        --     "neanias/everforest-nvim",
        --     name = "everforest",
        --     opts = {
        --         italics = false,
        --         disable_italic_comments = true,
        --         transparent_background_level = 2,
        --     }
        -- },

        -- Nightfox
        -- {
        --     "EdenEast/nightfox.nvim",
        --     opts = {
        --         options = {
        --             transparent = true,
        --             terminal_colors = false
        --         }
        --     }
        -- },

        -- Rusty
        -- {
        --     "armannikoyan/rusty",
        --     opts = {
        --         transparent = true,
        --         italic_comments = false,
        --         underline_current_line = false,
        --     }
        -- },

        -- Kanso
        {
            "webhooked/kanso.nvim",
            opts = {
                bold = false,
                italics = false,
                transparent = true,
                foreground = "saturated",
            }
        },

        -- Set theme
        {
            "LazyVim/LazyVim",
            opts = {
                -- tokyonight
                -- catppuccin-mocha, catppuccin-macchiato, catppuccin-frappe
                -- vague
                -- alabaster
                -- rose-pine
                -- everforest
                -- nightfox, duskfox, nordfox, terafox, carbonfox
                -- rusty
                -- kanso-zen, kanso-mist, kanso-ink
                colorscheme = "kanso-mist"
            }
        }
    }
}

