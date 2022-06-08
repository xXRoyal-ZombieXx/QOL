--// Variables \\--
local plr = game.Players.LocalPlayer
local umc --Local User Map Marker Color
local fmc --Friend Marker Color
local unc --User Nameplate Color
local fnc --Friend Nameplate Color
local mapPath = plr.PlayerGui.GPS.GPSFrame.GPS.ViewportFrame
local nfolder = game:GetService("Workspace").Nameplates
local cpr = game:GetService("ContentProvider")
--// Functions \\--
function setPlayerMarkerColor(player,color)
    mapPath:FindFirstChild(tostring(player)).Icon.ImageColor3 = color
    mapPath.WorldModel.Markers:FindFirstChild(player.Name).Chevron.Color = color
end
function setPlayerNametagColor(player,color)
    local Nameplate = nfolder:FindFirstChild(tostring(player))
    Nameplate.Frame.CharacterName.TextColor3 = color
    Nameplate.AuxFrame.CharacterName.TextColor3 = color
end
function addCape(player)
    if player.Character:FindFirstChild("BottomCapePart") or player.Character:FindFirstChild("CapeHeadPart") then return end
    local cdid = 7094980593
    local BottomCapePart = Instance.new("Part",player.Character)
    BottomCapePart.Name = "BottomCapePart"
    BottomCapePart.Size = Vector3.new(.1,.1,.1)
    local CapeHeadPart = Instance.new("Part",player.Character)
    CapeHeadPart.Size = Vector3.new(.1,.1,.1)
    CapeHeadPart.Name = "CapeHeadPart"
    local a = Instance.new("Attachment")
    a.Name = "CapeAttachment"
    a.Position = Vector3.new(0, -2.5, 1.5)
    a.Orientation = Vector3.new(0, 0, 90)
    a.Parent = plr.Character.UpperTorso
    local b = Instance.new("Attachment")
    b.Name = "CapeAtch"
    b.Position = Vector3.new(0, .8, 0.4)
    b.Orientation = Vector3.new(0,0,90)
    b.Parent = plr.Character.UpperTorso
    local bal = Instance.new("Attachment",BottomCapePart)
    bal.Name = "bal"
    bal.Position = Vector3.new(0,0.125,0)
    bal.Orientation = Vector3.new(0,0,90)
    local cat = Instance.new("Attachment",CapeHeadPart)
    cat.Name = "cat"
    CapeHeadPart.cat.Position = Vector3.new(0,0,0.5)
    Instance.new("Beam",CapeHeadPart)
    CapeHeadPart.Beam.Attachment0 = CapeHeadPart.cat
    CapeHeadPart.Beam.Attachment1 = BottomCapePart.bal
    CapeHeadPart.Beam.Texture = "http://www.roblox.com/asset/?id="..cdid
    CapeHeadPart.Beam.Width0 = 2
    CapeHeadPart.Beam.Width1 = 2
    Instance.new("AlignOrientation",BottomCapePart)
    BottomCapePart.AlignOrientation.Attachment0 = BottomCapePart.bal
    BottomCapePart.AlignOrientation.Attachment1 = plr.Character.UpperTorso.CapeAttachment
    BottomCapePart.AlignOrientation.Responsiveness = 20
    Instance.new("AlignPosition",BottomCapePart)
    BottomCapePart.AlignPosition.Attachment0 = BottomCapePart.bal
    BottomCapePart.AlignPosition.Attachment1 = a
    BottomCapePart.AlignPosition.Position = a.WorldPosition
    BottomCapePart.AlignPosition.Responsiveness = 15
    Instance.new("BodyGyro",BottomCapePart)
    local const = Instance.new("RigidConstraint")
    const.Attachment0 = CapeHeadPart.cat
    const.Attachment1 = b
    const.Parent = CapeHeadPart
    CapeHeadPart.Anchored = false
    BottomCapePart.Anchored = false
    BottomCapePart.CanCollide = false
    BottomCapePart.CFrame = player.Character.HumanoidRootPart.CFrame
    CapeHeadPart.CanCollide = false
    BottomCapePart.Parent = player.Character
    CapeHeadPart.Parent = player.Character
    BottomCapePart.Transparency = 1
    CapeHeadPart.Transparency = 1
