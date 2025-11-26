-- Advanced Mobile IMGUI Menu for Roblox
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Theme System
local Themes = {
    Dark = {
        Background = Color3.fromRGB(30, 30, 35),
        Header = Color3.fromRGB(40, 40, 45),
        Content = Color3.fromRGB(35, 35, 40),
        Text = Color3.fromRGB(220, 220, 220),
        Accent = Color3.fromRGB(0, 150, 255),
        Success = Color3.fromRGB(60, 180, 60),
        Danger = Color3.fromRGB(220, 60, 60),
        Border = Color3.fromRGB(60, 60, 70)
    },
    Light = {
        Background = Color3.fromRGB(240, 240, 245),
        Header = Color3.fromRGB(220, 220, 225),
        Content = Color3.fromRGB(230, 230, 235),
        Text = Color3.fromRGB(40, 40, 45),
        Accent = Color3.fromRGB(0, 100, 200),
        Success = Color3.fromRGB(50, 160, 50),
        Danger = Color3.fromRGB(200, 50, 50),
        Border = Color3.fromRGB(180, 180, 190)
    },
    Purple = {
        Background = Color3.fromRGB(35, 30, 45),
        Header = Color3.fromRGB(50, 40, 65),
        Content = Color3.fromRGB(40, 35, 55),
        Text = Color3.fromRGB(220, 220, 240),
        Accent = Color3.fromRGB(160, 100, 255),
        Success = Color3.fromRGB(80, 200, 120),
        Danger = Color3.fromRGB(255, 80, 120),
        Border = Color3.fromRGB(80, 70, 100)
    },
    Green = {
        Background = Color3.fromRGB(25, 35, 30),
        Header = Color3.fromRGB(35, 50, 40),
        Content = Color3.fromRGB(30, 42, 35),
        Text = Color3.fromRGB(220, 240, 220),
        Accent = Color3.fromRGB(80, 220, 120),
        Success = Color3.fromRGB(60, 200, 80),
        Danger = Color3.fromRGB(220, 80, 80),
        Border = Color3.fromRGB(60, 80, 70)
    }
}

-- Configuration
local config = {
    menuVisible = true,
    menuExtended = true,
    currentTheme = "Dark",
    currentTab = "Visuals",
    
    -- Functions states
    Visuals = {
        esp = false,
        chams = false,
        xRay = false,
        fullBright = false,
        tracers = false,
        nameTags = false
    },
    
    Movement = {
        fly = false,
        noClip = false,
        speedHack = false,
        airJump = false,
        infiniteJump = false,
        highJump = false,
        noSlowdown = false
    },
    
    Combat = {
        aimBot = false,
        triggerBot = false,
        noRecoil = false,
        silentAim = false,
        instantKill = false,
        rapidFire = false
    },
    
    Player = {
        godMode = false,
        antiAfk = false,
        autoFarm = false,
        espSettings = false,
        noFallDamage = false,
        autoSprint = false
    }
}

-- Mobile detection
local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
local buttonSize = isMobile and UDim2.new(0.9, 0, 0, 40) or UDim2.new(0.9, 0, 0, 30)
local fontSize = isMobile and 14 or 11

-- GUI Creation
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdvancedMobileMenu"
screenGui.Parent = CoreGui

local mainContainer = Instance.new("Frame")
mainContainer.Size = UDim2.new(0, isMobile and 350 or 320, 0, isMobile and 500 or 450)
mainContainer.Position = UDim2.new(0.5, -175, 0.5, -250)
mainContainer.BackgroundColor3 = Themes[config.currentTheme].Background
mainContainer.BorderColor3 = Themes[config.currentTheme].Border
mainContainer.BorderSizePixel = 2
mainContainer.Parent = screenGui

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Themes[config.currentTheme].Header
header.BorderSizePixel = 0
header.Parent = mainContainer

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.6, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "DataFores DLC"
title.TextColor3 = Themes[config.currentTheme].Text
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local themeButton = Instance.new("TextButton")
themeButton.Size = UDim2.new(0, 80, 0, 30)
themeButton.Position = UDim2.new(0.6, 10, 0.5, -15)
themeButton.BackgroundColor3 = Themes[config.currentTheme].Accent
themeButton.TextColor3 = Themes[config.currentTheme].Text
themeButton.Text = "Theme"
themeButton.TextSize = 12
themeButton.Font = Enum.Font.Gotham
themeButton.Parent = header

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0.5, -15)
closeButton.BackgroundColor3 = Themes[config.currentTheme].Danger
closeButton.TextColor3 = Themes[config.currentTheme].Text
closeButton.Text = "X"
closeButton.TextSize = 14
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = header

