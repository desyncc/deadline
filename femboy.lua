local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/desyncc/ui/main/ui_source.lua"))()
for i, v in next, getconnections(game:GetService('ScriptContext').Error) do
	v:Disable()
end



local mt = getrawmetatable(game)
make_writeable(mt)

local namecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
	local method = getnamecallmethod()
	local args = {...}

	if method == "FireServer" and tostring(self) == "error"  then
		return wait(99e99)
	end
	if method == "FireServer" and tostring(self) == "high_level_diagnostics" then
		return wait(99e99)
	end
	return namecall(self, table.unpack(args))
end)

local plr1 = game.Players.LocalPlayer
local players = game:GetService("Players")
local mouse1 = plr1:GetMouse()
local camera1 = game.Workspace.CurrentCamera

function ClosestPlayerToMouse()
    local target = nil
    local dist = math.huge
    for i,v in pairs(game.Players:GetChildren()) do
        if v.Name ~= plr1.Name then
            if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") and v.TeamColor ~= plr1.TeamColor then
                local screenpoint = camera1:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                local check = (Vector2.new(mouse1.X,mouse1.Y)-Vector2.new(screenpoint.X,screenpoint.Y)).magnitude

                if check < dist then
                    target  = v
                    dist = check
                end
            end
        end
    end
    return target
end


local mt = getrawmetatable(game)
setreadonly(mt, false)
local namecall = mt.__namecall

mt.__namecall = function(self,...)
    local args = {...}
    local method = getnamecallmethod()
    if tostring(self) == "fire" and tostring(method) == "FireServer" then
		if sa == true then
        _G.a = args[1]
        _G.b = args[2]
        _G.c = args[3]
        local args1 = {
    [1] = _G.c,
    [2] = {
        ["instance"] = ClosestPlayerToMouse().Character.Head,
        ["material"] = Enum.Material.Fabric,
        ["normal"] = _G.b,
        ["position"] = _G.a
    }
}


game:GetService("ReplicatedStorage").events.weapon.hit:FireServer(unpack(args1))
        return self.FireServer(self, unpack(args))
end
elseif tostring(self) == "hit" and tostring(method) == "FireServer" then
	for i,v in pairs(game.Players:GetPlayers()) do
		if args[2].instance:FindFirstAncestor(v.Name) ~= nil and args[2].instance:FindFirstAncestorWhichIsA("MeshPart") ~= nil and jjk == true then
		be:Fire("hit " .. tostring(args[2].instance:FindFirstAncestor(v.Name)) .. " in the " .. tostring(args[2].instance:FindFirstAncestorWhichIsA("MeshPart")))
		ce:Fire()
		--de:Fire()
		setnamecallmethod("FireServer")
		end
	end
	return self.FireServer(self, unpack(args))
    end
    return namecall(self,...)
end






local annoying = {
	"MB_Sniper",
	"BIackShibe",
	"Armeraivis",
	"Disqualifi3d",
	"MuchCreativeSuchWow",
	"bukaj4040"
}

for i, player in pairs(game:GetService("Players"):GetPlayers()) do
	if player.Name == "BIackShibe" or player.Name == "MB_Sniper" or player.Name == "Armeraivis" then
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
-- health esp
-- Made by Blissful#4992
local Settings = {
    Box_Color = Color3.fromRGB(255, 0, 0),
    Tracer_Color = Color3.fromRGB(255, 0, 0),
    Tracer_Thickness = 1,
    Box_Thickness = 1,
    Tracer_Origin = "Bottom", -- Middle or Bottom if FollowMouse is on this won't matter...
    Tracer_FollowMouse = false,
    Tracers = false
}
local Team_Check = {
    TeamCheck = false, -- if TeamColor is on this won't matter...
    Green = Color3.fromRGB(0, 255, 0),
    Red = Color3.fromRGB(255, 0, 0)
}
local TeamColor = true

--// SEPARATION
local player = game:GetService("Players").LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local mouse = player:GetMouse()