end
--// UI \\--
local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()
local GUI = Mercury:Create{
    Name = "Rocitizens QOL 2.0",
    Size = UDim2.fromOffset(800, 400),
    Theme = Mercury.Themes.Dark,
    Link = "https://github.com/deeeity/mercury-lib"
}
GUI:Credit{
	Name = "Soap",
	Description = "Made the script work",
	V3rm = "https://v3rmillion.net/member.php?action=profile&uid=775206",
	Discord = "Soap#0671"
}
GUI:set_status("Status | Connected")
local cosmetics = GUI:Tab{
    Name = "Cosmetics",
    Icon = "rbxassetid://9852011641"
}
local mapmenu = GUI:Tab{
	Name = "Map Settings",
	Icon = "rbxassetid://9852006826"
}
--// Cosmetics \\--
cosmetics:ColorPicker{
    Name = "Nametag Color",
	Style = Mercury.ColorPickerStyles.Legacy,
	Callback = function(color)
	    unc = color
	    setPlayerNametagColor(plr,color)
    end
}
cosmetics:ColorPicker{
    Name = "Friend Nametag Color",
	Style = Mercury.ColorPickerStyles.Legacy,
	Callback = function(color)
	    fnc = color
	    for i,v in pairs(game.Players:GetChildren()) do
	        spawn(function()
	            if v:IsFriendsWith(plr.UserId) then
	                setPlayerNametagColor(v,color)
	            end
	        end)
	    end
    end
}
cosmetics:Textbox{
	Name = "Cape Texture(Roblox Id)",
	Callback = function(text) 
	    local texture = "rbxthumb://type=Asset&id="..text.."&w=420&h=420"
		cpr:PreloadAsync({texture})
	    game.Players.LocalPlayer.Character.CapeHeadPart.Beam.Texture = texture
	end
}
cosmetics:Textbox{
    Name = "Cape Texture Length",
    Callback = function(txt)
        game.Players.LocalPlayer.Character.CapeHeadPart.Beam.TextureLength = tonumber(txt)    
    end
}
cosmetics:Textbox{
    Name = "Cape Texture Speed",
    Callback = function(txt)
        game.Players.LocalPlayer.Character.CapeHeadPart.Beam.TextureSpeed = tonumber(txt)    
    end
}
cosmetics:Textbox{
    Name = "Cape Transparency",
    Callback = function(txt)
        game.Players.LocalPlayer.Character.CapeHeadPart.Beam.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, tonumber(txt)),NumberSequenceKeypoint.new(1, tonumber(txt))}
    end
}
--// Map Settings \\--
mapmenu:ColorPicker{
    Name = "Your Marker Color",
	Style = Mercury.ColorPickerStyles.Legacy,
	Callback = function(color)
	    umc = color
	    setPlayerMarkerColor(plr,color)
    end
}
mapmenu:ColorPicker{
    Name = "Friend Marker Color",
	Style = Mercury.ColorPickerStyles.Legacy,
	Callback = function(color) 
	    fmc = color
	    for i,v in pairs(game.Players:GetChildren()) do
	        spawn(function()
	            if v:IsFriendsWith(plr.UserId) then
	                setPlayerMarkerColor(v,color)
	            end
	        end)
	    end
    end
}
--// Init \\--
addCape(plr)

plr.CharacterAdded:Connect(function()
    wait(5)
    addCape(plr)
end)
game.Players.PlayerAdded:Connect(function(player)
    if player:IsFriendsWith(plr.UserId) then
        setPlayerMarkerColor(player,fmc)
        setPlayerNametagColor(player,fnc)
    end
end)
