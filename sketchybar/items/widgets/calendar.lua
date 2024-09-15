local constants = require("constants")
local settings = require("config.settings")

local calendar = sbar.add("item", constants.items.CALENDAR, {
	position = "right",
	update_freq = 1,
	color = settings.colors.blue,
	padding_right = 1,
	icon = {
		padding_left = 0,
		padding_right = 0,
	},
	background = {
		-- color = settings.colors.with_alpha(settings.colors.purple, 0.5),
		corner_radius = 1,
		padding_right = 5,
	},
})

calendar:subscribe({ "forced", "routine", "system_woke" }, function(env)
	calendar:set({
		label = {
			string = os.date("%a %d %b, %H:%M"),
			color = settings.colors.with_alpha(settings.colors.orange, 0.9),
			padding_right = 5,
		},
	})
end)

calendar:subscribe("mouse.clicked", function(env)
	sbar.exec("open -a 'Calendar'")
end)
