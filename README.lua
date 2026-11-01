-- SADHUB | Premium Troll Panel (Key: askTroll)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

local old = player.PlayerGui:FindFirstChild("SADHUB_PremiumTroll")
if old then old:Destroy() end

-- ===== СИСТЕМА КЛЮЧА =====
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "SADHUB_Key"
keyGui.ResetOnSpawn = false
keyGui.IgnoreGuiInset = true
keyGui.DisplayOrder = 100
keyGui.Parent = player.PlayerGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 320, 0, 180)
keyFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
keyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
keyFrame.Parent = keyGui
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 12)

local keyStroke = Instance.new("UIStroke")
keyStroke.Color = Color3.fromRGB(200, 50, 255)
keyStroke.Thickness = 2
keyStroke.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 45)
keyTitle.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
keyTitle.Text = "🔐 SADHUB | PREMIUM"
keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 16
keyTitle.Parent = keyFrame
Instance.new("UICorner", keyTitle).CornerRadius = UDim.new(0, 12)

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, -40, 0, 40)
keyInput.Position = UDim2.new(0, 20, 0, 60)
keyInput.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.Font = Enum.Font.Gotham
keyInput.TextSize = 14
keyInput.PlaceholderText = "Введите ключ (askTroll)"
keyInput.Text = ""
keyInput.Parent = keyFrame
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 8)

local keyBtn = Instance.new("TextButton")
keyBtn.Size = UDim2.new(1, -40, 0, 40)
keyBtn.Position = UDim2.new(0, 20, 0, 115)
keyBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 220)
keyBtn.Text = "ВОЙТИ"
keyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBtn.Font = Enum.Font.GothamBold
keyBtn.TextSize = 14
keyBtn.Parent = keyFrame
Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 8)

local keyStatus = Instance.new("TextLabel")
keyStatus.Size = UDim2.new(1, -40, 0, 20)
keyStatus.Position = UDim2.new(0, 20, 1, -25)
keyStatus.BackgroundTransparency = 1
keyStatus.Text = ""
keyStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
keyStatus.Font = Enum.Font.Gotham
keyStatus.TextSize = 12
keyStatus.Parent = keyFrame

keyBtn.MouseButton1Click:Connect(function()
    if keyInput.Text == "askTroll" then
        keyStatus.Text = "✅ Добро пожаловать, JudyMoses2504!"
        keyStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
        task.wait(0.5)
        keyGui:Destroy()
        loadPremiumHub()
    else
        keyStatus.Text = "❌ Неверный ключ!"
    end
end)