local function NewQuad(thickness, color)
    local quad = Drawing.new("Quad")
    quad.Visible = false
    quad.PointA = Vector2.new(0,0)
    quad.PointB = Vector2.new(0,0)
    quad.PointC = Vector2.new(0,0)
    quad.PointD = Vector2.new(0,0)
    quad.Color = color
    quad.Filled = false
    quad.Thickness = thickness
    quad.Transparency = 1
    return quad
end

local function NewLine(thickness, color)
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(0, 0)
    line.Color = color 
    line.Thickness = thickness
    line.Transparency = 1
    return line
end
local function NewLineDestroy()
    line:Remove()
    line.Visible = false
    library.greenhealth.From = Vector2.new(0, 0)
    library.greenhealth.To = Vector2.new(0, 0)

    library.healthbar.From = Vector2.new(0, 0)
    library.healthbar.To = Vector2.new(0, 0)
end
local function NewQuadDestroy()
    quad:Remove()
    quad.Visible = false
    library.black.PointA = Vector2.new(0, 0)
    library.black.PointB = Vector2.new(0, 0)
    library.black.PointC = Vector2.new(0, 0)
    library.black.PointD = Vector2.new(0, 0)
	library.box.PointA = Vector2.new(0, 0)
    library.box.PointB = Vector2.new(0, 0)
    library.box.PointC = Vector2.new(0, 0)
    library.box.PointD = Vector2.new(0, 0)
end

local function Visibility(state, lib)
    for u, x in pairs(lib) do
        x.Visible = state
    end
end

local function ToColor3(col) --Function to convert, just cuz c;
    local r = col.r --Red value
    local g = col.g --Green value
    local b = col.b --Blue value
    return Color3.new(r,g,b); --Color3 datatype, made of the RGB inputs
end

