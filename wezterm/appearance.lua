local wezterm = require 'wezterm'

return {
    -- Configuração da aparência
    font = wezterm.font("RobotoMono Nerd Font", {weight="Medium", stretch="Normal", style="Normal"}),
    font_size = 14,
    color_scheme = "Ayu Dark (Gogh)",
  
    -- Transparência
    window_background_opacity = 0.9,
    text_background_opacity = 0.9,

    -- Configuração da barra superior
    enable_tab_bar = true,
    tab_bar_at_bottom = true,
    hide_tab_bar_if_only_one_tab = true,
    tab_max_width = 20,
    colors = {
        tab_bar = {
            background = "#282c34", -- Cor de fundo da barra de guias
            active_tab = {
                bg_color = "#61afef", -- Cor de fundo da guia ativa
                fg_color = "#282c34", -- Cor do texto da guia ativa
                intensity = "Normal", -- Intensidade do texto
                italic = false, -- Texto em itálico
            },
            inactive_tab = {
                bg_color = "#282c34", -- Cor de fundo da guia inativa
                fg_color = "#abb2bf", -- Cor do texto da guia inativa
                intensity = "Normal", -- Intensidade do texto
                italic = false, -- Texto em itálico
            },
            inactive_tab_hover = {
                bg_color = "#3e4452", -- Cor de fundo da guia inativa quando o mouse está sobre ela
                fg_color = "#61afef", -- Cor do texto da guia inativa quando o mouse está sobre ela
                intensity = "Normal", -- Intensidade do texto
                italic = false, -- Texto em itálico
            },
        }
    },

}
