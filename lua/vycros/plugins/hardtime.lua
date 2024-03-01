return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  opts = {},
  config = function()
    require("hardtime").setup({
      allow_different_key = false,
      max_time = 500,
      max_count = 5,
      disable_mouse = false,
      disabled_keys = {

        ["<Down>"] = { "x", "n", "v" },
        ["<Left>"] = { "x", "n", "v" },
        ["<Right>"] = { "x", "n", "v" },
        ["<Up>"] = { "x", "n", "v" },
      },
    })
  end,
}
