hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 20,

		border_size = 2,

		col = {
			active_border = "rgb(787c99)",
			inactive_border = "rgba(0a0a0ddb)",
		},

		-- if true, will not fall back to the next available window
		-- when moving focus in a direction where no window was found
		no_focus_fallback = true,
		layout = "scrolling",
	},

	dwindle = {
		preserve_split = true, -- You probably want this
	},

	master = {
		new_status = "master",
	},

	scrolling = {
		fullscreen_on_one_column = true,
	},

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		focus_on_activate = true,

		-- Disable "App not responding" dialog
		enable_anr_dialog = false,
	},

	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	},

	xwayland = {
		enabled = true,
		force_zero_scaling = true,
	},
})
