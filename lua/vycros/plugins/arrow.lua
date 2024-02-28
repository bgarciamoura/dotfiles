return {
  "otavioschwanck/arrow.nvim",
  config = function()
    require("arrow").setup({
      show_icons = true,
      save_path = function() return vim.fn.stdpath("cache") .. "/arrow" end,
      mappings = {
        edit = "e",
        delete_mode = "d",
        clear_all_items = "C",
        toggle = "s", -- used as save if separate_save_and_remove is true
        open_vertical = "v",
        open_horizontal = "-",
        quit = "q",
        remove = "x", -- only used if separate_save_and_remove is true
      },
      window = {
        width = "auto",
        height = "auto",
        row = "auto",
        col = "auto",
        border = "double",
      },
      leader_key = ";",
      index_keys = "123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP",
    })
  end,
}