local black = Color3.fromRGB(0, 0 ,0)
local function ESP(plr)
    local library = {
        --//Tracer and Black Tracer(black border)
        blacktracer = NewLine(Settings.Tracer_Thickness*2, black),
        tracer = NewLine(Settings.Tracer_Thickness, Settings.Tracer_Color),
        --//Box and Black Box(black border)
        black = NewQuad(Settings.Box_Thickness*2, black),
        box = NewQuad(Settings.Box_Thickness, Settings.Box_Color),
        --//Bar and Green Health Bar (part that moves up/down)
        healthbar = NewLine(3, black),
        greenhealth = NewLine(1.5, black)
    }


    local function Colorize(color)
        for u, x in pairs(library) do
            if x ~= library.healthbar and x ~= library.greenhealth and x ~= library.blacktracer and x ~= library.black then
                x.Color = color
            end
        end
    end

    local function Updater()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("Head") ~= nil then
                local HumPos, OnScreen = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                if OnScreen then
                    local head = camera:WorldToViewportPoint(plr.Character.Head.Position)
                    local DistanceY = math.clamp((Vector2.new(head.X, head.Y) - Vector2.new(HumPos.X, HumPos.Y)).magnitude, 2, math.huge)
                    
                    local function Size(item)
                        item.PointA = Vector2.new(HumPos.X + DistanceY, HumPos.Y - DistanceY*2)
                        item.PointB = Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY*2)
                        item.PointC = Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)
                        item.PointD = Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY*2)
                    end
                    if boxesp == true then
                        library.black.PointA = Vector2.new(HumPos.X + DistanceY, HumPos.Y - DistanceY*2)
                        library.black.PointB = Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY*2)
                        library.black.PointC = Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)
                        library.black.PointD = Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY*2)
						library.box.PointA = Vector2.new(HumPos.X + DistanceY, HumPos.Y - DistanceY*2)
                        library.box.PointB = Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY*2)
                        library.box.PointC = Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)
                        library.box.PointD = Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY*2)
					else
                        library.black.PointA = Vector2.new(0, 0)
                        library.black.PointB = Vector2.new(0, 0)
                        library.black.PointC = Vector2.new(0, 0)
                        library.black.PointD = Vector2.new(0, 0)
						library.box.PointA = Vector2.new(0, 0)
                        library.box.PointB = Vector2.new(0, 0)
                        library.box.PointC = Vector2.new(0, 0)
                        library.box.PointD = Vector2.new(0, 0)
                    end

                    --//Tracer 
                    if Settings.Tracers then
                        if Settings.Tracer_Origin == "Middle" then
                            library.tracer.From = camera.ViewportSize*0.5
                            library.blacktracer.From = camera.ViewportSize*0.5
                        elseif Settings.Tracer_Origin == "Bottom" then
                            library.tracer.From = Vector2.new(camera.ViewportSize.X*0.5, camera.ViewportSize.Y) 
                            library.blacktracer.From = Vector2.new(camera.ViewportSize.X*0.5, camera.ViewportSize.Y)
                        end
                        if Settings.Tracer_FollowMouse then
                            library.tracer.From = Vector2.new(mouse.X, mouse.Y+36)
                            library.blacktracer.From = Vector2.new(mouse.X, mouse.Y+36)
                        end
                        library.tracer.To = Vector2.new(HumPos.X, HumPos.Y + DistanceY*2)
                        library.blacktracer.To = Vector2.new(HumPos.X, HumPos.Y + DistanceY*2)
                    else 
                        library.tracer.From = Vector2.new(0, 0)
                        library.blacktracer.From = Vector2.new(0, 0)
                        library.tracer.To = Vector2.new(0, 0)
                        library.blacktracer.To = Vector2.new(0, 02)
                    end

                    --// Health Bar
                    
                    local d = (Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY*2) - Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)).magnitude 
                    local healthoffset = plr.Character.Humanoid.Health/plr.Character.Humanoid.MaxHealth * d
                    library.greenhealth.From = Vector2.new(0, 0)
                    library.greenhealth.To = Vector2.new(0, 0)

                    library.healthbar.From = Vector2.new(0, 0)
                    library.healthbar.To = Vector2.new(0, 0)


                    local green = Color3.fromRGB(0, 255, 0)
                    local red = Color3.fromRGB(255, 0, 0)


                    if healthy == false then
                    library.greenhealth.From = Vector2.new(0, 0)
                    library.greenhealth.To = Vector2.new(0, 0)

                    library.healthbar.From = Vector2.new(0, 0)
                    library.healthbar.To = Vector2.new(0, 0)
                    elseif healthy == true then 
                        library.greenhealth.From = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*2)
                        library.greenhealth.To = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*2 - healthoffset)
    
                        library.healthbar.From = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*2)
                        library.healthbar.To = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y - DistanceY*2)
                    end

                    

                    library.greenhealth.Color = red:lerp(green, plr.Character.Humanoid.Health/plr.Character.Humanoid.MaxHealth);

                    if Team_Check.TeamCheck then
                        if plr.TeamColor ~= player.TeamColor then
                            Colorize(Team_Check.Red)
                        end
                    else 
                        library.tracer.Color = Settings.Tracer_Color
                        library.box.Color = Settings.Box_Color
                    end
                    Visibility(true, library)
                else 
                    Visibility(false, library)
                end
            else 
                Visibility(false, library)
                if game.Players:FindFirstChild(plr.Name) == nil then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(Updater)()
end

for i, v in pairs(game:GetService("Players"):GetPlayers()) do
    if v.Name ~= player.Name then
		if v.TeamColor ~= game.Players.LocalPlayer.TeamColor then
        coroutine.wrap(ESP)(v)
	end
    end
end

game.Players.PlayerAdded:Connect(function(newplr)
    newplr.CharacterAdded:Connect(function(character)
    if newplr.Name ~= player.Name then
		wait(2)
		if newplr.TeamColor ~= game.Players.LocalPlayer.TeamColor then
        coroutine.wrap(ESP)(newplr)
	end
    end
end)
end)

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local Client = Players.LocalPlayer
local Mouse = Client:GetMouse()
local Camera = workspace.CurrentCamera;
local character = Client.Character or Client.CharacterAdded:Wait()