-- Tabs
local tabsContainer = Instance.new("Frame")
tabsContainer.Size = UDim2.new(1, 0, 0, 40)
tabsContainer.Position = UDim2.new(0, 0, 0, 50)
tabsContainer.BackgroundColor3 = Themes[config.currentTheme].Content
tabsContainer.BorderSizePixel = 0
tabsContainer.Parent = mainContainer

local tabsScroll = Instance.new("ScrollingFrame")
tabsScroll.Size = UDim2.new(1, 0, 1, 0)
tabsScroll.BackgroundTransparency = 1
tabsScroll.ScrollBarThickness = 0
tabsScroll.CanvasSize = UDim2.new(2, 0, 0, 0)
tabsScroll.Parent = tabsContainer

local tabsLayout = Instance.new("UIListLayout")
tabsLayout.FillDirection = Enum.FillDirection.Horizontal
tabsLayout.Padding = UDim.new(0, 5)
tabsLayout.Parent = tabsScroll

-- Content
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, -90)
contentFrame.Position = UDim2.new(0, 0, 0, 90)
contentFrame.BackgroundColor3 = Themes[config.currentTheme].Content
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainContainer

local contentScroll = Instance.new("ScrollingFrame")
contentScroll.Size = UDim2.new(1, 0, 1, 0)
contentScroll.BackgroundTransparency = 1
contentScroll.ScrollBarThickness = 4
contentScroll.ScrollBarImageColor3 = Themes[config.currentTheme].Border
contentScroll.Parent = contentFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 5)
contentLayout.Parent = contentScroll

-- Mobile Controls
local mobileToggle = Instance.new("TextButton")
mobileToggle.Size = UDim2.new(0, 60, 0, 60)
mobileToggle.Position = UDim2.new(0, 20, 1, -80)
mobileToggle.BackgroundColor3 = Themes[config.currentTheme].Accent
mobileToggle.TextColor3 = Themes[config.currentTheme].Text
mobileToggle.Text = "☰"
mobileToggle.TextSize = 20
mobileToggle.Visible = isMobile
mobileToggle.Parent = screenGui

-- Apply Theme Function
local function applyTheme(themeName)
    local theme = Themes[themeName]
    config.currentTheme = themeName
    
    mainContainer.BackgroundColor3 = theme.Background
    mainContainer.BorderColor3 = theme.Border
    
    header.BackgroundColor3 = theme.Header
    title.TextColor3 = theme.Text
    
    themeButton.BackgroundColor3 = theme.Accent
    themeButton.TextColor3 = theme.Text
    
    closeButton.BackgroundColor3 = theme.Danger
    closeButton.TextColor3 = theme.Text
    
    tabsContainer.BackgroundColor3 = theme.Content
    contentFrame.BackgroundColor3 = theme.Content
    contentScroll.ScrollBarImageColor3 = theme.Border
    
    mobileToggle.BackgroundColor3 = theme.Accent
    mobileToggle.TextColor3 = theme.Text
end

-- Create Tab Function
local function createTab(name)
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0, 80, 0, 30)
    tabButton.BackgroundColor3 = config.currentTab == name and Themes[config.currentTheme].Accent or Themes[config.currentTheme].Background
    tabButton.TextColor3 = Themes[config.currentTheme].Text
    tabButton.Text = name
    tabButton.TextSize = fontSize
    tabButton.Font = Enum.Font.Gotham
    tabButton.Parent = tabsScroll
    
    tabButton.MouseButton1Click:Connect(function()
        config.currentTab = name
        updateContent()
        updateTabs()
    end)
    
    return tabButton
end