-- ===== ОСНОВНОЙ ХАБ =====
function loadPremiumHub()
    local isPremiumMode = false
    local targetPlayer = nil
    local activeEffects = {}

    local gui = Instance.new("ScreenGui")
    gui.Name = "SADHUB_PremiumTroll"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 99
    gui.Parent = player.PlayerGui

    -- Главное окно (с анимацией появления)
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 0, 0, 0)
    main.Position = UDim2.new(0.5, -280, 0.5, -220)
    main.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    main.Active = true
    main.Parent = gui
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 16)

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(200, 50, 255)
    stroke.Thickness = 1.5
    stroke.Parent = main

    -- Анимация появления
    TweenService:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 560, 0, 440)
    }):Play()

    -- Перетаскивание
    local dragging, dragInput, dragStart, startPos
    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    main.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- ===== ЗАГОЛОВОК =====
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 45)
    titleBar.BackgroundColor3 = Color3.fromRGB(20, 15, 28)
    titleBar.Parent = main
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 16)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -120, 1, 0)
    title.Position = UDim2.new(0, 20, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "😈 SADHUB | PREMIUM TROLL"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = titleBar

    -- Переключатель Premium Mode
    local premiumToggle = Instance.new("TextButton")
    premiumToggle.Size = UDim2.new(0, 100, 0, 28)
    premiumToggle.Position = UDim2.new(1, -180, 0, 8)
    premiumToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    premiumToggle.Text = "👑 PREMIUM"
    premiumToggle.TextColor3 = Color3.fromRGB(180, 180, 180)
    premiumToggle.Font = Enum.Font.GothamBold
    premiumToggle.TextSize = 11
    premiumToggle.Parent = titleBar
    Instance.new("UICorner", premiumToggle).CornerRadius = UDim.new(0, 6)

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(1, -40, 0, 6)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = titleBar
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    -- ===== БОКОВАЯ ПАНЕЛЬ =====
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 140, 1, -100)
    sidebar.Position = UDim2.new(0, 0, 0, 45)
    sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
    sidebar.Parent = main

    local contentArea = Instance.new("Frame")
    contentArea.Size = UDim2.new(1, -140, 1, -100)
    contentArea.Position = UDim2.new(0, 140, 0, 45)
    contentArea.BackgroundTransparency = 1
    contentArea.Parent = main

    -- ===== ПРОФИЛЬ ВНИЗУ =====
    local profileBar = Instance.new("Frame")
    profileBar.Size = UDim2.new(1, 0, 0, 55)
    profileBar.Position = UDim2.new(0, 0, 1, -55)
    profileBar.BackgroundColor3 = Color3.fromRGB(20, 15, 28)
    profileBar.Parent = main
    Instance.new("UICorner", profileBar).CornerRadius = UDim.new(0, 16)

    local avatar = Instance.new("ImageLabel")
    avatar.Size = UDim2.new(0, 36, 0, 36)
    avatar.Position = UDim2.new(0, 15, 0.5, -18)
    avatar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=150&h=150"
    avatar.Parent = profileBar
    Instance.new("UICorner", avatar).CornerRadius = UDim.new(0, 18)

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0, 200, 0, 20)
    nameLabel.Position = UDim2.new(0, 60, 0, 8)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = profileBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0, 200, 0, 16)
    titleLabel.Position = UDim2.new(0, 60, 0, 28)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "PLAYER"
    titleLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
    titleLabel.Font = Enum.Font.Gotham
    titleLabel.TextSize = 11
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = profileBar

    -- ===== ХЕЛПЕРЫ ДЛЯ UI =====
    local function createTab(text, yPos)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 40)
        btn.Position = UDim2.new(0, 0, 0, yPos)
        btn.BackgroundTransparency = 1
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(150, 150, 160)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 13
        btn.Parent = sidebar
        
        local page = Instance.new("ScrollingFrame")
        page.Size = UDim2.new(1, -10, 1, -10)
        page.Position = UDim2.new(0, 5, 0, 5)
        page.BackgroundTransparency = 1
        page.ScrollBarThickness = 3
        page.Visible = false
        page.Parent = contentArea
        
        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 8)
        layout.Parent = page

        btn.MouseButton1Click:Connect(function()
            for _, child in ipairs(sidebar:GetChildren()) do
                if child:IsA("TextButton") then child.TextColor3 = Color3.fromRGB(150, 150, 160) end
            end
            for _, child in ipairs(contentArea:GetChildren()) do
                if child:IsA("ScrollingFrame") then child.Visible = false end
            end
            btn.TextColor3 = Color3.fromRGB(200, 50, 255)
            page.Visible = true
        end)
        return page
    end

    local function createButton(parent, name, callback, color, isPremiumOnly)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 36)
        btn.BackgroundColor3 = color or Color3.fromRGB(30, 25, 40)
        btn.Text = (isPremiumOnly and "👑 " or "") .. name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.Parent = parent
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        
        btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color and color:Lerp(Color3.new(1,1,1), 0.2) or Color3.fromRGB(50, 40, 60)}):Play() end)
        btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color or Color3.fromRGB(30, 25, 40)}):Play() end)
        btn.MouseButton1Click:Connect(function()
            if isPremiumOnly and not isPremiumMode then
                btn.Text = "❌ Нужен PREMIUM"
                task.wait(1)
                btn.Text = "👑 " .. name
                return
            end
            callback()
        end)
    end

    -- ===== ВКЛАДКИ =====
    local PlayersTab = createTab("👥 Игроки", 5)
    local TrollTab = createTab("💀 Троллинг", 45)
    local ChaosTab = createTab("🌪️ Хаос", 85)
    local PremiumTab = createTab("👑 Premium", 125)
    
    sidebar:GetChildren()[1].TextColor3 = Color3.fromRGB(200, 50, 255)
    PlayersTab.Visible = true

    -- ===== ВКЛАДКА: ИГРОКИ =====
    local playerList = Instance.new("Frame")
    playerList.Size = UDim2.new(1, 0, 0, 250)
    playerList.BackgroundTransparency = 1
    playerList.Parent = PlayersTab
    
    local plrLayout = Instance.new("UIListLayout")
    plrLayout.Padding = UDim.new(0, 6)
    plrLayout.Parent = playerList

    local function updateList()
        for _, v in ipairs(playerList:GetChildren()) do
            if v:IsA("TextButton") then v:Destroy() end
        end
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player then
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 34)
                btn.BackgroundColor3 = Color3.fromRGB(25, 22, 35)
                btn.Text = "  " .. plr.Name
                btn.TextColor3 = Color3.fromRGB(200, 200, 220)
                btn.Font = Enum.Font.Gotham
                btn.TextSize = 12
                btn.TextXAlignment = Enum.TextXAlignment.Left
                btn.Parent = playerList
                Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
                
                btn.MouseButton1Click:Connect(function()
                    targetPlayer = plr
                    for _, b in ipairs(playerList:GetChildren()) do
                        if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(25, 22, 35) end
                    end
                    btn.BackgroundColor3 = Color3.fromRGB(150, 50, 220)
                end)
            end
        end
    end
    updateList()
    Players.PlayerAdded:Connect(updateList)
    Players.PlayerRemoving:Connect(function() task.wait(1) updateList() end)

    local function getTarget()
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            return targetPlayer
        end
        return nil
    end

    -- ===== ВКЛАДКА: ТРОЛЛИНГ (15 функций) =====
    createButton(TrollTab, "🚀 ТП к игроку", function()
        local t = getTarget()
        if t and player.Character then
            player.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
        end
    end, Color3.fromRGB(50, 150, 250))

    createButton(TrollTab, "🌪️ Кинуть в космос", function()
        local t = getTarget()
        if t and t.Character then
            local p = Instance.new("Part")
            p.Size = Vector3.new(2,2,2); p.Transparency = 1; p.CanCollide = false; p.Parent = workspace
            p.CFrame = t.Character.HumanoidRootPart.CFrame
            local w = Instance.new("WeldConstraint"); w.Part0 = t.Character.HumanoidRootPart; w.Part1 = p; w.Parent = p
            p.Velocity = Vector3.new(math.random(-5000,5000), 5000, math.random(-5000,5000))
            p.RotVelocity = Vector3.new(math.random(-5000,5000), math.random(-5000,5000), math.random(-5000,5000))
            task.delay(3, function() p:Destroy() end)
        end
    end, Color3.fromRGB(200, 50, 200))

    createButton(TrollTab, "🧊 Заморозить", function()
        local t = getTarget()
        if t and t.Character then
            for _, part in ipairs(t.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.Anchored = true end
            end
        end
    end, Color3.fromRGB(100, 200, 255))

    createButton(TrollTab, "🔥 Поджечь", function()
        local t = getTarget()
        if t and t.Character then
            local f = Instance.new("Fire"); f.Size = 10; f.Parent = t.Character.HumanoidRootPart
        end
    end, Color3.fromRGB(255, 100, 50))

    createButton(TrollTab, "💥 Взорвать", function()
        local t = getTarget()
        if t and t.Character then
            local e = Instance.new("Explosion"); e.BlastRadius = 15; e.BlastPressure = 500000
            e.Position = t.Character.HumanoidRootPart.Position; e.Parent = workspace
        end
    end, Color3.fromRGB(200, 50, 50))

    createButton(TrollTab, "🎈 Надуть", function()
        local t = getTarget()
        if t and t.Character then
            for _, part in ipairs(t.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.Size = part.Size * 2 end
            end
        end
    end, Color3.fromRGB(255, 150, 50))

    createButton(TrollTab, "🪡 Уменьшить", function()
        local t = getTarget()
        if t and t.Character then
            for _, part in ipairs(t.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.Size = part.Size / 2 end
            end
        end
    end, Color3.fromRGB(50, 255, 150))

    createButton(TrollTab, "💀 Убить", function()
        local t = getTarget()
        if t and t.Character and t.Character:FindFirstChild("Humanoid") then
            t.Character.Humanoid.Health = 0
        end
    end, Color3.fromRGB(200, 20, 20))

    createButton(TrollTab, "🧲 Прилипнуть", function()
        local t = getTarget()
        if t and player.Character then
            player.Character.HumanoidRootPart.CFrame = t.Character.HumanoidRootPart.CFrame
            local w = Instance.new("WeldConstraint"); w.Part0 = t.Character.HumanoidRootPart
            w.Part1 = player.Character.HumanoidRootPart; w.Parent = player.Character.HumanoidRootPart
            task.delay(5, function() if w then w:Destroy() end end)
        end
    end, Color3.fromRGB(150, 150, 50))

    createButton(TrollTab, "🌀 Закрутить (Spin)", function()
        local t = getTarget()
        if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
            local p = Instance.new("Part"); p.Size = Vector3.new(1,1,1); p.Transparency = 1; p.CanCollide = false; p.Parent = workspace
            p.CFrame = t.Character.HumanoidRootPart.CFrame
            local w = Instance.new("WeldConstraint"); w.Part0 = t.Character.HumanoidRootPart; w.Part1 = p; w.Parent = p
            p.RotVelocity = Vector3.new(9999, 9999, 9999)
            task.delay(2, function() p:Destroy() end)
        end
    end, Color3.fromRGB(180, 50, 180))

    createButton(TrollTab, "🦴 Сломать (Break)", function()
        local t = getTarget()
        if t and t.Character then
            t.Character:BreakJoints()
        end
    end, Color3.fromRGB(150, 150, 150))

    createButton(TrollTab, "👻 Прозрачность", function()
        local t = getTarget()
        if t and t.Character then
            for _, part in ipairs(t.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.Transparency = 0.8 end
            end
        end
    end, Color3.fromRGB(100, 100, 200))

    createButton(TrollTab, "🎵 Спам звуком", function()
        local t = getTarget()
        if t and t.Character then
            local s = Instance.new("Sound"); s.SoundId = "rbxassetid://1837879082"; s.Volume = 10
            s.Parent = t.Character.HumanoidRootPart; s:Play()
        end
    end, Color3.fromRGB(200, 100, 200))

    createButton(TrollTab, "💨 Скорость 0", function()
        local t = getTarget()
        if t and t.Character and t.Character:FindFirstChild("Humanoid") then
            t.Character.Humanoid.WalkSpeed = 0
        end
    end, Color3.fromRGB(100, 200, 100))

    createButton(TrollTab, "🚀 Скорость 500", function()
        local t = getTarget()
        if t and t.Character and t.Character:FindFirstChild("Humanoid") then
            t.Character.Humanoid.WalkSpeed = 500
        end
    end, Color3.fromRGB(200, 200, 50))

    -- ===== ВКЛАДКА: ХАОС =====
    createButton(ChaosTab, "🌍 Нулевая гравитация", function() workspace.Gravity = 0 end, Color3.fromRGB(100, 100, 255))
    createButton(ChaosTab, "🌍 Космическая гравитация", function() workspace.Gravity = 300 end, Color3.fromRGB(255, 100, 100))
    createButton(ChaosTab, "☀️ День", function() Lighting.ClockTime = 12 end, Color3.fromRGB(255, 255, 100))
    createButton(ChaosTab, "🌙 Ночь", function() Lighting.ClockTime = 0 end, Color3.fromRGB(50, 50, 100))
    createButton(ChaosTab, "💡 Fullbright", function()
        Lighting.Brightness = 5; Lighting.OutdoorAmbient = Color3.new(1,1,1); Lighting.Ambient = Color3.new(1,1,1)
    end, Color3.fromRGB(255, 255, 255))
    createButton(ChaosTab, "🟥 Красный туман", function() Lighting.FogColor = Color3.new(1,0,0); Lighting.FogEnd = 50 end, Color3.fromRGB(200, 0, 0))
        createButton(ChaosTab, "🎵 Громкая музыка", function()
        local s = Instance.new("Sound"); s.SoundId = "rbxassetid://1837879082"; s.Volume = 10; s.Looped = true
        s.Parent = workspace; s:Play()
    end, Color3.fromRGB(200, 50, 200))

    -- ===== ВКЛАДКА: PREMIUM (Эксклюзивные функции) =====
    createButton(PremiumTab, "☄️ Метеоритный дождь", function()
        for i = 1, 15 do
            task.spawn(function()
                local p = Instance.new("Part"); p.Size = Vector3.new(5,5,5)
                p.Position = player.Character.HumanoidRootPart.Position + Vector3.new(math.random(-60,60), 120, math.random(-60,60))
                p.Color = Color3.fromRGB(255, 100, 0); p.Parent = workspace
                p.Velocity = Vector3.new(0, -500, 0)
                task.delay(5, function() p:Destroy() end)
            end)
            task.wait(0.1)
        end
    end, Color3.fromRGB(255, 50, 0), true)

    createButton(PremiumTab, "🌌 Черная дыра", function()
        local t = getTarget()
        if t and t.Character then
            local p = Instance.new("Part"); p.Size = Vector3.new(5,5,5); p.Transparency = 0.5; p.Color = Color3.new(0,0,0); p.Parent = workspace
            p.Position = t.Character.HumanoidRootPart.Position + Vector3.new(0, 10, 0)
            p.Anchored = true
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local dir = (p.Position - plr.Character.HumanoidRootPart.Position).Unit
                    plr.Character.HumanoidRootPart.Velocity = dir * 500
                end
            end
            task.delay(3, function() p:Destroy() end)
        end
    end, Color3.fromRGB(50, 0, 100), true)

    createButton(PremiumTab, "👑 Выдать титул ADMIN", function()
        local t = getTarget() or player
        if t and t.Character and t.Character:FindFirstChild("Head") then
            local b = Instance.new("BillboardGui"); b.Name = "SADHUB_Title"; b.Size = UDim2.new(0, 200, 0, 50)
            b.StudsOffset = Vector3.new(0, 2.5, 0); b.AlwaysOnTop = true; b.Parent = t.Character.Head
            local l = Instance.new("TextLabel"); l.Size = UDim2.new(1,0,1,0); l.BackgroundTransparency = 1
            l.Text = "👑 ADMIN"; l.TextColor3 = Color3.fromRGB(255, 215, 0); l.Font = Enum.Font.GothamBold
            l.TextSize = 20; l.TextStrokeTransparency = 0; l.Parent = b
        end
    end, Color3.fromRGB(255, 215, 0), true)

    createButton(PremiumTab, "🛡️ God Mode (визуально)", function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.MaxHealth = math.huge
            player.Character.Humanoid.Health = math.huge
        end
    end, Color3.fromRGB(0, 200, 100), true)

    -- ===== ЛОГИКА PREMIUM MODE =====
    premiumToggle.MouseButton1Click:Connect(function()
        isPremiumMode = not isPremiumMode
        if isPremiumMode then
            premiumToggle.Text = "👑 PREMIUM ON"
            premiumToggle.BackgroundColor3 = Color3.fromRGB(150, 50, 220)
            premiumToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            titleLabel.Text = "👑 ADMIN"
            titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
            stroke.Color = Color3.fromRGB(255, 215, 0)
            -- Выдаем титул себе
            if player.Character and player.Character:FindFirstChild("Head") then
                local b = player.Character.Head:FindFirstChild("SADHUB_Title") or Instance.new("BillboardGui")
                b.Name = "SADHUB_Title"; b.Size = UDim2.new(0, 200, 0, 50)
                b.StudsOffset = Vector3.new(0, 2.5, 0); b.AlwaysOnTop = true; b.Parent = player.Character.Head
                local l = b:FindFirstChildOfClass("TextLabel") or Instance.new("TextLabel")
                l.Size = UDim2.new(1,0,1,0); l.BackgroundTransparency = 1
                l.Text = "👑 ADMIN"; l.TextColor3 = Color3.fromRGB(255, 215, 0); l.Font = Enum.Font.GothamBold
                l.TextSize = 20; l.TextStrokeTransparency = 0; l.Parent = b
            end
        else
            premiumToggle.Text = "👑 PREMIUM"
            premiumToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
            premiumToggle.TextColor3 = Color3.fromRGB(180, 180, 180)
            titleLabel.Text = "PLAYER"
            titleLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
            stroke.Color = Color3.fromRGB(200, 50, 255)
            if player.Character and player.Character:FindFirstChild("Head") then
                local b = player.Character.Head:FindFirstChild("SADHUB_Title")
                if b then b:Destroy() end
            end
        end
    end)
end
