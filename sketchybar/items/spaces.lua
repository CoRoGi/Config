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

			sbar.animate("tanh", 150, function()
				item:set({
					icon = {
						color = isSelected and settings.colors.with_alpha(settings.colors.magenta, 0.8)
							or settings.colors.with_alpha(settings.colors.purple, 0.7),
					},
					label = {
						color = isSelected and settings.colors.with_alpha(settings.colors.cyan, 0.8)
							or settings.colors.with_alpha(settings.colors.purple, 0.7),
					},
					background = {
						color = isSelected and settings.colors.with_alpha(settings.colors.red, 0.0)
							or settings.colors.with_alpha(settings.colors.other_purple, 0.0),
					},
				})
			end)
		end
	end
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
		background = {
			color = settings.colors.bg1,
		},
		click_script = "aerospace workspace " .. workspaceName,
	})

	spaces[spaceName]:subscribe("mouse.entered", function(env)
		sbar.animate("tanh", 30, function()
			spaces[spaceName]:set({ label = { width = "dynamic" } })
		end)
	end)

	sbar.add("item", spaceName .. ".padding", {
		width = settings.dimens.padding.label,
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

local function updateWorkspaceWindows(workspaceName)
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
			for _, key in ipairs(keys) do
				local spaceName = constants.items.SPACES .. "." .. key
				sbar.animate("linear", 5, function()
					spaces[spaceName]:set({ string = "", label = { width = 0 } })
					sbar.animate("tanh", 60, function()
						spaces[spaceName]:set({ label = { string = tempSpaces[key].icon, width = "dynamic" } })
					end)
				end)
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
	end)
end

swapWatcher:subscribe(constants.events.SWAP_MENU_AND_SPACES, function(env)
	local isShowingSpaces = env.isShowingMenu == "off" and true or false
	sbar.set("/" .. constants.items.SPACES .. "\\..*/", { drawing = isShowingSpaces })
end)

currentWorkspaceWatcher:subscribe(constants.events.AEROSPACE_WORKSPACE_CHANGED, function(env)
	selectCurrentWorkspace(env.FOCUSED_WORKSPACE)
end)

windowWatcher:subscribe(constants.events.UPDATE_WINDOWS, function()
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
			updateWorkspaceWindows(workspaceName)
		end
	end)
end)

createWorkspaces()
