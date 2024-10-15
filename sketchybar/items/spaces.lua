local constants = require("constants")
local settings = require("config.settings")

local spaces = {}

local swapWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

local currentWorkspaceWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

local windowWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

-- https://www.nerdfonts.com/cheat-sheet
local spaceConfigs = {
	["1"] = { icon = "", name = "" },
	["2"] = { icon = "", name = "" },
	["3"] = { icon = "", name = "" },
	["4"] = { icon = "", name = "" },
	["5"] = { icon = "", name = "" },
	["6"] = { icon = "", name = "" },
	["7"] = { icon = "", name = "" },
	["8"] = { icon = "", name = "" },
	["9"] = { icon = "", name = "" },
	["10"] = { icon = "", name = "" },
}

local tempSpaces = {
	["1"] = { icon = "", name = "" },
	["2"] = { icon = "", name = "" },
	["3"] = { icon = "", name = "" },
	["4"] = { icon = "", name = "" },
	["5"] = { icon = "", name = "" },
	["6"] = { icon = "", name = "" },
	["7"] = { icon = "", name = "" },
	["8"] = { icon = "", name = "" },
	["9"] = { icon = "", name = "" },
	["10"] = { icon = "", name = "" },
}

local function selectCurrentWorkspace(focusedWorkspaceName)
	for sid, item in pairs(spaces) do
		if item ~= nil then
			local isSelected = sid == constants.items.SPACES .. "." .. focusedWorkspaceName

			sbar.animate("linear", 150, function()
				item:set({
					icon = {
						-- string = isSelected and focusedWorkspaceName,
						color = isSelected and settings.colors.with_alpha(settings.colors.cyan, 0.7)
								or settings.colors.with_alpha(settings.colors.cyan, 0.4),
					},
					label = {
						color = isSelected and settings.colors.with_alpha(settings.colors.orange, 0.6)
								or settings.colors.with_alpha(settings.colors.dark_blue, 0.7),
					},
					background = {
						color = isSelected and settings.colors.with_alpha(settings.colors.dark_blue, 0.0)
								or settings.colors.with_alpha(settings.colors.other_purple, 0.0),
						border_color = isSelected and settings.colors.with_alpha(settings.colors.orange, 0.5)
								or settings.colors.with_alpha(settings.colors.other_purple, 0.0),
						border_width = isSelected and 2 or 0,
					},
				})
			end)
		end
	end

	local spaceBracket = sbar.add("bracket", "spaceBracket", { "/" .. constants.items.SPACES .. "\\..*/", "apple" }, {
		updates = true,
		drawing = true,
		background = {
			color = settings.colors.black,
			drawing = true,
			height = 35,
			border_color = settings.colors.with_alpha(settings.colors.dark_blue, 0.7),
			border_width = 2,
			corner_radius = 36,
			padding_left = 0,
		},
	})
end

local function findAndSelectCurrentWorkspace()
	sbar.exec(constants.aerospace.GET_CURRENT_WORKSPACE, function(focusedWorkspaceOutput)
		local focusedWorkspaceName = focusedWorkspaceOutput:match("[^\r\n]+")
		selectCurrentWorkspace(focusedWorkspaceName)
	end)
end

local function addWorkspaceItem(workspaceName)
	local spaceName = constants.items.SPACES .. "." .. workspaceName
	local spaceConfig = spaceConfigs[workspaceName]

	spaces[spaceName] = sbar.add("item", spaceName, {
		label = {
			width = "dynamic",
			padding_left = 0,
			padding_right = 8,
			string = spaceConfig.icon,
			font = settings.fonts.icons(12.0),
		},
		icon = {
			string = workspaceName,
			y_offset = 3,
			padding_right = 8,
			color = settings.colors.blue,
		},
		-- background = {
		-- 	color = settings.colors.transparent,
		-- 	corner_radius = 1,
		-- 	padding_left = 0,
		-- 	padding_right = 0,
		-- },
		click_script = "aerospace workspace " .. workspaceName,
	})

	spaces[spaceName]:subscribe("mouse.entered", function(env)
		sbar.animate("tanh", 30, function()
			spaces[spaceName]:set({ label = { width = "dynamic" } })
		end)
	end)

	sbar.add("item", spaceName .. ".padding", {
		width = 0,
	})
end

