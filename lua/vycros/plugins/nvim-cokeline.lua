local function bg_color(buffer, colors) return buffer.is_focused and colors.Mauve or colors.Sky end
local function fg_color(buffer, colors) return buffer.is_focused and colors.Base or colors.Subtext0 end
local colors = require("vycros.core.colors")

return {
  {
    "willothy/nvim-cokeline",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("cokeline").setup({
        default_hl = {
          fg = function(buffer) return fg_color(buffer, colors) end,
          bg = function(buffer) return bg_color(buffer, colors) end,
        },
        components = {
          {
            text = "",
            bg = function(buffer) return bg_color(buffer, colors) end,
            fg = colors.Base,
          },
          {
            text = function(buffer) return " " .. buffer.devicon.icon .. " " end,
            fg = function(buffer) return buffer.devicon.color end,
          },
          {
            text = function(buffer) return buffer.index end,
            fg = function(buffer) return fg_color(buffer, colors) end,
            bold = function(buffer) return buffer.is_focused end,
          },
          {
            text = function(buffer) return " " .. buffer.filename .. " " end,
            bold = function(buffer) return buffer.is_focused end,
          },
          {
            text = "󰅖 ",
            on_click = function(_, _, _, _, buffer) buffer:delete() end,
            bold = function(buffer) return buffer.is_focused end,
          },
          {
            text = "",
            fg = function(buffer) return bg_color(buffer, colors) end,
            bg = colors.Base,
          },
        },
        sidebar = {
          filetype = { "NvimTree" },
        },
      })
    end,
  },
}
