---@diagnostic disable: undefined-global, lowercase-global
if not game:IsLoaded() then
	game.Loaded:wait()
end

local annoying = {
    "MB_Sniper",
    "BlackShibe",
    "Armeraivis",
}

for i, player in pairs(game:GetService("Players"):GetPlayers()) do
    if player.Name == "BlackShibe" or player.Name == "MB_Sniper" or player.Name == "Armeraivis" then
    game.StarterGui:SetCore("SendNotification", {
            Title = "Warning!";
            Text = player.Name..", - A staff member is in the server";
            Duration = 20;
        })
    end
end


game.Players.PlayerAdded:Connect(function(plr)
for i, v in pairs(annoying) do
if plr.Name == v then
warn("A staff member joined")
wait(1.2)
game.StarterGui:SetCore("SendNotification", {
Title = "Warning!";
Text = plr.Name..", - A staff member has joined the server";
Duration = 20;
})
end
end
end)


for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
	if v.Name == "Login" then
		v:Destroy()
	end
end




local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("Login", 5013109572)

local ClosureCheck = is_synapse_function or is_protosmasher_closure or is_sirhurt_closure or issentinelclosure;
local function FindLocal(Name)
    local Matches = {};
    for i, v in pairs(getgc()) do
        if typeof(v) == "function" and not ClosureCheck(v) then
            if getinfo(v).Name == Name then
                Matches[i] = v;
            end;
        end;
    end;
    return Matches;
end;
function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

floatName = randomString()

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Players = game:GetService("Players")

local Client = Players.LocalPlayer
local Mouse = Client:GetMouse()
local Camera = game:GetService("Workspace"):FindFirstChildOfClass("Camera")

local AimbotEnabled = false
local AimbotActive = false
local VisibilityCheck = false
local TeamCheck = false
local ShowFOV = false
local AimingAt = nil
local Smoothness = 6
local MovementPrediction = false
local MovementPredictionStrength = 1
Clip = false

local FOV_Color = Color3.fromRGB(255, 255, 255)
local FOV_Size = 0

local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(0, 0)
FOVCircle.Radius = FOV_Size
FOVCircle.Thickness = 1
FOVCircle.Filled = false
FOVCircle.Transparency = 1
FOVCircle.Visible = true
FOVCircle.Color = FOV_Color

local function AimToPosition(Position)
	local AimX = ((Position.X - Mouse.X) + 0) / Smoothness 
    local AimY = ((Position.Y - Mouse.Y - 36) + 0) / Smoothness
    return AimX, AimY
end