local AimbotEnabled = false
local AimbotActive = false
local VisibilityCheck = false
local TeamCheck = true
local ShowFOV = false
local AimingAt = nil
local Smoothness = 3
local MovementPrediction = false
local MovementPredictionStrength = 1

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
Clip = false





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
local logs = Instance.new("TextLabel")



local be = Instance.new("BindableEvent")
be.Event:Connect(function(text)
	logs.Text = text
end)
local ce = Instance.new("BindableEvent")
ce.Event:Connect(function()
	game:GetService("CoreGui").imgui.logs.TextTransparency = 0
end)
local de = Instance.new("BindableEvent")
de.Event:Connect(function()
	game:GetService("CoreGui").imgui.logs.TextTransparency = 0
                    wait(3)
                    game:GetService("CoreGui").imgui.logs.TextTransparency = 0.1
                    wait()
                    game:GetService("CoreGui").imgui.logs.TextTransparency = 0.2
                    wait()
                    game:GetService("CoreGui").imgui.logs.TextTransparency = 0.3
                    wait()
                    game:GetService("CoreGui").imgui.logs.TextTransparency = 0.4
                    wait()
                    game:GetService("CoreGui").imgui.logs.TextTransparency = 0.5
                    wait()
                    game:GetService("CoreGui").imgui.logs.TextTransparency = 0.6
                    wait()
                    game:GetService("CoreGui").imgui.logs.TextTransparency = 0.7
                    wait()
                    game:GetService("CoreGui").imgui.logs.TextTransparency = 0.8
                    wait()
                    game:GetService("CoreGui").imgui.logs.TextTransparency = 0.9
                    wait()
                    game:GetService("CoreGui").imgui.logs.TextTransparency = 1
end)

-- Window
local Window, MainGUI = Library:CreateWindow("gamesense")

-- Tabs
local Tab1 = Window:CreateTab("Aimbot")
local Tab2 = Window:CreateTab("Visuals")
local Tab3 = Window:CreateTab("Weapons")
local Tab4 = Window:CreateTab("Player")
local Tab5 = Window:CreateTab("World")
local Tab6 = Window:CreateTab("Misc")
local Tab7 = Window:CreateTab("Keybinds")

local Groupbox1 = Tab1:CreateGroupbox("Aimbot", "Left")
local Groupbox2 = Tab1:CreateGroupbox("Ragebot", "Right")

local Groupbox3 = Tab2:CreateGroupbox("ESP", "Left")

local Groupbox4 = Tab3:CreateGroupbox("Weapons", "Left")

local Groupbox5 = Tab4:CreateGroupbox("Player", "Left")

local Groupbox6 = Tab5:CreateGroupbox("World", "Left")



-- Aimbot groupbox
local aimbot = Groupbox1:CreateToggle("Enable", function(state)
    AimbotEnabled = state
end)
local vis = Groupbox1:CreateToggle("Visibility Check", function(state)
    VisibilityCheck = state
end)
local hitbox = Groupbox1:CreateDropdown("Target Hitbox Priority", {"Head", "Torso"}, function(object)
    if object == "Head" then
        AimPart = "Head"
    elseif object == "Torso" then
        AimPart = "Torso"
    end
end)
local slider = Groupbox1:CreateSlider("Maximum FOV", 0, 1000, 0, function(value)
    FOV_Size = value
end)
local toggle = Groupbox1:CreateToggle("Show FOV Cirlce", function(state)
    ShowFOV = state
end)
local colorpicker = Groupbox1:CreateColorPicker("FOV Color", Color3.fromRGB(255, 255, 255), function(state)
    FOV_Color = state
 end)
 local toggle2 = Groupbox2:CreateToggle("pSilent", function(bool)
    sa = bool
end)
UserInputService.InputBegan:Connect(function(Input, GPE)
    if GPE or AimbotEnabled == false then return end
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        AimbotActive = true
    end
end)

