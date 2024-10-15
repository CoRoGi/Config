local settings = require("config.settings")

local apple = sbar.add("item", "apple", {
	icon = {
		string = settings.icons.text.apple,
		color = settings.colors.with_alpha(settings.colors.orange, 0.6),
		y_offset = 2,
	},
	label = { drawing = false },
	background = {
		color = settings.colors.with_alpha(settings.colors.other_purple, 0.0),
		corner_radius = 1,
		padding_left = 1,
		padding_right = 0,
	},
	click_script = "$CONFIG_DIR/items/menus/bin/menus -s 0",
})
