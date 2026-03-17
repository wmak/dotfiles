-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()
config.window_decorations = "RESIZE"
config.color_scheme = 'rose-pine-moon'
config.colors = {
	selection_fg = '#232136',
	selection_bg = '#56526e',
}
config.font = wezterm.font('Inconsolata-g for Powerline')
config.font_size = 16
config.tab_max_width = 100
-- config.enable_tab_bar = false
-- config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.keys = {
	{
		key = '-',
		mods = 'CTRL',
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = 'c',
		mods = 'CMD',
		action = wezterm.action_callback(function (window, pane)
			window:perform_action(act.ActivateCopyMode, pane)
		end)
	},
	{
		key = 'f',
		mods = 'CMD',
		action = wezterm.action_callback(function (window, pane)
			window:perform_action(act.Search 'CurrentSelectionOrEmptyString', pane)
			window:perform_action(act.Multiple { act.CopyMode 'ClearPattern', act.CopyMode 'ClearSelectionMode', act.CopyMode 'MoveToScrollbackBottom' }, pane)
		end),
	},
}

-- and finally, return the configuration to wezterm
return config
