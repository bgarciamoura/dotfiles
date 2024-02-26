-- setting the leader to be <Space>
vim.g.mapleader = " "

local keymap = vim.keymap
local opts = {
	silent = true,
	noremap = true
}
-- Window management
keymap.set("n", "sv", ":vsplit<CR>", { desc = "Split the window vertically", silent = true, noremap = true })
keymap.set("n", "sh", ":split<CR>", { desc = "Split the window horizontally", silent = true, noremap = true})
keymap.set("n", "sx", ":close<CR>", {desc = "Close splitted window", silent = true, noremap = true})
keymap.set("n", "se", "<C-w>=", {desc = "Make the splitted windows to has the same size", silent = true, noremap = true})

-- Select all
keymap.set("n", "<C-a>", ":keepjumps normal! ggVG<cr>", {desc = "Select all text in current buffer", silent = true, noremap = true})

-- Move window
keymap.set("n", "sh", "<C-w>h", {desc = "Move the window left", silent = true, noremap = true})
keymap.set("n", "sk", "<C-w>k", {desc = "Move the window up", silent = true, noremap = true})
keymap.set("n", "sj", "<C-w>j", {desc = "Move the window down", silent = true, noremap = true})
keymap.set("n", "sl", "<C-w>l", {desc = "Move the window right", silent = true, noremap = true})

-- Resize window
keymap.set("n", "<A-left>", "<C-w><",{desc = "Raise the window size", silent = true, noremap = true})
keymap.set("n", "<A-right>", "<C-w>>",{desc = "Raise the window size", silent = true, noremap = true})
keymap.set("n", "<A-up>", "<C-w>+",{desc = "Raise the window size", silent = true, noremap = true})
keymap.set("n", "<A-down>", "<C-w>-",{desc = "Raise the window size", silent = true, noremap = true})

-- Remap the <ESC> to kj
keymap.set("i", "kj", "<ESC>",{desc = "Remap kj to be the <ESC> key", silent = true, noremap = true})
keymap.set("v", "kj", "<ESC>",{desc = "Remap the kj to be the <ESC> key", silent = true, noremap = true})

-- Save file with control S
keymap.set("n", "<C-s>", ":w<CR>",{desc = "Save the current file using <C-s>", silent = true, noremap = true})
keymap.set("i", "<C-s>", "<Esc>:w<CR>",{desc = "Save the current file using <C-s>", silent = true, noremap = true})

-- Undo with control Z
keymap.set("n", "<C-z>", ":undo<CR>",{desc = "Undo using <C-z>", silent = true, noremap = true})
keymap.set("i", "<C-z>", "<cmd>:undo<CR>",{desc = "Undo using <C-z>", silent = true, noremap = true})

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')
