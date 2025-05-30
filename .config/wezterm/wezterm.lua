local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font",
	"Fira Code",
})
config.font_size = 13

config.color_scheme = "Catppuccin Mocha"

config.default_prog = { "zsh" }

config.front_end = "WebGpu"

config.leader = { key = "b", mods = "ALT", timeout_milliseconds = 2000 }

config.window_padding = {
	top = 0,
	left = 0,
	right = 0,
	bottom = 0,
}

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.tab_and_split_indices_are_zero_based = false

config.window_close_confirmation = "NeverPrompt"

config.warn_about_missing_glyphs = false

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_domain = 'WSL:NixOS'
end

return config
