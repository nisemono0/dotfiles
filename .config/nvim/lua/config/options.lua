-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Swap leader and localleader keys
vim.g.mapleader = "\\"
vim.g.maplocalleader = " "

-- LazyVim auto format
vim.g.autoformat = false

-- Snacks animations
vim.g.snacks_animate = false

-- LSP Server to use for Python
vim.g.lazyvim_python_lsp = "python-lsp-server"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"

local opt = vim.opt

-- Enable system clipboard
-- opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"
-- Disable system clipboard
opt.clipboard = ""

-- Highlight current line
opt.cursorline = false

-- Show some invisible characters
opt.list = true
opt.listchars = {
	tab = "→ ",
	trail = "•",
	nbsp = "␣",
    extends = "❯",
    precedes = "❮"
}

-- Use spaces instead of tabs
opt.expandtab = true

-- Mouse mode
opt.mouse = "vi"

-- Wrap lines at convenient points
opt.linebreak = false

-- Size of an indent
opt.shiftwidth = 4

-- Number of spaces tabs count for
opt.tabstop = 4

-- Undo file
opt.undofile = false

-- Line wrapping
opt.wrap = true

