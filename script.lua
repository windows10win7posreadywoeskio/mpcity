local function service(...) return game:GetService(...) end
local Players = service("Players")
local MarketplaceService = service("MarketplaceService")
local ReplicatedStorage = service("ReplicatedStorage")
local HttpService = service("HttpService")

local Constants = require(ReplicatedStorage:WaitForChild("Constants"))
local Connection = ReplicatedStorage:WaitForChild("Connection")
local ConnectionEvent = ReplicatedStorage:WaitForChild("ConnectionEvent")

local function getservers()
    return Connection:InvokeServer(399)
end

local function joinserver(instid)
    return Connection:InvokeServer(400,instid)
end

local library = loadstring(game:HttpGet("https://pastebin.com/raw/6EEJc0M5",true))() -- https://pastebin.com/raw/SjcYQ23F

local Window = library:AddWindow(MarketplaceService:GetProductInfo(game.PlaceId).Name, {
	main_color = Color3.fromRGB(151, 85, 163),
	min_size = Vector2.new(500, 600),
	toggle_key = Enum.KeyCode.RightShift,
	can_resize = true,
})

local Avatar = Window:AddTab("Avatar")
local Servers = Window:AddTab("Servers")
local Extra = Window:AddTab("Extra")

local function ExtractData(humdes)
	local ava = {}
	local function colorToTable(clr) return {tostring(clr.R*255),tostring(clr.G*255),tostring(clr.B*255)} end

	for _,v in pairs({"WidthScale", "HeadScale","HeightScale","DepthScale","BodyTypeScale","ProportionScale"}) do
		ava[v] = humdes[v]
	end

	for _,v in pairs({"Face","Head","LeftArm","RightArm","LeftLeg","RightLeg","Torso"}) do
		ava[v] = humdes[v]
	end

	for _,v in pairs({"HeadColor","LeftArmColor","RightArmColor","LeftLegColor","RightLegColor","TorsoColor"}) do
		ava[v] = colorToTable(humdes[v])
	end

	for _,v in pairs({"GraphicTShirt","Shirt","Pants"}) do
		ava[v] = humdes[v]
	end

	for _,v in pairs({"ClimbAnimation","FallAnimation","IdleAnimation","JumpAnimation","RunAnimation","SwimAnimation","WalkAnimation"}) do
		ava[v] = humdes[v]
	end


	for _,v in pairs({"Hat","Hair","Back","Face","Front","Neck","Shoulders","Waist"}) do
		ava[v .. "Accessory"] = humdes[v .. "Accessory"]
	end

	ava.Emotes = humdes:GetEmotes()

	local layered = humdes:GetAccessories(false)

	for i,v in pairs(layered) do
		if v.AccessoryType and typeof(v.AccessoryType) == "EnumItem" then
			v.AccessoryType = v.AccessoryType.Name
		end
	end

	ava.AccessoryBlob = layered

	return ava
end

Avatar:AddLabel("Load Avatar")

Avatar:AddTextBox("Load Avatar From UserId",function(userid)
	if userid and tonumber(userid) and Players:GetHumanoidDescriptionFromUserId(tonumber(userid)) then
		local data = ExtractData(Players:GetHumanoidDescriptionFromUserId(tonumber(userid)))
		ConnectionEvent:FireServer(315,data,true)
	end
end)

Avatar:AddTextBox("Load Avatar From Username",function(username)
	if username and Players:GetUserIdFromNameAsync(username) then
		local data = ExtractData(Players:GetHumanoidDescriptionFromUserId(Players:GetUserIdFromNameAsync(username)))
		ConnectionEvent:FireServer(315,data,true)
	end
end)

local cliplabel = Avatar:AddLabel("")

local avatarclipboard = nil
local avatarclipboardname = "Unnamed"

local function copytoclip(data,name)
	if not data then
		avatarclipboard = nil
		avatarclipboardname = "Unnamed"
		cliplabel.Text = "Avatar Clipboard"
	else
		avatarclipboard = data
		avatarclipboardname = name
		cliplabel.Text = "Avatar Clipboard: " .. name
	end
end

