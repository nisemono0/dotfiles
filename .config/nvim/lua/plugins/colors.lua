-- TODO: Edit the habamin theme
-- TODO: Edit the alabasterdark theme

-- Local: Habamin
-- return {
--     "LazyVim/LazyVim",
--     opts = {
--         colorscheme = "habamin"
--     }
-- }


-- Tokyonight
-- return {
--     {
--         "folke/tokyonight.nvim",
--         opts = {
--             style = "night",
--             transparent = true,
--             -- Comment to use the theme's term colors
--             terminal_colors = false,
--             styles = {
--                 comments = { italic = false },
--                 keywords = { italic = false },
--                 sidebars = "transparent",
--                 floats = "transparent",
--             }
--         }
--     },
--     {
--         "LazyVim/LazyVim",
--         opts = {
--             colorscheme = "tokyonight"
--         }
--     }
-- }


-- Catppuccin
-- return {
--     {
--         "catppuccin/nvim",
--         opts = {
--             transparent_background = true,
--             float = {
--                 transparent = true,
--                 solid = false,
--             },
--             term_colors = false,
--             no_italic = true,
--             no_bold = true,
--             no_underline = false
--         },
--     },
--     {
--         "LazyVim/LazyVim",
--         opts = {
--             colorscheme = "catppuccin-mocha"
--         },
--     },
-- }


-- Rose pine
return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
            variant = "auto",
            dark_variant = "main",
            -- Comment to use the theme's term colors
            enable = {
                terminal = false
            },
            styles = {
                bold = false,
                italic = false,
                transparency = true,
            },
        }
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "rose-pine"
        }
    }
}


-- Everforest
-- return {
--     {
--         "neanias/everforest-nvim",
--         name = "everforest",
--         opts = {
--             italics = false,
--             disable_italic_comments = true,
--             transparent_background_level = 2,
--         }
--     },
--     {
--         "LazyVim/LazyVim",
--         opts = {
--             colorscheme = "everforest"
--         }
--     }
-- }


-- Nightfox
-- return {
--     {
--         "EdenEast/nightfox.nvim",
--         opts = {
--             options = {
--                 transparent = true,
--                 terminal_colors = false
--             }
--         }
--     },
--     {
--         "LazyVim/LazyVim",
--         opts = {
--             -- nightfox, duskfox, nordfox, terafox, carbonfox
--             colorscheme = "nightfox"
--         }
--     }
-- }
--
