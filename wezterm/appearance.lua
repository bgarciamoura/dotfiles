local wezterm = require 'wezterm'

local neofusion_theme = {
  foreground = "#e0d9c7",
  background = "#070f1c",
  cursor_bg = "#e0d9c7",
  cursor_border = "#e0d9c7",
  cursor_fg = "#070f1c",
  selection_bg = "#ea6847",
  selection_fg = "#e0d9c7",
  ansi = {
    "#070f1c", -- Black (Host)
    "#ea6847", -- Red (Syntax string)
    "#ea6847", -- Green (Command)
    "#5db2f8", -- Yellow (Command second)
    "#6c6bfe", -- Blue (Path)
    -- "#2f516c", -- Blue (Path)
    "#d943a8", -- Magenta (Syntax var)
    "#86dbf5", -- Cyan (Prompt)
    "#e0d9c7", -- White
  },
  brights = {
    "#2f516c", -- Bright Black
    "#d943a8", -- Bright Red (Command error)
    "#ea6847", -- Bright Green (Exec)
    "#86dbf5", -- Bright Yellow
    "#5db2f8", -- Bright Blue (Folder)
    "#d943a8", -- Bright Magenta
    "#ea6847", -- Bright Cyan
    "#e0d9c7", -- Bright White
  },
}


return {
    -- Configuração da aparência
    font = wezterm.font("RobotoMono Nerd Font", {weight="Medium", stretch="Normal", style="Normal"}),
    font_size = 14,
    -- color_scheme = "Ayu Dark (Gogh)",
  
    -- Transparência
    window_background_opacity = 0.9,
    text_background_opacity = 0.9,

    -- Configuração da barra superior
    enable_tab_bar = true,
    tab_bar_at_bottom = true,
    hide_tab_bar_if_only_one_tab = true,
    tab_max_width = 20,
    colors = neofusion_theme,
    -- colors = {
    --     tab_bar = {
    --         background = "#282c34", -- Cor de fundo da barra de guias
    --         active_tab = {
    --             bg_color = "#61afef", -- Cor de fundo da guia ativa
    --             fg_color = "#282c34", -- Cor do texto da guia ativa
    --             intensity = "Normal", -- Intensidade do texto
    --             italic = false, -- Texto em itálico
    --         },
    --         inactive_tab = {
    --             bg_color = "#282c34", -- Cor de fundo da guia inativa
    --             fg_color = "#abb2bf", -- Cor do texto da guia inativa
    --             intensity = "Normal", -- Intensidade do texto
    --             italic = false, -- Texto em itálico
    --         },
    --         inactive_tab_hover = {
    --             bg_color = "#3e4452", -- Cor de fundo da guia inativa quando o mouse está sobre ela
    --             fg_color = "#61afef", -- Cor do texto da guia inativa quando o mouse está sobre ela
    --             intensity = "Normal", -- Intensidade do texto
    --             italic = false, -- Texto em itálico
    --         },
    --     }
    -- },

}