local function InitAimbot()
    if game:GetService("Workspace"):FindFirstChildOfClass("Camera") then
        local Camera = game:GetService("Workspace"):FindFirstChildOfClass("Camera")
    end
    local ScreenSize = Camera.ViewportSize
    if FOVCircle then
        FOVCircle.Radius = FOV_Size
        FOVCircle.Visible = ShowFOV
		FOVCircle.Color = FOV_Color
		FOVCircle.Transparency = 1
		FOVCircle.Filled = false
        FOVCircle.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
    end
    if AimbotEnabled == false then return end
    if AimbotActive == true then
        local Closest = {nil, nil, nil, nil, nil}
        for i, v in pairs(Players:GetChildren()) do
            pcall(function()
                if v.Character and v ~= Client then
                    local HumanoidHealth = nil
                    if v.Character:FindFirstChildOfClass("Humanoid") ~= nil then
                        HumanoidHealth = v.Character:FindFirstChildOfClass("Humanoid").Health
                    end
                    if HumanoidHealth == nil or HumanoidHealth > 0 then
                        local PlayerRoot = v.Character:FindFirstChild("HumanoidRootPart") or v.Character:FindFirstChild("Torso")
                        local PlayerHead = v.Character:FindFirstChild("Head") or PlayerRoot
                        local PlayerScreen, InFOV = Camera:WorldToViewportPoint(PlayerRoot.Position)
                        local DistanceFromCenter = 0
                        DistanceFromCenter = (Vector2.new(PlayerScreen.X, PlayerScreen.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
                        if (InFOV == true and DistanceFromCenter < FOV_Size) or AimingAt == v then
                            if AimingAt == v then
                                DistanceFromCenter = 0
                            end
                            if (TeamCheck == true and v.Team ~= Client.Team) or TeamCheck == false then
                                local Obscuring = false
                                if VisibilityCheck == true then
                                	local Parts = Camera:GetPartsObscuringTarget({Client.Character.Head.Position, PlayerHead.Position}, {Camera, Client.Character})
                                	for i2, v2 in pairs(Parts) do
                                    if v2:IsDescendantOf(v.Character) == false and v2.Transparency == 0 then
                                            Obscuring = true
                                        end
                                    end
                                end
                                if Obscuring == false and ((Closest[1] ~= nil and DistanceFromCenter < Closest[1]) or Closest[1] == nil) then
                                    if Closest[1] == nil or (DistanceFromCenter < Closest[1]) then
                                        local Prediction = Vector3.new(0, 0, 0)
                                        if MovementPrediction == true then
                                            Prediction = PlayerRoot.Velocity * (MovementPredictionStrength / 10) * (Client.Character.Head.Position - PlayerHead.Position).magnitude / 100
                                        end
                                        Closest[1] = DistanceFromCenter
                                        local PlayerAim = nil
                                        if AimPart == "Torso" then
                                            PlayerAim = v.Character:FindFirstChild("HumanoidRootPart") or v.Character:FindFirstChild("Torso")
                                        else
                                            PlayerAim = v.Character.Head
                                        end
                                        Closest[2] = PlayerAim
                                        Closest[3] = Vector2.new(PlayerScreen.X, PlayerScreen.Y)
                                        Closest[4] = Prediction
                                        Closest[5] = v
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
        if Closest[1] ~= nil and Closest[2] ~= nil and Closest[3] ~= nil and Closest[4] ~= nil and Closest[5] ~= nil then
            pcall(function()
                local AimAt = Camera:WorldToViewportPoint(Closest[2].Position + Closest[4])
                mousemoverel(AimToPosition(Vector2.new(AimAt.X, AimAt.Y)))
                AimingAt = Closest[5]
            end)
        else
            AimingAt = nil
        end
    end
end
loadstring(game:HttpGet("https://pastebin.com/raw/06MMJp4c", true))()
local ESP = shared.uESP
ESP.Enabled = false
ESP.Settings.Box3D = false
ESP.Settings.DrawTracers = false
ESP.Settings.DrawDistance = false
ESP.Settings.DrawNames = false
ESP.Settings.TextOutline = false
ESP.Settings.VisibilityCheck = false
ESP.Settings.TeamColor = Color3.fromRGB(0, 255, 127)
ESP.Settings.EnemyColor = Color3.fromRGB(246, 46, 25)

local themes = {
Background = Color3.fromRGB(24, 24, 24),
Glow = Color3.fromRGB(0, 0, 0),
Accent = Color3.fromRGB(10, 10, 10),
LightContrast = Color3.fromRGB(20, 20, 20),
DarkContrast = Color3.fromRGB(14, 14, 14),  
TextColor = Color3.fromRGB(255, 255, 255)
}

local ex = venyx:addPage("Exploits", 5012544693)
local page = venyx:addPage("Rage", 5012544693)
local vis = venyx:addPage("Visuals", 5012544693)
local menu = venyx:addPage("Misc", 5012544693)
local section1 = page:addSection("Aimbot")
local section2 = menu:addSection("Menu")
local expl = ex:addSection("Exploits")
local pp = vis:addSection("ESP")

section1:addToggle("Aimbot", nil, function(State)
	AimbotEnabled = State
    venyx:Notify("aimbot", value)
end)
section1:addToggle("Movement Prediction",nil, function(State)
	MovementPredicition = State
end)
section1:addSlider("Movement Prediction Strength",0, 0, 100, function(State)
	MovementPredictionStrength = State
end)
section1:addToggle("Team Check",nil, function(State)
	TeamCheck = State
end)
section1:addToggle("Visibility Check",nil, function(State)
	VisibilityCheck = State
end)
section1:addToggle("Show FOV Cirlce",nil, function(State)
	ShowFOV = State
end)
section1:addSlider("Field Of View", 0, 0, 200, function(State)
	FOV_Size = State
end)
section1:addToggle("Triggerbot", nil, function(State)
    local LocalPlayer = game:GetService("Players").LocalPlayer
	local Mouse = LocalPlayer:GetMouse()

	while true do
    	for i, v in pairs(game:GetService("Players"):GetChildren()) do 
        	if (State and TeamCheck) and Mouse.Target.Parent == v.Character and Mouse.Target:IsA("Part" or "BasePart") and v.Team ~= LocalPlayer.Team then 
            	mouse1press()
            	wait()
            	mouse1release()
        	elseif (State and not TeamCheck) and Mouse.Target.Parent == v.Character and Mouse.Target:IsA("Part" or "BasePart") then
            	mouse1press()
            	wait()
            	mouse1release()
        	end
    	end
		wait()
	end
end)
section1:addDropdown("Aim Part", {"Head", "Torso"}, function(State)
    if State == "Head" then
        AimPart = "Head"
    elseif State == "Torso" then
        AimPart = "Torso"
    end
end)
section1:addColorPicker("Circle Color", Color3.fromRGB(255, 255, 255), function(State)
    FOV_Color = State
end)

UserInputService.InputBegan:Connect(function(Input, GPE)
    if GPE or AimbotEnabled == false then return end
    if Input.UserInputType == Enum.UserInputType.F then
        AimbotActive = true
    end
end)

UserInputService.InputEnded:Connect(function(Input, GPE)
    if GPE or AimbotEnabled == false then return end
    if Input.UserInputType == Enum.UserInputType.F then
        AimbotActive = false
        AimingAt = nil
    end
end)

RunService:BindToRenderStep("InitAimbot", 1, InitAimbot)





section2:addKeybind("Open Key", Enum.KeyCode.Insert, function()
venyx:toggle()
end, function()
end)
section2:addKeybind("Noclip Key", Enum.KeyCode.Delete, function(callback)
    if Clip == false then
        Clip = true
   else
       Clip = false
   end
end, function()
end)
section2:addKeybind("Rejoin Key", Enum.KeyCode.End, function()
    if #Players:GetPlayers() <= 1 then
		Players.LocalPlayer:Kick("\nRejoining...")
		wait()
		game:GetService('TeleportService'):Teleport(game.PlaceId, Players.LocalPlayer)
	else
		game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
	end
end, function()
end)

lool = 1
expl:addToggle("No Fall", nil, function (value)
    --no fall damage
if value == true then
    local mt = getrawmetatable(game)
make_writeable(mt)

local namecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if method == "FireServer" and tostring(self) == "ow" then
       return
    end
    return namecall(self, table.unpack(args))
end)
end
end)
expl:addToggle("No Sway", nil, function(value)
    sway = value
    local str = 'bobbing_speed'
    local str3 = 'swayModifiers'
    local str4 = 'directionalFiring'
    for i,v in pairs(getgc(true)) do
        if type(v) == 'table' and rawget(v, str) then
            v[str].none = 0
            v[str].aiming = 0
            v[str].prone = 0
            v[str].proneaiming = 0
            v[str].crouchaiming = 0
            v[str].crouching = 0
            v[str3].aimMovementSwayMultiplier = 0
            v[str3].aimMultiplier = 0
            v[str3].aimSwayMultiplier = 0
            v[str3].swayMultiplier = 0
            v[str4].sensitivity = 0
        end
    end
end)
expl:addToggle("No Delay", nil, function(value)
delay = value
if game:GetService("Workspace").ignore:WaitForChild("viewmodel") then
    --test
local str2 = 'animTime'

        for i,v in pairs(getgc(true)) do
            if type(v) == 'table' and rawget(v, str) then
                v[str2].crouchIn = 0
                v[str2].crouchOut = 0
                v[str2].proneIn = 0
                v[str2].proneOut = 0
                v[str2].aimIn = 0
                v[str2].aimOut = 0
                v[str2].runIn = 0
                v[str2].runOut = 0
            end
        end
end
end)
expl:addToggle("No Recoil", nil, function(value)
    test = value
if game:GetService("Workspace").ignore:WaitForChild("viewmodel") then
    local str = "recoil"
    
        for i,v in pairs(getgc(true)) do
            if type(v) == 'table' and rawget(v, str) then
                v[str].aiming = 0
                v[str].none = 0
            end
        end
end
end)
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    if test == true and character and game:GetService("Workspace").ignore:WaitForChild("viewmodel") then 
        wait(2)
        local str = "recoil"
    
        for i,v in pairs(getgc(true)) do
            if type(v) == 'table' and rawget(v, str) then
                v[str].aiming = 0
                v[str].none = 0
            end
        end
    end
end)
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    if sway == true and character and game:GetService("Workspace").ignore:WaitForChild("viewmodel") then 
        wait(2)
    local str = 'bobbing_speed'
    local str3 = 'swayModifiers'
    local str4 = 'directionalFiring'
    for i,v in pairs(getgc(true)) do
        if type(v) == 'table' and rawget(v, str) then
            v[str].none = 0
            v[str].aiming = 0
            v[str].prone = 0
            v[str].proneaiming = 0
            v[str].crouchaiming = 0
            v[str].crouching = 0
            v[str3].aimMovementSwayMultiplier = 0
            v[str3].aimMultiplier = 0
            v[str3].aimSwayMultiplier = 0
            v[str3].swayMultiplier = 0
            v[str4].sensitivity = 0
        end
    end
    end
end)
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    if delay == true and character and game:GetService("Workspace").ignore:WaitForChild("viewmodel") then 
        wait(2)
        --test
