return {
  "goolord/alpha-nvim",
  config = function()
    local terminalSection = require("vycros.plugins.homescreen.terminal")
    local buttonsSection = require("vycros.plugins.homescreen.buttons")
    local footerSection = require("vycros.plugins.homescreen.footer")
    local getArt = require("vycros.plugins.homescreen.chooseart")
    local choosenArt = getArt()
    -- Alpha imports
    require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    require("alpha.term")

    if choosenArt.type == "gif" then
      local filePath = os.getenv("HOME")
        .. "/.config/nvim/lua/vycros/plugins/homescreen/"
        .. choosenArt.ascii
      dashboard.opts.opts.noautocmd = true
      dashboard.section.terminal = terminalSection(dashboard.section.terminal, choosenArt, filePath)
    -- dashboard.section.terminal.opts.window_config.border = "single"
    else
      dashboard.section.header.opts = {
        position = "center",
        hl = "Text",
      }
      dashboard.opts.opts.noautocmd = false
      dashboard.section.header.type = choosenArt.type
      dashboard.section.header.val = choosenArt.ascii
    end

    dashboard.section.buttons.val = buttonsSection(dashboard)

    vim.api.nvim_create_autocmd("User", {
      callback = function() footerSection(dashboard) end,
    })

    dashboard.opts.layout = {
      choosenArt.type == "gif" and { type = "padding", val = 1 } or { type = "padding", val = 10 },
      choosenArt.type == "gif" and dashboard.section.terminal or dashboard.section.header,
      { type = "padding", val = 1 },
      dashboard.section.buttons,
      dashboard.section.footer,
    }

    require("alpha").setup(dashboard.opts)
  end,
}
