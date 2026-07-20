-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Yank/Paste to/from clipboard
map("n", "<C-y><C-y>", '"+yy', { desc = "Yank line to system clipboard" })
map("v", "<C-y>", '"+yy', { desc = "Yank selection to system clipboard" })

map("n", "<C-p>", '"+p', { desc = "Paste from system clipboard after cursor" })
map("v", "<C-p>", '"+p', { desc = "Replace selection with system clipboard" })

-- Go to next/prev buffer
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>bprev<cr>", { desc = "Prev Buffer" })

-- Move up/dow half a page and center
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down centered" })
map("i", "<C-d>", "<C-o><C-d><C-o>zz", { desc = "Half page down centered" })

map("n", "<C-u>", "<C-u>zz", { desc = "Half page up centered" })
map("i", "<C-u>", "<C-o><C-u><C-o>zz", { desc = "Half page up centered" })

-- Center after search
map("n", "n", "'Nn'[v:searchforward].'zvzz'", { expr = true, desc = "Next Search Result Centered" })
map("n", "N", "'nN'[v:searchforward].'zvzz'", { expr = true, desc = "Prev Search Result Centered" })

-- Delete in normal mode
map("n", "<BS>", "X", { desc = "Backspace delete" })
map("n", "<Del>", "x", { desc = "Delete character" })

-- Switch window from terminal
map("t", "<C-w><C-w>", [[<C-\><C-n><C-w><C-w>]], { desc = "Switch window from terminal" })

-- Move cursor in insert mode
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

