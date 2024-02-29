return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local colors = require("vycros.core.colors")
    local theme = {
      normal = {
        a = { fg = colors.Text0, bg = colors.Surface0 },
        b = { fg = colors.Base, bg = colors.Lavender },
        c = { fg = colors.Text0, bg = colors.Base },
        z = { fg = colors.Text0, bg = colors.Base },
      },
      insert = { a = { fg = colors.Base, bg = colors.Lavender } },
      visual = { a = { fg = colors.Base, bg = colors.Peach } },
      replace = { a = { fg = colors.Base, bg = colors.Yellow } },
    }

    local empty = require("lualine.component"):extend()
    function empty:draw(default_highlight)
      self.status = ""
      self.applied_separator = ""
      self:apply_highlights(default_highlight)
      self:apply_section_separators()
      return self.status
    end

    -- Put proper separators and gaps between components in sections
    local function process_sections(sections)
      for name, section in pairs(sections) do
        local left = name:sub(9, 10) < "x"
        for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
          table.insert(section, pos * 2, { empty, color = { fg = colors.Base, bg = colors.Base } })
        end
        for id, comp in ipairs(section) do
          if type(comp) ~= "table" then
            comp = { comp }
            section[id] = comp
          end
          comp.separator = left and { right = "" } or { left = "" }
        end
      end
      return sections
    end

    local function search_result()
      if vim.v.hlsearch == 0 then return "" end
      local last_search = vim.fn.getreg("/")
      if not last_search or last_search == "" then return "" end
      local searchcount = vim.fn.searchcount({ maxcount = 9999 })
      return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
    end

    local function modified()
      if vim.bo.modified then
        return "+"
      elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        return "-"
      end
      return ""
    end

    local navic = require("nvim-navic")

    require("lualine").setup({
      options = {
        -- theme = "catppuccin",
        theme = theme,
        icons_enabled = true,
        disabled_filetypes = {
          statusline = { "NvimTree" },
        },
        section_separators = { left = "", right = "" },
        component_separators = "",
      },
      sections = process_sections({
        lualine_a = { "mode" },
        lualine_b = {
          { "branch", color = { bg = colors.Flamingo } },
          {
            "diff",
            colored = true,
            diff_color = {
              added = { bg = colors.Green, fg = colors.Overlay0 },
              modified = { bg = colors.Yellow, fg = colors.Overlay0 },
              removed = { bg = colors.Red, fg = colors.Overlay0 },
            },
          },
          {
            "diagnostics",
            source = { "nvim" },
            sections = { "error" },
            diagnostics_color = { error = { bg = colors.Red, fg = colors.Text0 } },
          },
          {
            "diagnostics",
            source = { "nvim" },
            sections = { "warn" },
            diagnostics_color = { warn = { bg = colors.Yellow, fg = colors.Overlay0 } },
          },
          { "filename", file_status = false, path = 1 },
          { modified, color = { bg = colors.Maroon } },
          {
            "%w",
            cond = function() return vim.wo.previewwindow end,
          },
          {
            "%r",
            cond = function() return vim.bo.readonly end,
          },
          {
            "%q",
            cond = function() return vim.bo.buftype == "quickfix" end,
          },
        },
        lualine_c = {},
        lualine_x = { "encoding" },
        lualine_y = { search_result, "filetype" },
        lualine_z = { "%l:%c", "%p%%/%L" },
      }),
      inactive_sections = {
        lualine_c = { "%f %y %m" },
        lualine_x = {},
      },
      tabline = {},
      winbar = {
        lualine_c = {
          { "navic", color_correction = nil, color = { bg = colors.Base, fg = colors.Text0 } },
        },
      },
      extensions = { "nvim-tree" },
    })
  end,
}