local function getWorkspaceWindows(workspaceName)
	sbar.exec(
		"aerospace list-windows --workspace "
		.. workspaceName
		.. " | awk -F '|' '{gsub(/^ +| +$/, \"\", $2); print $2}' ",
		function(windows)
			for window in windows:gmatch("[^\r\n]+") do
				spaceConfigs[workspaceName].icon = spaceConfigs[workspaceName].icon
						.. settings.icons.apps[window]
						.. " "
			end
			local keys = {}
			for key in pairs(spaceConfigs) do
				table.insert(keys, key)
			end
			table.sort(keys, function(a, b)
				return tonumber(a) < tonumber(b)
			end)
			for _, key in ipairs(keys) do
				addWorkspaceItem(key)
			end
		end
	)
end

local function updateWorkspaceWindows(workspaceName, focusedWorkspace)
	sbar.exec(
		"aerospace list-windows --workspace "
		.. workspaceName
		.. " | awk -F '|' '{gsub(/^ +| +$/, \"\", $2); print $2}' ",
		function(windows)
			for window in windows:gmatch("[^\r\n]+") do
				tempSpaces[workspaceName].icon = tempSpaces[workspaceName].icon .. settings.icons.apps[window] .. " "
			end
			local keys = {}
			for key in pairs(tempSpaces) do
				table.insert(keys, key)
			end
			for sid, key in ipairs(keys) do
				local spaceName = constants.items.SPACES .. "." .. key
				sbar.animate("circ", 30, function()
					if tempSpaces[key].icon == "" then
						spaces[spaceName]:set({
							width = 0,
							padding_right = 0,
							padding_left = 0,
							icon = { string = "", padding_right = 0 },
							label = { string = "", padding_right = 0 },
							background = { padding_right = 0 },
						})
					else
						spaces[spaceName]:set({
							width = "dynamic",
							-- padding_right = 2,
							icon = { string = key, padding_right = 8 },
							label = { string = tempSpaces[key].icon, width = "dynamic", padding_right = 8 },
							background = { padding_right = 0 },
							y_offset = 30,
						})
						spaces[spaceName]:set({
							y_offset = 0,
						})
					end
				end)
				-- if tempSpaces[key].icon == "" then
				-- 	spaces[spaceName]:set({
				-- 		width = 0,
				-- 		icon = { string = "" },
				-- 		label = { string = "" },
				-- 	})
				-- end
			end
		end
	)
end

local function createWorkspaces()
	sbar.exec(constants.aerospace.LIST_ALL_WORKSPACES, function(workspacesOutput)
		for workspaceName in workspacesOutput:gmatch("[^\r\n]+") do
			getWorkspaceWindows(workspaceName)
		end

		findAndSelectCurrentWorkspace()

		-- local spaceBracket = sbar.add("bracket", { "/" .. constants.items.SPACES .. "\\..*/" }, {
		-- 	updates = true,
		-- 	drawing = true,
		-- 	background = {
		-- 		color = settings.colors.bg1,
		-- 		drawing = true,
		-- 		height = 30,
		-- 		width = 30,
		-- 		border_color = settings.colors.blue,
		-- 		border_radius = 8,
		-- 	},
		-- })
	end)
end

swapWatcher:subscribe(constants.events.SWAP_MENU_AND_SPACES, function(env)
	local isShowingSpaces = env.isShowingMenu == "off" and true or false
	sbar.set("/" .. constants.items.SPACES .. "\\..*/", { drawing = isShowingSpaces })
end)

currentWorkspaceWatcher:subscribe(constants.events.AEROSPACE_WORKSPACE_CHANGED, function(env)
	selectCurrentWorkspace(env.FOCUSED_WORKSPACE)
end)

windowWatcher:subscribe(constants.events.UPDATE_WINDOWS, function(env)
	sbar.exec(constants.aerospace.LIST_ALL_WORKSPACES, function(workspacesOutput)
		tempSpaces = {
			["1"] = { icon = "", name = "" },
			["2"] = { icon = "", name = "" },
			["3"] = { icon = "", name = "" },
			["4"] = { icon = "", name = "" },
			["5"] = { icon = "", name = "" },
			["6"] = { icon = "", name = "" },
			["7"] = { icon = "", name = "" },
			["8"] = { icon = "", name = "" },
			["9"] = { icon = "", name = "" },
			["10"] = { icon = "", name = "" },
		}
		for workspaceName in workspacesOutput:gmatch("[^\r\n]+") do
			updateWorkspaceWindows(workspaceName, env.FOCUSED_WORKSPACE)
		end
	end)
	-- spaceBracket:set({
	-- 	background = {
	-- 		color = settings.colors.bg1,
	-- 		drawing = true,
	-- 		height = 30,
	-- 		width = 30,
	-- 		border_color = settings.colors.blue,
	-- 		border_radius = 8,
	-- 	},
	-- })
end)

createWorkspaces()