UserInputService.InputEnded:Connect(function(Input, GPE)
    if GPE or AimbotEnabled == false then return end
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        AimbotActive = false
        AimingAt = nil
    end
end)
RunService:BindToRenderStep("InitAimbot", 1, InitAimbot)


-- visuals
local box_esp = Groupbox3:CreateToggle("Bounding Box", function(state)
    boxesp = state
end)
local health_esp = Groupbox3:CreateToggle("Health Bar", function(state)
    healthy = state
end)
local name_esp = Groupbox3:CreateToggle("Name", function(state)
    nameesp = state
end)
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
                            if nameesp then
                            Create(v.Character.Head, false)
                            end
                        end
                    end
                end
            end
            wait(1)
        end
    end)
end
Find()

local no_recoil = Groupbox4:CreateToggle("No Recoil", function(state)
    test = state
    if game:GetService("Workspace").ignore:WaitForChild("viewmodel") then
        local str = "recoil"

        for i,v in pairs(getgc(true)) do
            if type(v) == 'table' and rawget(v, str) then
                v[str].aiming = 0
                v[str].none = 0
                v[str].prone = 0
                v[str].proneaiming = 0
                v[str].crouchaiming = 0
            end
        end
    end
end)
local no_delay = Groupbox4:CreateToggle("No Delay", function(state)
    delay = state
    if game:GetService("Workspace").ignore:WaitForChild("viewmodel") then
        --test
        local str2 = 'proceduralAnims'

        for i,v in pairs(getgc(true)) do
            if type(v) == 'table' and rawget(v, str2) then
                v[str2].animTime.crouchIn = 0
                v[str2].animTime.crouchOut = 0
                v[str2].animTime.proneIn = 0
                v[str2].animTime.proneOut = 0
                v[str2].animTime.aimIn = 0
                v[str2].animTime.aimOut = 0        
            end
        end
    end
end)
local no_sway = Groupbox4:CreateToggle("No Sway", function(state)
    sway = state
    local str = 'proceduralAnims'
    local str3 = 'swayModifiers'
    local str3 = 'swayModifiers'
    local str4 = 'directionalFiring'
    for i,v in pairs(getgc(true)) do
        if type(v) == 'table' and rawget(v, str) then
            v[str].bobbing_speed.none = 0
            v[str].bobbing_speed.aiming = 0
            v[str].bobbing_speed.prone = 0
            v[str].bobbing_speed.proneaiming = 0
            v[str].bobbing_speed.crouchaiming = 0
            v[str].bobbing_speed.crouching = 0
            v[str3].aimMovementSwayMultiplier = 0
            v[str3].aimMultiplier = 0
            v[str3].aimSwayMultiplier = 0
            v[str3].swayMultiplier = 0
            v[str4].sensitivity = 0
        end
    end
end)
local quick_reload = Groupbox4:CreateToggle("Fast Reload", function(state)
    fast_reload = state
	local str = 'animations'

    for i,v in pairs(getgc(true)) do
    if type(v) == 'table' and rawget(v, str) then
        if v[str].speed.reload ~= nil and type(v[str].speed.reload) ~= 'table' then
            v[str].speed.reload = 10
        end
        if v[str].speed.quick_reload ~= nil and type(v[str].speed.quick_reload) ~= 'table' then
            v[str].speed.quick_reload = 10
        end
        if v[str].speed.bolt_release ~= nil and type(v[str].speed.bolt_release) ~= 'table' then
            v[str].speed.bolt_release = 10
        end
        if v[str].speed.prone_transition ~= nil and type(v[str].speed.prone_transition) ~= 'table' then
            v[str].speed.prone_transition = 50
        end
        if v[str].speed.mag_check ~= nil and type(v[str].speed.mag_check) ~= 'table' then
            v[str].speed.mag_check = 10
        end
        if v[str].speed.fire_aim ~= nil and type(v[str].speed.fire_aim) ~= 'table' then
            v[str].speed.fire_aim = 10
        end
        if v[str].speed.fire ~= nil and type(v[str].speed.fire) ~= 'table' then
            v[str].speed.fire = 10
        end
        if v[str].speed.generic_interact ~= nil and type(v[str].speed.generic_interact) ~= 'table' then
            v[str].speed.generic_interact = 10
        end
    end
    end
end)
local fast_fire = Groupbox4:CreateToggle("Fast Fire", function(state)
    rate = state
    if game:GetService("Workspace").ignore:WaitForChild("viewmodel") then

        local str = "firing"

        for i,v in pairs(getgc(true)) do
            if type(v) == 'table' and rawget(v, str) then
                if mode ~= nil then
                v[str].rpm = mode
                end
            end
        end
    end          
end)
local fast_fire_mode = Groupbox4:CreateDropdown("Rate Of Fire", {"Sustained/effective rate", "Cyclic rate", "Rapid rate"}, function(object)
    if object == "Sustained/effective rate" then
        mode = 700
    elseif object == "Cyclic rate" then
        mode = 1000
    elseif object == "Rapid rate" then
        mode = 2000
    end
end)
-- norecoil
game:GetService("Workspace").ignore.ChildAdded:Connect(function(child)
	if test == true and child:WaitForChild("defaultAttachments") and child:IsA("Model") and child.Name == "viewmodel" and Client.Character.Humanoid then 
		wait()
		local str = "recoil"

		for i,v in pairs(getgc(true)) do
			if type(v) == 'table' and rawget(v, str) then
				if v[str].aiming ~= 0 then
				v[str].aiming = 0
				v[str].none = 0
				v[str].proneaiming = 0
				v[str].prone = 0
				end
			end
		end
	end
end)
-- nodelay
game:GetService("Workspace").ignore.ChildAdded:Connect(function(child)
	if delay == true and child:WaitForChild("defaultAttachments") and child:IsA("Model") and child.Name == "viewmodel" and Client.Character.Humanoid then 
		wait()
		--test
		local str2 = 'proceduralAnims'

		for i,v in pairs(getgc(true)) do
			if type(v) == 'table' and rawget(v, str2) then
				if v[str2].animTime.crouchIn ~= 0 then
				v[str2].animTime.crouchIn = 0
				v[str2].animTime.crouchOut = 0
				v[str2].animTime.proneIn = 0
				v[str2].animTime.proneOut = 0
				v[str2].animTime.aimIn = 0
				v[str2].animTime.aimOut = 0        
				v[str2].animTime.runIn = 0
				v[str2].animTime.runOut = 0
				end
			end
		end
	end
end)
game:GetService("Workspace").ignore.ChildAdded:Connect(function(child)
	if fast_reload == true and child:WaitForChild("defaultAttachments") and child:IsA("Model") and child.Name == "viewmodel" and Client.Character.Humanoid then 
		wait()
		--test
		local str = 'animations'

for i,v in pairs(getgc(true)) do
    if type(v) == 'table' and rawget(v, str) then
        if v[str].speed.reload ~= nil and type(v[str].speed.reload) ~= 'table' then
            v[str].speed.reload = 10
        end
        if v[str].speed.quick_reload ~= nil and type(v[str].speed.quick_reload) ~= 'table' then
            v[str].speed.quick_reload = 10
        end
        if v[str].speed.bolt_release ~= nil and type(v[str].speed.bolt_release) ~= 'table' then
            v[str].speed.bolt_release = 10
        end
        if v[str].speed.prone_transition ~= nil and type(v[str].speed.prone_transition) ~= 'table' then
            v[str].speed.prone_transition = 50
        end
        if v[str].speed.mag_check ~= nil and type(v[str].speed.mag_check) ~= 'table' then
            v[str].speed.mag_check = 10
        end
        if v[str].speed.fire_aim ~= nil and type(v[str].speed.fire_aim) ~= 'table' then
            v[str].speed.fire_aim = 10
        end
        if v[str].speed.fire ~= nil and type(v[str].speed.fire) ~= 'table' then
            v[str].speed.fire = 10
        end
        if v[str].speed.generic_interact ~= nil and type(v[str].speed.generic_interact) ~= 'table' then
            v[str].speed.generic_interact = 10
        end
    end
end
	end
end)
-- nosway
game:GetService("Workspace").ignore.ChildAdded:Connect(function(child)
	if sway == true and child:WaitForChild("defaultAttachments") and child:IsA("Model") and child.Name == "viewmodel" and Client.Character.Humanoid then 
		wait()
		local str = 'bobbing_speed'
		local str3 = 'swayModifiers'
		local str4 = 'directionalFiring'
		for i,v in pairs(getgc(true)) do
			if type(v) == 'table' and rawget(v, str) then
				if v[str].none ~= 0 then
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
	end
end)
game:GetService("Workspace").ignore.ChildAdded:Connect(function(child)
	if rate == true and child:WaitForChild("defaultAttachments") and child:IsA("Model") and child.Name == "viewmodel" and Client.Character.Humanoid then 
		wait()
		local str = "firing"

		for i,v in pairs(getgc(true)) do
			if type(v) == 'table' and rawget(v, str) then
                if mode then
				v[str].rpm = mode
                end
			end
		end
	end
end)
game:GetService("Workspace").ignore.ChildAdded:Connect(function(child)
	if child:WaitForChild("defaultAttachments") and child:IsA("Model") and child.Name == "viewmodel" and Client.Character.Humanoid then 
		wait()
		local str = 'torsoRot'

for i,v in pairs(getgc(true)) do
    if type(v) == 'table' and rawget(v, str) then
        if v[str].aiming ~= nil and type(v[str].aiming) ~= 'table' then
            v[str].aiming = -10
            v[str].none = -100000
            v[str].running = -1000000000
        end
    end
end
	end
end)




