local function footerSection(dashboard)
  local stats = require("lazy").stats()
  local ms = math.floor(stats.startuptime * 100) / 100
  dashboard.section.footer.val = " "
    .. os.getenv("USER")
    .. " 󱑃 "
    .. os.date("%A, %d %B %Y")
    .. " "
    .. os.date("%H:%M")
    .. "\n    󱐌 Lazy-loaded "
    .. stats.loaded
    .. "/"
    .. stats.count
    .. " plugins in "
    .. ms
    .. "ms 󱐌"
  pcall(vim.cmd.AlphaRedraw)
end

return footerSection
