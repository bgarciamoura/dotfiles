-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("vycros.core")
require("vycros.lazy")


-- setting the configs for colorscheme
vim.o.termguicolors = true
pcall(vim.cmd.colorscheme, "catppuccin")
