local function bg_color(buffer, colors) return buffer.is_focused and colors.Base or colors.Base end
local function fg_color(buffer, colors) return buffer.is_focused and colors.Text0 or colors.Subtext0 end
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
            -- text = "",
            text = "|",
            bg = function(buffer) return bg_color(buffer, colors) end,
            fg = colors.Text0,
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
          filetype = { "NvimTree", "neo-tree" },
          components = {
            {
              text = function(buf) return buf.filetype end,
              fg = colors.Red,
              bg = colors.Base,
              -- bg = function() return get_hex("NvimTreeNormal", "bg") end,
              bold = false,
            },
          },
        },
      })

      local map = vim.api.nvim_set_keymap

      map("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
      map("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
      map("n", "<Leader><", "<Plug>(cokeline-switch-prev)", { silent = true })
      map("n", "<Leader>>", "<Plug>(cokeline-switch-next)", { silent = true })
      map("n", "<Leader>q", ":bd<CR>", { silent = true })

      for i = 1, 9 do
        map("n", ("<F%s>"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true })
        map(
          "n",
          ("<Leader><F%s>"):format(i),
          ("<Plug>(cokeline-switch-%s)"):format(i),
          { silent = true }
        )
      end
    end,
  },
}
