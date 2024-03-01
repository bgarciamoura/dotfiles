-- setting the leader to be <Space>
vim.g.mapleader = " "

local keymap = vim.keymap
-- ── Window management ───────────────────────────────────────────────
keymap.set(
  "n",
  "sv",
  ":vsplit<CR>",
  { desc = "Split the window vertically", silent = true, noremap = true }
)
keymap.set(
  "n",
  "sh",
  ":split<CR>",
  { desc = "Split the window horizontally", silent = true, noremap = true }
)
keymap.set(
  "n",
  "sx",
  ":close<CR>",
  { desc = "Close splitted window", silent = true, noremap = true }
)
keymap.set(
  "n",
  "se",
  "<C-w>=",
  { desc = "Make the splitted windows to has the same size", silent = true, noremap = true }
)

-- Select all
keymap.set(
  "n",
  "<C-a>",
  ":keepjumps normal! ggVG<cr>",
  { desc = "Select all text in current buffer", silent = true, noremap = true }
)

-- Move window
keymap.set("n", "sh", "<C-w>h", { desc = "Move the window left", silent = true, noremap = true })
keymap.set("n", "sk", "<C-w>k", { desc = "Move the window up", silent = true, noremap = true })
keymap.set("n", "sj", "<C-w>j", { desc = "Move the window down", silent = true, noremap = true })
keymap.set("n", "sl", "<C-w>l", { desc = "Move the window right", silent = true, noremap = true })

-- Resize window
keymap.set(
  "n",
  "<A-left>",
  "<C-w><",
  { desc = "Raise the window size", silent = true, noremap = true }
)
keymap.set(
  "n",
  "<A-right>",
  "<C-w>>",
  { desc = "Raise the window size", silent = true, noremap = true }
)
keymap.set(
  "n",
  "<A-up>",
  "<C-w>+",
  { desc = "Raise the window size", silent = true, noremap = true }
)
keymap.set(
  "n",
  "<A-down>",
  "<C-w>-",
  { desc = "Raise the window size", silent = true, noremap = true }
)

-- Remap the <ESC> to kj
keymap.set(
  "i",
  "kj",
  "<ESC>",
  { desc = "Remap kj to be the <ESC> key", silent = true, noremap = true }
)
keymap.set(
  "v",
  "kj",
  "<ESC>",
  { desc = "Remap the kj to be the <ESC> key", silent = true, noremap = true }
)

-- Save file with control S
keymap.set(
  "n",
  "<C-s>",
  ":w<CR>",
  { desc = "Save the current file using <C-s>", silent = true, noremap = true }
)
keymap.set(
  "i",
  "<C-s>",
  "<Esc>:w<CR>",
  { desc = "Save the current file using <C-s>", silent = true, noremap = true }
)

-- Undo with control Z
keymap.set("n", "<C-z>", ":undo<CR>", { desc = "Undo using <C-z>", silent = true, noremap = true })
keymap.set(
  "i",
  "<C-z>",
  "<cmd>:undo<CR>",
  { desc = "Undo using <C-z>", silent = true, noremap = true }
)

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d', { desc = "Delete a word backwards", silent = true, noremap = true })

-- Move cursor to the left window
keymap.set(
  "n",
  "<C-h>",
  "<C-W>h",
  { desc = "Move the cursor to the left window", silent = true, noremap = true }
)

-- Move cursor to the right window
keymap.set(
  "n",
  "<C-l>",
  "<C-W>l",
  { desc = "Move the cursor to the right window", silent = true, noremap = true }
)

-- Move cursor to the top window
keymap.set(
  "n",
  "<C-j>",
  "<C-W>k",
  { desc = "Move the cursor to the top window", silent = true, noremap = true }
)

-- Move cursor to the bottom window
keymap.set(
  "n",
  "<C-k>",
  "<C-W>j",
  { desc = "Move the cursor to the bottom window", silent = true, noremap = true }
)

-- Toggle tree view
keymap.set(
  "n",
  "<leader>e",
  "<cmd>NvimTreeToggle<CR>",
  { desc = "Toggle the Nvim Tree", noremap = true, silent = true }
)

-- Copy the whole file to system clipboard
keymap.set(
  "n",
  "<leader>cc",
  ':keepjumps normal! ggVG "*yG<CR>',
  { desc = "Copy the entire file to system clipboard", noremap = true, silent = true }
)

-- Copy the line to system clipboard
keymap.set(
  "n",
  "<leader>cl",
  '"*yy',
  { desc = "Copy the current line to system clipboard", noremap = true, silent = true }
)

-- obisidian follow link
keymap.set("n", "gf", function()
  if require("obsidian").util.cursor_on_markdown_link() then
    return "<cmd>ObsidianFollowLink<CR>"
  else
    return "gf"
  end
end, { noremap = false, expr = true })

-- Close all buffers excepts by the current one withou external plugins
keymap.set(
  "n",
  "<leader>bd",
  ":let current = bufnr('%')<CR>:bufdo if bufnr('%') != current | bd | endif<CR>",
  { desc = "Close all buffers excepts by the current one", noremap = true, silent = true }
)

-- Close current buffer without external plugins
keymap.set(
  "n",
  "<leader>bc",
  ":bd<CR>",
  { desc = "Close the current buffer", noremap = true, silent = true }
)

-- Move the cursor to indented line when press i
vim.keymap.set("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true, desc = "properly indent on empty line when insert" })

-- Comment-box
local opts = { noremap = true, silent = true }

-- Titles
keymap.set({ "n", "v" }, "<Leader>Cb", "<Cmd>CBccbox<CR>", { noremap = true, silent = true })
-- Named parts
keymap.set({ "n", "v" }, "<Leader>ct", "<Cmd>CBllline<CR>", { noremap = true, silent = true })
-- Simple line
keymap.set("n", "<Leader>cl", "<Cmd>CBline<CR>", { noremap = true, silent = true })
-- keymap.set("i", "<M-l>", "<Cmd>CBline<CR>", { noremap = true, silent = true }) -- To use in Insert Mode
-- Marked comments
keymap.set({ "n", "v" }, "<Leader>cm", "<Cmd>CBllbox14<CR>", { noremap = true, silent = true })
-- Removing a box is simple enough with the command (CBd), but if you
-- use it a lot:
keymap.set({ "n", "v" }, "<Leader>rcd", "<Cmd>CBd<CR>", { noremap = true, silent = true })
