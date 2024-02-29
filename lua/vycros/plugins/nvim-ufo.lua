---@diagnostic disable: unused-local
return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    {
      "luukvbaal/statuscol.nvim",
      config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
          -- foldfunc = "builtin",
          -- setopt = true,
          relculright = true,
          segments = {
            { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
            { text = { "%s" }, click = "v:lua.ScSa" },
            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
          },
        })
      end,
    },
  },
  event = "BufRead",
  opts = function()
    vim.o.foldcolumn = "1" -- '0' is not bad
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
  end,
  config = function()
    require("ufo").setup({
      open_fold_hl_timeout = 0,
      provider_selector = function(bufnr, filetype, buftype) return { "treesitter", "indent" } end,
      -- close_fold_kinds = {
      --   "comment",
      --   "function",
      --   "method",
      --   "block",
      --   "if_statement",
      --   "else_clause",
      --   "elseif_clause",
      --   "case_statement",
      --   "default_clause",
      -- },
    })
  end,
}
