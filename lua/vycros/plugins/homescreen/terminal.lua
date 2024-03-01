local function terminalSection(terminal, choosenArt, filePath)
  local scriptPath = os.getenv("HOME") .. "/.config/nvim/lua/vycros/plugins/homescreen/show_gif.sh"
  -- Check if the file is a gif or not
  if choosenArt.type == "gif" then
    TermCommand = "sh " .. scriptPath .. " " .. filePath
  else
    TermCommand = "cat " .. filePath
  end

  terminal.opts.redraw = true
  terminal.command = TermCommand
  terminal.width = choosenArt.width
  terminal.height = choosenArt.height

  return terminal
end

return terminalSection