local function LoadPlayer(player)
	coroutine.wrap(function()
		if player ~= Players.LocalPlayer then
			local function LoadCharacter(character)
				local prox = Instance.new("ProximityPrompt",character:WaitForChild("HumanoidRootPart"))
				prox.ActionText = "Copy Avatar To Clipboard"
				prox.ObjectText = player.DisplayName
				prox.KeyboardKeyCode = Enum.KeyCode.C
				prox.HoldDuration = .2
				prox.RequiresLineOfSight = false
				prox.Triggered:Connect(function()
					if character and character:FindFirstChild("Humanoid") and character.Humanoid:FindFirstChild("HumanoidDescription") then
						copytoclip(ExtractData(character.Humanoid.HumanoidDescription),player.DisplayName)
					end
				end)
			end
			LoadCharacter(player.Character or player.CharacterAdded:Wait())
			player.CharacterAdded:Connect(LoadCharacter)
		end
	end)()
end

for _,player in pairs(Players:GetPlayers()) do LoadPlayer(player) end
Players.PlayerAdded:Connect(LoadPlayer)

copytoclip()

local clipbuttons = Avatar:AddHorizontalAlignment()

clipbuttons:AddButton("Load Avatar",function()
    if avatarclipboard then
        ConnectionEvent:FireServer(315,avatarclipboard,true)
    end
end)

clipbuttons:AddButton("Save Avatar",function()
    if avatarclipboard then
		Connection:InvokeServer(65,avatarclipboardname)

		Connection:InvokeServer(319,avatarclipboard)
    end
end)

Avatar:AddLabel("Fun")

Avatar:AddButton("Big Head",function()
    local data = Connection:InvokeServer(Constants.AE_REQUEST_AE_DATA)
	local wearing = data.PlayerCurrentTemporaryOutfit or data.PlayerCurrentlyWearing
	wearing.HeadScale = 99999
	ConnectionEvent:FireServer(315,wearing,true)
end)

Avatar:AddButton("Small Head",function()
    local data = Connection:InvokeServer(Constants.AE_REQUEST_AE_DATA)
	local wearing = data.PlayerCurrentTemporaryOutfit or data.PlayerCurrentlyWearing
	wearing.HeadScale = 0
	ConnectionEvent:FireServer(315,wearing,true)
end)

Avatar:AddButton("Huge Scales",function()
    local data = Connection:InvokeServer(Constants.AE_REQUEST_AE_DATA)
	local wearing = data.PlayerCurrentTemporaryOutfit or data.PlayerCurrentlyWearing
	wearing.HeadScale = 99999
	wearing.BodyTypeScale = 99999
	wearing.DepthScale = 99999
	wearing.HeightScale = 99999
	wearing.ProportionScale = 99999
	wearing.WidthScale = 99999
	ConnectionEvent:FireServer(315,wearing,true)
end)

Avatar:AddButton("Small Scales",function()
    local data = Connection:InvokeServer(Constants.AE_REQUEST_AE_DATA)
	local wearing = data.PlayerCurrentTemporaryOutfit or data.PlayerCurrentlyWearing
	wearing.HeadScale = 0
	wearing.BodyTypeScale = 0
	wearing.DepthScale = 0
	wearing.HeightScale = 0
	wearing.ProportionScale = 0
	wearing.WidthScale = 0
	ConnectionEvent:FireServer(315,wearing,true)
end)

Servers:AddButton("Join Most Populated Server",function()
	local server = getservers()[1]
	joinserver(server.InstanceId)
end)

local function rnd()
    return math.random(-25,25)
end

local crazyloop = nil
local cameravec = Players.LocalPlayer:WaitForChild("Data"):WaitForChild("CameraVector")

Extra:AddSwitch("Go Crazy",function(bool)
    if bool then
        if crazyloop then
            crazyloop:Disconnect()
            crazyloop = nil
        end
        crazyloop = service("RunService").Heartbeat:Connect(function()
            local vec = Vector3.new(rnd(),rnd(),rnd())
            cameravec.Value = vec
            ConnectionEvent:FireServer(163, vec)
        end)
    else
        crazyloop:Disconnect()
        crazyloop = nil
    end
end)

Avatar:Show()
library:FormatWindows()