-- Update Tabs Appearance
local function updateTabs()
    for _, child in pairs(tabsScroll:GetChildren()) do
        if child:IsA("TextButton") then
            child.BackgroundColor3 = config.currentTab == child.Text and Themes[config.currentTheme].Accent or Themes[config.currentTheme].Background
        end
    end
end

-- Create Toggle Function
local function createToggle(name, category, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = buttonSize
    toggleFrame.BackgroundColor3 = Themes[config.currentTheme].Background
    toggleFrame.BorderSizePixel = 0
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(1, 0, 1, 0)
    toggleButton.BackgroundColor3 = config[category][name] and Themes[config.currentTheme].Success or Themes[config.currentTheme].Header
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = "  " .. name
    toggleButton.TextColor3 = Themes[config.currentTheme].Text
    toggleButton.TextSize = fontSize
    toggleButton.TextXAlignment = Enum.TextXAlignment.Left
    toggleButton.Font = Enum.Font.Gotham
    toggleButton.Parent = toggleFrame
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0, 50, 1, 0)
    statusLabel.Position = UDim2.new(1, -50, 0, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = config[category][name] and "ON" or "OFF"
    statusLabel.TextColor3 = config[category][name] and Themes[config.currentTheme].Success or Themes[config.currentTheme].Danger
    statusLabel.TextSize = fontSize - 1
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.Parent = toggleButton
    
    toggleButton.MouseButton1Click:Connect(function()
        config[category][name] = not config[category][name]
        toggleButton.BackgroundColor3 = config[category][name] and Themes[config.currentTheme].Success or Themes[config.currentTheme].Header
        statusLabel.Text = config[category][name] and "ON" or "OFF"
        statusLabel.TextColor3 = config[category][name] and Themes[config.currentTheme].Success or Themes[config.currentTheme].Danger
        
        if callback then
            callback(config[category][name])
        end
    end)
    
    return toggleFrame
end

-- Create Slider Function
local function createSlider(name, category, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = buttonSize
    sliderFrame.BackgroundColor3 = Themes[config.currentTheme].Background
    sliderFrame.BorderSizePixel = 0
    
    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Size = UDim2.new(1, 0, 0.5, 0)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Text = name .. ": " .. default
    sliderLabel.TextColor3 = Themes[config.currentTheme].Text
    sliderLabel.TextSize = fontSize
    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    sliderLabel.Font = Enum.Font.Gotham
    sliderLabel.Parent = sliderFrame
    
    local sliderTrack = Instance.new("Frame")
    sliderTrack.Size = UDim2.new(0.9, 0, 0, 8)
    sliderTrack.Position = UDim2.new(0.05, 0, 0.7, 0)
    sliderTrack.BackgroundColor3 = Themes[config.currentTheme].Header
    sliderTrack.BorderSizePixel = 0
    sliderTrack.Parent = sliderFrame
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Themes[config.currentTheme].Accent
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderTrack
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(0, 16, 0, 16)
    sliderButton.Position = UDim2.new((default - min) / (max - min), -8, 0, -4)
    sliderButton.BackgroundColor3 = Themes[config.currentTheme].Text
    sliderButton.Text = ""
    sliderButton.Parent = sliderTrack
    
    local dragging = false
    
    local function updateValue(x)
        local relativeX = math.clamp(x - sliderTrack.AbsolutePosition.X, 0, sliderTrack.AbsoluteSize.X)
        local value = min + (relativeX / sliderTrack.AbsoluteSize.X) * (max - min)
        value = math.floor(value)
        
        sliderFill.Size = UDim2.new(relativeX / sliderTrack.AbsoluteSize.X, 0, 1, 0)
        sliderButton.Position = UDim2.new(relativeX / sliderTrack.AbsoluteSize.X, -8, 0, -4)
        sliderLabel.Text = name .. ": " .. value
        
        if callback then
            callback(value)
        end
    end
    
    sliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateValue(input.Position.X)
        end
    end)
    
    return sliderFrame
end

-- Function Implementations
local connections = {}
local espObjects = {}

-- ESP Function
local function toggleESP(state)
    if state then
        local function createESP(player)
            if player == LocalPlayer then return end
            
            local highlight = Instance.new("Highlight")
            highlight.Name = "ESP_" .. player.Name
            highlight.Adornee = player.Character
            highlight.FillColor = Color3.fromRGB(255, 50, 50)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.7
            highlight.OutlineTransparency = 0
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = player.Character
            
            espObjects[player] = highlight
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                createESP(player)
            end
        end
        
        connections.espAdded = Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                wait(1)
                if config.Visuals.esp then
                    createESP(player)
                end
            end)
        end)
    else
        for player, highlight in pairs(espObjects) do
            if highlight then
                highlight:Destroy()
            end
        end
        espObjects = {}
        
        if connections.espAdded then
            connections.espAdded:Disconnect()
        end
    end