local str = 'animTime'
    
        for i,v in pairs(getgc(true)) do
            if type(v) == 'table' and rawget(v, str) then
                v[str].none = 0
                v[str].aiming = 0
                v[str].prone = 0
                v[str].proneaiming = 0
                v[str].crouchaiming = 0
                v[str].crouching = 0
            end
        end
    end
end)
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    if rate == true and character and game:GetService("Workspace").ignore:WaitForChild("viewmodel") then 
        wait(2)
        local str = "firing"

for i,v in pairs(getgc(true)) do
    if type(v) == 'table' and rawget(v, str) then
        v[str].rpm = rapid
    end
end
end
end)
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    if character and game:GetService("Workspace").ignore:WaitForChild("viewmodel") then 
        wait(2)
        local gg = "firing"
    
        for i,v in pairs(getgc(true)) do
            if type(v) == 'table' and rawget(v, gg) then
                v[gg].tracerColor = sauce
            end
        end
    end
end)
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    if factor == true and character and game:GetService("Workspace").ignore:WaitForChild("viewmodel") then 
        wait(2)
        local str = "firing"

        for i,v in pairs(getgc(true)) do
            if type(v) == 'table' and rawget(v, str) then
                v[str].projectileRicochetFactor = 0
            end
        end
    end
end)


