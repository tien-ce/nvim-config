vim.cmd("set expandtab") -- Use space instead of \t when press tab
vim.cmd("set tabstop=2") -- How nvim deal with when meet \t (draw 2 spaces)
vim.cmd("set softtabstop=2") -- When use tab, each tab = 2 spaces, bacspace = remove 2 sapces
vim.cmd("set shiftwidth=2") -- Indent (>>, <<) or automatically indent of nvim
-- Use Ctrl + space to go to normal mode from insert mode
local modes = { "n", "i", "v", "x", "s", "o", "c" }
vim.keymap.set(modes, "<C-Space>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set(modes, "<C-@>", "<Esc>", { noremap = true, silent = true })
-- Navigation & actions in insert mode
vim.keymap.set("i", "<C-v>", "<C-o>l", { desc = "Move right in insert mode" })
vim.keymap.set("i", "<C-j>", "<C-o>j", { desc = "Move down in insert mode" })
vim.keymap.set("i", "<C-k>", "<C-o>k", { desc = "Move up in insert mode" })
vim.keymap.set("i", "<C-o>", "<C-o>o", { desc = "New line below in insert mode" })
vim.keymap.set("i", "<C-p>", "<C-o>O", { desc = "New line above in insert mode" })
vim.keymap.set("i", "<C-u>", "<C-o>u", { desc = "Undo in insert mode" })
vim.keymap.set("i", "<C-z>", "<C-o><C-r>", { desc = "Redo in insert mode" })

vim.opt.number = true -- show current line
vim.opt.relativenumber = true -- show relative line
-- Link default register (") to system clipboard (+)
vim.opt.clipboard = "unnamedplus"
vim.o.exrc = true
