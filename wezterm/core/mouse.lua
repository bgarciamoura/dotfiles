return function(config, wezterm)
    config.mouse_bindings = {
        -- disable copy on selection
        {
          event = { Up = { streak = 1, button = "Left" } },
          mods = "NONE",
          action = wezterm.action.Nop,
        },
      }
end 