expl:addToggle("Noclip", nil, function(callback)
    Clip = callback
end)
lol = 1
expl:addToggle("Rapid Fire", nil, function(value)
    rate = value
if game:GetService("Workspace").ignore:WaitForChild("viewmodel") then

    local str = "firing"

for i,v in pairs(getgc(true)) do
    if type(v) == 'table' and rawget(v, str) then
        v[str].rpm = rapid
    end
end
end
end)

expl:addToggle("Speed Hack", nil, function(callback)
    _G.yes = callback
    if callback == true and lol == 1 then 
        LocalPlayer.Character:BreakJoints()
        wait()
        lol = 2 
    end
end)

expl:addSlider("Fire Rate", 2000, 0, 3000, function(value)
    rapid = value
end)
expl:addSlider("Speed Value", 20, 0, 200, function(callback)
    speeed = callback
end)
expl:addColorPicker("Tracer Color", Color3.fromRGB(146, 248, 106), function(callback)
    sauce = callback
    local gg = "firing"
        
    for i,v in pairs(getgc(true)) do
        if type(v) == 'table' and rawget(v, gg) then
            v[gg].tracerColor = sauce
        end
    end
    
end)
expl:addToggle("ProjectileRicochet", nil, function(value)
factor = value
local str = "firing"

for i,v in pairs(getgc(true)) do
    if type(v) == 'table' and rawget(v, str) then
        v[str].projectileRicochetFactor = 0
    end
end
end)