local no_fall = Groupbox5:CreateToggle("No Fall", function(state)
    fall = state
    if state == true then
        local mt = getrawmetatable(game)
        make_writeable(mt)

        local namecall = mt.__namecall

        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}

            if method == "FireServer" and tostring(self) == "ow" then
                return wait(99e99)
            end
            return namecall(self, table.unpack(args))
        end)
    end          
end)
lol = 1
local speed_hack = Groupbox5:CreateToggle("Speed boost", function(state)
    speed = state
    if speed == true and lol == 1 then 
        LocalPlayer.Character:BreakJoints()
        wait()
        lol = 2 
    end
end)
local movement = Groupbox5:CreateToggle("Remove movement penalty", function(state)
    move = state
end)
local footstep = Groupbox5:CreateToggle("Remove footstep sound", function(state)
    sound = state
end)
local third_person = Groupbox5:CreateToggle("Thirdperson", function(state)
	if state == false then
		tp=false
	else
		tp=true
	end

	game.Players.LocalPlayer:GetMouse().KeyDown:connect(function(k)
		if k=="l" or k=="L" then
			if tp==false then
				tp=true
			else
				tp=false
			end
		end
	end)

	while wait() do
		if tp==true then
			game.Players.LocalPlayer.CameraMode = "Classic"
			game.Players.LocalPlayer.CameraMaxZoomDistance = 10
			game.Players.LocalPlayer.CameraMinZoomDistance = 10
			for _,v in pairs(workspace.Camera:GetDescendants()) do 
				pcall(function() 
					v.Transparency=1
				end)
			end
		else
			game.Players.LocalPlayer.CameraMode = "LockFirstPerson"
			game.Players.LocalPlayer.CameraMaxZoomDistance = 0
			game.Players.LocalPlayer.CameraMinZoomDistance = 0
		end
	end
end)
local slider2 = Groupbox5:CreateSlider("Override FOV", 0, 45, 0, function(value)
    fov = value
end)
local mt = getrawmetatable(game)
make_writeable(mt)

local namecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
	local method = getnamecallmethod()
	local args = {...}

	if method == "FireServer" and tostring(self) == "change_view_angle" and move then
		return wait(99e99)
	end
	if method == "FireServer" and tostring(self) == "replicate_sound" and sound then
		return wait(99e99)
	end
	return namecall(self, table.unpack(args))
end)
game:GetService("RunService").RenderStepped:Connect(function()
    if move then
		if Client.Character:WaitForChild("Humanoid") ~= nil then
			local plrname = game.Players.LocalPlayer.Name
			game:GetService("Workspace")[plrname].view_angle.Value = 20
		end
	end
end)

local toggle4 = Groupbox6:CreateToggle("World Modulation", function(bool)
    world = bool
end)
local colorpicker2 = Groupbox6:CreateColorPicker("", Color3.fromRGB(1, 0.39, 1), function(color)
    tintcolor = color
end)
local dropdown2 = Groupbox6:CreateDropdown("Time of Day", {"Day", "Night"}, function(object)
    tod = object
end)
local slider4 = Groupbox6:CreateSlider("Saturation", -100, 100, 0, function(value)
    Sat = value
end)
local slider5 = Groupbox6:CreateSlider("Contrast", -100, 100, 0, function(value)
    Con = value
end)
local toggle5 = Groupbox6:CreateToggle("Disable bloom", function(bool)
    bloom = bool
end)
function correc()
    game:GetService("Lighting").nightVision_colorCorrection.Enabled = world
    if world == true and Client.Character then
        game:GetService("Lighting").nightVision_colorCorrection.TintColor = tintcolor
        game:GetService("Lighting").nightVision_colorCorrection.Saturation = Sat
        game:GetService("Lighting").nightVision_colorCorrection.Contrast = Con
    end
    if bloom then
        game:GetService("Lighting")["nightVision_bloom"].Enabled = false
        game:GetService("Lighting")["generic_sunrays"].Enabled = false
        game:GetService("Lighting")["generic_bloom"].Enabled = false
    else       
        game:GetService("Lighting")["generic_sunrays"].Enabled = true
        game:GetService("Lighting")["generic_bloom"].Enabled = true
    end