end

-- Chams Function
local function toggleChams(state)
    if state then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.ForceField
                        part.Color = Color3.fromRGB(255, 0, 255)
                    end
                end
            end
        end
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.Plastic
                    end
                end
            end
        end
    end
end

-- X-Ray Function
local function toggleXRay(state)
    if state then
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency < 1 then
                part.LocalTransparencyModifier = 0.5
            end
        end
    else
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 0
            end
        end
    end
end

-- Full Bright Function
local function toggleFullBright(state)
    if state then
        game.Lighting.Ambient = Color3.new(1, 1, 1)
        game.Lighting.Brightness = 2
        game.Lighting.GlobalShadows = false
    else
        game.Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        game.Lighting.Brightness = 1
        game.Lighting.GlobalShadows = true
    end
end

-- Fly Function
local function toggleFly(state)
    config.Movement.fly = state
    if state then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
        
        connections.fly = RunService.Heartbeat:Connect(function()
            if config.Movement.fly and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local root = LocalPlayer.Character.HumanoidRootPart
                
                if not bodyVelocity.Parent then
                    bodyVelocity.Parent = root
                end
                
                local flyDirection = Vector3.new(0, 0, 0)
                local flySpeed = 50
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    flyDirection = flyDirection + root.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    flyDirection = flyDirection - root.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    flyDirection = flyDirection - root.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    flyDirection = flyDirection + root.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    flyDirection = flyDirection + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    flyDirection = flyDirection - Vector3.new(0, 1, 0)
                end
                
                bodyVelocity.Velocity = flyDirection * flySpeed
            end
        end)
    else
        if connections.fly then
            connections.fly:Disconnect()
        end
        if bodyVelocity then
            bodyVelocity:Destroy()
        end
    end
end

-- No Clip Function
local function toggleNoClip(state)
    config.Movement.noClip = state
    if state then
        connections.noClip = RunService.Stepped:Connect(function()
            if config.Movement.noClip and LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if connections.noClip then
            connections.noClip:Disconnect()
        end
    end
end

-- Speed Hack Function
local function toggleSpeedHack(state)
    if state then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 50
        end
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end

-- Air Jump Function
local function toggleAirJump(state)
    if state then
        connections.airJump = UserInputService.JumpRequest:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        if connections.airJump then
            connections.airJump:Disconnect()
        end
    end
end

-- Infinite Jump Function
local function toggleInfiniteJump(state)
    config.Movement.infiniteJump = state
end

-- High Jump Function
local function toggleHighJump(state)
    if state then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = 100
        end
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end
end

-- Aim Bot Function
local function toggleAimBot(state)
    config.Combat.aimBot = state
    if state then
        connections.aimBot = RunService.Heartbeat:Connect(function()
            if config.Combat.aimBot and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                local closestPlayer = nil
                local closestDistance = math.huge
                
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = player
                        end
                    end
                end
                
                if closestPlayer then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
                        LocalPlayer.Character.HumanoidRootPart.Position,
                        closestPlayer.Character.HumanoidRootPart.Position
                    )
                end
            end
        end)
    else
        if connections.aimBot then
            connections.aimBot:Disconnect()
        end
    end
end

-- No Recoil Function
local function toggleNoRecoil(state)
    config.Combat.noRecoil = state
    print("No Recoil:", state and "Enabled" or "Disabled")
end

-- God Mode Function
local function toggleGodMode(state)
    if state then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.MaxHealth = math.huge
            LocalPlayer.Character.Humanoid.Health = math.huge
        end
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.MaxHealth = 100
            LocalPlayer.Character.Humanoid.Health = 100
        end
    end