--esp
pp:addToggle("Box ESP", nil, function(value)
    ESP.Enabled = value
    ESP.Settings.Box3D = value
end)
pp:addToggle("Name ESP", nil, function(value)
    function Create(base, team)
        local bb = Instance.new('BillboardGui', game.CoreGui)
        bb.Adornee = base
        bb.ExtentsOffset = Vector3.new(0,1,0)
        bb.AlwaysOnTop = true
        bb.Size = UDim2.new(0,5,0,5)
        bb.StudsOffset = Vector3.new(0,1,0)
        bb.Name = 'tracker'
        local txtlbl = Instance.new('TextLabel',bb)
        txtlbl.ZIndex = 10
        txtlbl.BackgroundTransparency = 1
        txtlbl.Position = UDim2.new(0,0,0,-35)
        txtlbl.Size = UDim2.new(1,0,10,0)
        txtlbl.Font = 'SourceSansSemibold'
        txtlbl.FontSize = 'Size12'
        txtlbl.Text = base.Parent.Name
        txtlbl.TextStrokeTransparency = 0.30000001192093
        if team then
            txtlbl.TextColor3 = Color3.new(0,1,1)
        else
            txtlbl.TextColor3 = Color3.new(1,1,1)
        end
      end
      
      function Clear()
        for _,v in pairs(game.CoreGui:children()) do
            if v.Name == 'tracker' and v:isA('BillboardGui') then
                v:Destroy()
            end
        end
      end
      
      function Find()
        Clear()
        track = true
        spawn(function()
            while wait(1) do
                if track then
                    Clear()
                    for _,v in pairs(game.Players:players()) do
                        if v.TeamColor ~= game.Players.LocalPlayer.TeamColor then
                            if v.Character and v.Character.Head then
                                Create(v.Character.Head, false)
                            end
                        end
                    end
                end
                wait(1)
            end
        end)
      end
      
      Find()
end)
pp:addToggle("Tracer ESP", nil, function(value)
    ESP.Settings.DrawTracers = value
end)


local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__index

local ospeed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed

function WalkSpeed()
    mt.__index = newcclosure(function(self, a)
        if a == "WalkSpeed" then
            return ospeed
        end
        return old(self, a)
    end)
    game:GetService("RunService").RenderStepped:Connect(function()
        if game.Players.LocalPlayer.Character and _G.yes == true then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speeed
        end
    end)
end

WalkSpeed()

local Noclipping = nil
	wait(0.1)
	local function NoclipLoop()
		if Clip == true and LocalPlayer.Character ~= nil then
			for _, child in pairs(LocalPlayer.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
					child.CanCollide = false
				end
			end
		end
	end
Noclipping = game:GetService('RunService').Stepped:Connect(NoclipLoop)


venyx:SelectPage(venyx.pages[1], true)
