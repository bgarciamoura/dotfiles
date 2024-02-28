local opt = vim.opt

-- Remove the ~ char on empty lines
-- opt.fillchars = { eob = "" }

-- Disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Setting the configs for colorscheme
vim.o.termguicolors = true

-- Setting tab size to 2
vim.opt.tabstop = 2

-- how much characters nvim will use to indent a line
vim.opt.shiftwidth = 2

-- controls if nvim should replace Tab for Space
vim.opt.expandtab = false

-- enable mouse to select
vim.opt.mouse = "a"

-- Show line numbers
vim.opt.number = true

-- disable the highlights of the previous search results
vim.opt.hlsearch = false

-- auto indent next line like the previous one
vim.opt.autoindent = true

-- highlight the cursor line to be more easy to find it
vim.opt.cursorline = true

-- set the encoding to utf-8
vim.opt.encoding = "utf-8"

-- remove the ~ character from empty lines on buffer
vim.opt.fillchars = "eob: "

-- follow the indentation of the previous line
vim.opt.smartindent = true

-- Add new line to the end of the file
--vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--  group = vim.api.nvim_create_augroup("UserOnSave", {}),
--  pattern = "*",
--  callback = function()
--    vim.lsp.buf.format()
--    local n_lines = vim.api.nvim_buf_line_count(0)
--    local last_nonblank = vim.fn.prevnonblank(n_lines)
--    if last_nonblank <= n_lines then
--      vim.api.nvim_buf_set_lines(0, last_nonblank, n_lines, true, { "" })
--    end
--  end,
--})

_G.add_new_line = function()
  local n_lines = vim.api.nvim_buf_line_count(0)
  local last_nonblank = vim.fn.prevnonblank(n_lines)
  if last_nonblank <= n_lines then
    vim.api.nvim_buf_set_lines(0, last_nonblank, n_lines, true, { "" })
  end
end

vim.cmd([[
  augroup AddNewlineOnSave
    autocmd!
    autocmd BufWritePre * lua _G.add_new_line()
  augroup END
]])
