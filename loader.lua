if not game:IsLoaded() then game.Loaded:Wait() end
local continuee = identifyexecutor() == "Krnl" or identifyexecutor() == "Synapse X" or queue_on_teleport
if identifyexecutor() == "WRD-API" then continuee = false end -- queue_on_teleport missing and errors
if continuee == false then -- https://pastebin.com/raw/SjcYQ23F
	local function a(...)return game:GetService(...)end;local b = loadstring(game:HttpGet("https://pastebin.com/raw/6EEJc0M5", true))()local c ="   " .. a("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "      THIS GUI WAS MADE BY SYNOLOPE"local d, e =b:AddWindow(c,{main_color = Color3.fromRGB(255, 0, 0),min_size = Vector2.new(550, 600),toggle_key = Enum.KeyCode.RightShift,can_resize = true})local f = d:AddTab("Error")f:AddLabel("Your executor is not supported. We recommend you to use KRNL or Synapse X!")f:AddLabel("Please rejoin and execute this script with supported executor.")f:Show()b:FormatWindows()
	return
end

function queueOnTeleport(str)
	if identifyexecutor() == "Synapse X" then
		pcall(function()
			syn.queue_on_teleport(str)
		end)
	else 
		local suc,err = pcall(function() queue_on_teleport(str) end)
		if err then
			print("Error occured, trying again...")
			pcall(function() queue_on_teleport(str) end)
		end
	end
end

if game.CreatorId == 123247 or game.PlaceId == 370731277 and continuee == true then
	local githublink = "https://raw.githubusercontent.com/synolope/mpcity/main/"
	local loaderurl = githublink .. "loader.lua"
	local uicheckurl = githublink .. "uicheck.lua"
	local scripturl = ""
	if identifyexecutor() == "Synapse X" then
		scripturl = githublink .. "synapse.lua"
	end
	if identifyexecutor() == "Krnl" or queue_on_teleport then
		scripturl = githublink .. "krnl.lua"
	end
	queueOnTeleport([[
    		wait(3)
			loadstring(game:HttpGet("]] .. uicheckurl .. [[",true))()
    		loadstring(game:HttpGet("]] .. loaderurl .. [[",true))()
	]])
	loadstring(game:HttpGet(uicheckurl, true))()
	loadstring(game:HttpGet(scripturl, true))()
else
	local function a(...)return game:GetService(...)end;local b = loadstring(game:HttpGet("https://pastebin.com/raw/6EEJc0M5", true))()local c ="   " .. a("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "      THIS GUI WAS MADE BY SYNOLOPE"local d, e =b:AddWindow(c,{main_color = Color3.fromRGB(255, 0, 0),min_size = Vector2.new(550, 600),toggle_key = Enum.KeyCode.RightShift,can_resize = true})local f = d:AddTab("Error")f:AddLabel("Wrong Game!")f:AddButton("Join Game",function()game:GetService("TeleportService"):Teleport("370731277")end)f:Show()b:FormatWindows()
	return
end
