return {
  "allaman/emoji.nvim",
  version = "1.0.0",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    enable_cmp_integration = true,
    --plugin_path = vim.fn.expand("$HOME/.config/nvim/lua/"),
  },
}