end
RunService:BindToRenderStep("correc", 80, correc)


















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
		if Client.Character and speed == true and Client.Character:FindFirstChild("Humanoid") ~= nil then
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speeed
		end
	end)
end

WalkSpeed()
speeed = 20
local UIS = game:GetService("UserInputService")

UIS.InputBegan:Connect(function(Input, GameProcessedEvent)
	--if not GameProcessedEvent then
	if Input.KeyCode == Enum.KeyCode.LeftShift then
		speeed = 32
	end
	--end
end)

UIS.InputEnded:Connect(function(Input, GameProcessedEvent)
	if Input.KeyCode == Enum.KeyCode.LeftShift then
		speeed = 24
	end
end)
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
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__index

local ospeed = game:GetService("Lighting").ClockTime

function time()
	mt.__index = newcclosure(function(self, a)
		if a == "ClockTime" then
			return ospeed
		end
		return old(self, a)
	end)
	game:GetService("RunService").RenderStepped:Connect(function()
		if tod == "Night" then
			game:GetService("Lighting").ClockTime = 24
		end
		if tod == "Day" then
			game:GetService("Lighting").ClockTime = 9
		end
	end)
end

time()
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__index

local ospeed = game:GetService("Workspace").Camera.FieldOfView

function fov()
	mt.__index = newcclosure(function(self, a)
		if a == "FieldOfView" then
			return ospeed
		end
		return old(self, a)
	end)
	game:GetService("RunService").RenderStepped:Connect(function()
		if fov ~= 0 then
			game:GetService("Workspace").Camera.FieldOfView = fov + 75
		end
	end)
end

fov()
