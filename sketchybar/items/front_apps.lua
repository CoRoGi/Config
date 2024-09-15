local constants = require("constants")
local settings = require("config.settings")

local frontApps = {}

sbar.add("bracket", constants.items.FRONT_APPS, {}, { position = "left" })

local frontAppWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

local function selectFocusedWindow(frontAppName)
	for appName, app in pairs(frontApps) do
		local isSelected = appName == frontAppName
		local color = isSelected and settings.colors.with_alpha(settings.colors.cyan, 0.9)
			or settings.colors.with_alpha(settings.colors.green, 0.3)
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
			label = {
				y_offset = 1,
				padding_left = 0,
				string = "",
				width = 0,
			},
			icon = {
				string = "",
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

		sbar.animate("linear", 75, function()
			sbar.set(constants.items.FRONT_APPS .. "." .. windowName, {
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
end

local function getWindows()
	sbar.exec(constants.aerospace.LIST_WINDOWS, updateWindows)
end

frontAppWatcher:subscribe(constants.events.UPDATE_WINDOWS, function()
	getWindows()
end)

getWindows()
