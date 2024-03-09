return {
  "j-hui/fidget.nvim",
  tag = "v1.0.0",
  opts = {
    window = {
      winblen = 0,
    },
  },
  config = function() require("fidget").setup({}) end,
}
