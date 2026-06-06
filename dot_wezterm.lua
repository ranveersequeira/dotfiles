local wezterm = require 'wezterm'
return {
  adjust_window_size_when_changing_font_size = false,
  -- color_scheme = 'termnial.sexy',
  enable_tab_bar = false,
  default_prog = {
    "/bin/bash",
    "-lc",
    "$HOME/.local/bin/tmux-auto-session",
  },

  window_close_confirmation = "NeverPrompt",
  -- macos_window_background_blur = 40,
  macos_window_background_blur = 30,
  colors = {
    foreground = "#ebdbb2",
    background = "#282828",

    ansi = {
      "#282828",
      "#cc241d",
      "#98971a",
      "#d79921",
      "#458588",
      "#b16286",
      "#689d6a",
      "#a89984",
    },

    brights = {
      "#928374",
      "#fb4934",
      "#b8bb26",
      "#fabd2f",
      "#83a598",
      "#d3869b",
      "#8ec07c",
      "#ebdbb2",
    },
  },

  -- Force rendering
  bold_brightens_ansi_colors = true,

  -- Make background obvious
  window_background_opacity = 1.0,

  -- Disable anything that could hide colors
  window_background_image = nil,

  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size = 15.0,

  -- window_background_image = '/Users/omerhamerman/Downloads/3840x1080-Wallpaper-041.jpg',
  -- window_background_image_hsb = {
  -- 	brightness = 0.01,
  -- 	hue = 1.0,
  -- 	saturation = 0.5,
  -- },
  -- window_background_opacity = 0.92,
  -- window_background_opacity = 0.78,
  -- window_background_opacity = 0.20,
  window_decorations = 'RESIZE',
  keys = {
    -- Fullscreen
    {
      key = 'q',
      mods = 'CTRL',
      action = wezterm.action.ToggleFullScreen,
    },

    -- Clear scrollback
    {
      key = '\'',
      mods = 'CTRL',
      action = wezterm.action.ClearScrollback 'ScrollbackAndViewport',
    },

    -- === Tabs (Vim-style) ===

    -- New tab
    {
      key = 't',
      mods = 'CTRL',
      action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },

    -- Move to previous tab (vim h)
    {
      key = 'h',
      mods = 'CTRL',
      action = wezterm.action.ActivateTabRelative(-1),
    },

    -- Move to next tab (vim l)
    {
      key = 'l',
      mods = 'CTRL',
      action = wezterm.action.ActivateTabRelative(1),
    },

    -- Close current tab (vim-like)
    {
      key = 'w',
      mods = 'CTRL',
      action = wezterm.action.CloseCurrentTab { confirm = true },
    }, {
    key = ',',
    mods = 'CTRL',
    action = wezterm.action.SplitHorizontal {
      domain = 'CurrentPaneDomain',
    },
  },

    -- Vertical split (left/right)
    {
      key = '/',
      mods = 'CTRL',
      action = wezterm.action.SplitVertical {
        domain = 'CurrentPaneDomain',
      },
    }, {
    key = 'LeftArrow',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
    {
      key = 'RightArrow',
      mods = 'CTRL',
      action = wezterm.action.ActivatePaneDirection 'Right',
    },
    {
      key = 'UpArrow',
      mods = 'CTRL',
      action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
      key = 'DownArrow',
      mods = 'CTRL',
      action = wezterm.action.ActivatePaneDirection 'Down',
    },
  },
  mouse_bindings = {
    -- Ctrl-click will open the link under the mouse cursor
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
  },
}
