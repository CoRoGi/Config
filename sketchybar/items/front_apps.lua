local constants = require("constants")
local settings = require("config.settings")

local frontApps = {}

-- local frontBracket = sbar.add("bracket", frontApps, {
-- 	background = {
-- 		drawing = true,
-- 		color = settings.colors.bg1,
-- 	},
-- })
-- sbar.add(
-- 	"bracket",
-- 	constants.items.FRONT_APPS,
-- 	{},
-- 	{ position = "center", background = { color = settings.colors.bg1 } }
-- )

local frontAppWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

local function selectFocusedWindow(frontAppName)
	for appName, app in pairs(frontApps) do
		local isSelected = appName == frontAppName
		local color = isSelected and settings.colors.with_alpha(settings.colors.orange, 0.9)
				or settings.colors.with_alpha(settings.colors.dark_blue, 0.5)
		sbar.animate("linear", 75, function()
			app:set({
				label = { color = color },
				icon = { color = color },
			})
		end)
	end
end

local function updateWindows(windows)
	sbar.remove("/" .. constants.items.FRONT_APPS .. "\\.*/")

	sbar.animate("linear", 75, function()
		sbar.set("appBracket", {
			y_offset = 70,
			-- label = {
			-- 	string = windowName,
			-- 	width = "dynamic",
			-- },
			-- icon = {
			-- 	string = icon,
			-- 	width = 30,
			-- },
		})
	end)

	frontApps = {}
	local foundWindows = string.gmatch(windows, "[^\n]+")
	for window in foundWindows do
		local parsedWindow = {}
		for key, value in string.gmatch(window, "(%w+)=([%w%s]+)") do
			parsedWindow[key] = value
		end

		local windowId = parsedWindow["id"]
		local windowName = parsedWindow["name"]
		local icon = settings.icons.apps[windowName] or settings.icons.apps["default"]

		frontApps[windowName] = sbar.add("item", constants.items.FRONT_APPS .. "." .. windowName, {
			position = "center",
			y_offset = 70,
			label = {
				y_offset = 1,
				padding_left = 0,
				padding_right = 10,
				string = windowName,
				width = "dynamic",
			},
			icon = {
				string = icon,
				padding_left = 10,
				font = settings.fonts.icons(),
				width = 0,
			},
			-- background = {
			-- 	drawing = true,
			-- 	color = settings.colors.with_alpha(settings.colors.other_purple, 0.7),
			-- 	corner_radius = 1,
			-- },
			click_script = "aerospace focus --window-id " .. windowId,
		})

		sbar.animate("tanh", 120, function()
			sbar.set(constants.items.FRONT_APPS .. "." .. windowName, {
				y_offset = 0,
				label = {
					string = windowName,
					width = "dynamic",
				},
				icon = {
					string = icon,
					width = 30,
				},
			})
		end)

		frontApps[windowName]:subscribe(constants.events.FRONT_APP_SWITCHED, function(env)
			selectFocusedWindow(env.INFO)
		end)
	end

	sbar.exec(constants.aerospace.GET_CURRENT_WINDOW, function(frontAppName)
		selectFocusedWindow(frontAppName:gsub("[\n\r]", ""))
	end)

	sbar.remove("appBracket")

	local appBracket = sbar.add("bracket", "appBracket", { "/" .. constants.items.FRONT_APPS .. "\\..*/" }, {
		updates = true,
		drawing = true,
		y_offset = 0,
	})

	sbar.animate("circ", 45, function()
		sbar.set("appBracket", {
			y_offset = 70,
			-- label = {
			-- 	string = windowName,
			-- 	width = "dynamic",
			-- },
			-- icon = {
			-- 	string = icon,
			-- 	width = 30,
			-- },
		})
		sbar.set("appBracket", {
			y_offset = 0,

			background = {
				color = settings.colors.with_alpha(settings.colors.black, 1.0),
				drawing = true,
				height = 35,
				border_color = settings.colors.with_alpha(settings.colors.orange, 0.5),
				border_width = 2,
				corner_radius = 36,
			},
			-- label = {
			-- 	string = windowName,
			-- 	width = "dynamic",
			-- },
			-- icon = {
			-- 	string = icon,
			-- 	width = 30,
			-- },
		})
	end)
	-- sbar.add(frontBracket)
	-- frontBracket:set({
	-- 	background = {
	-- 		color = settings.colors.bg1,
	-- 		height = 30,
	-- 		width = 50,
	-- 	},
	-- })
end

local function getWindows()
	sbar.exec(constants.aerospace.LIST_WINDOWS, updateWindows)
end

frontAppWatcher:subscribe(constants.events.UPDATE_WINDOWS, function()
	getWindows()
end)

getWindows()
