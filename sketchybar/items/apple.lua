local settings = require("config.settings")

local apple = sbar.add("item", "apple", {
	icon = {
		string = settings.icons.text.apple,
		color = settings.colors.with_alpha(settings.colors.green, 0.5),
		y_offset = 1,
	},
	label = { drawing = false },
	background = {
		-- color = settings.colors.with_alpha(settings.colors.purple, 0.5),
		corner_radius = 1,
		padding_right = 0,
	},
	click_script = "$CONFIG_DIR/items/menus/bin/menus -s 0",
})