end

-- Anti AFK Function
local function toggleAntiAFK(state)
    if state then
        connections.antiAFK = RunService.Heartbeat:Connect(function()
            LocalPlayer.Idled:Connect(function()
                game:GetService("VirtualUser"):ClickButton2(Vector2.new())
            end)
        end)
    else
        if connections.antiAFK then
            connections.antiAFK:Disconnect()
        end
    end
end

-- Update Content Function
local function updateContent()
    contentScroll:ClearAllChildren()
    
    if config.currentTab == "Visuals" then
        createToggle("ESP", "Visuals", toggleESP).Parent = contentScroll
        createToggle("Chams", "Visuals", toggleChams).Parent = contentScroll
        createToggle("X-Ray", "Visuals", toggleXRay).Parent = contentScroll
        createToggle("Full Bright", "Visuals", toggleFullBright).Parent = contentScroll
        createToggle("Tracers", "Visuals", function(state) end).Parent = contentScroll
        createToggle("Name Tags", "Visuals", function(state) end).Parent = contentScroll
        
    elseif config.currentTab == "Movement" then
        createToggle("Fly", "Movement", toggleFly).Parent = contentScroll
        createToggle("No Clip", "Movement", toggleNoClip).Parent = contentScroll
        createToggle("Speed Hack", "Movement", toggleSpeedHack).Parent = contentScroll
        createToggle("Air Jump", "Movement", toggleAirJump).Parent = contentScroll
        createToggle("Infinite Jump", "Movement", toggleInfiniteJump).Parent = contentScroll
        createToggle("High Jump", "Movement", toggleHighJump).Parent = contentScroll
        createToggle("No Slowdown", "Movement", function(state) end).Parent = contentScroll
        
    elseif config.currentTab == "Combat" then
        createToggle("Aim Bot", "Combat", toggleAimBot).Parent = contentScroll
        createToggle("Trigger Bot", "Combat", function(state) end).Parent = contentScroll
        createToggle("No Recoil", "Combat", toggleNoRecoil).Parent = contentScroll
        createToggle("Silent Aim", "Combat", function(state) end).Parent = contentScroll
        createToggle("Instant Kill", "Combat", function(state) end).Parent = contentScroll
        createToggle("Rapid Fire", "Combat", function(state) end).Parent = contentScroll
        
    elseif config.currentTab == "Player" then
        createToggle("God Mode", "Player", toggleGodMode).Parent = contentScroll
        createToggle("Anti AFK", "Player", toggleAntiAFK).Parent = contentScroll
        createToggle("Auto Farm", "Player", function(state) end).Parent = contentScroll
        createToggle("ESP Settings", "Player", function(state) end).Parent = contentScroll
        createToggle("No Fall Damage", "Player", function(state) end).Parent = contentScroll
        createToggle("Auto Sprint", "Player", function(state) end).Parent = contentScroll
    end
    
    contentScroll.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y)
end

-- Create Tabs
createTab("Visuals")
createTab("Movement")
createTab("Combat")
createTab("Player")

-- Theme Cycling
local themeOrder = {"Dark", "Light", "Purple", "Green"}
local currentThemeIndex = 1

themeButton.MouseButton1Click:Connect(function()
    currentThemeIndex = currentThemeIndex % #themeOrder + 1
    applyTheme(themeOrder[currentThemeIndex])
    updateTabs()
    updateContent()
end)

-- Close Button
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    for _, conn in pairs(connections) do
        conn:Disconnect()
    end
end)

-- Mobile Toggle
mobileToggle.MouseButton1Click:Connect(function()
    mainContainer.Visible = not mainContainer.Visible
end)

-- Infinite Jump Handler
UserInputService.JumpRequest:Connect(function()
    if config.Movement.infiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Initial Setup
applyTheme(config.currentTheme)
updateContent()
updateTabs()

print("🎮 Advanced Mobile Menu Loaded!")
print("📱 Optimized for: " .. (isMobile and "Mobile" or "Desktop"))
print("🎨 Themes: Dark, Light, Purple, Green")
print("📊 Tabs: Visuals, Movement, Combat, Player")