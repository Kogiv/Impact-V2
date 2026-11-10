--[[
    ═══════════════════════════════════════════
              MM2 Impact  |  by Kogiv
         t.me/Kogiv_script
    ═══════════════════════════════════════════
    ЧАСТЬ 1 / 3 — UI и компоненты
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local Config = {
    AutoFarm = false,
    AutoFarmSpeed = 60,
    ESP = false,
    Noclip = false,
    Fly = false,
    FlySpeed = 60,
    MaxBag = 50,
    AutoReset = true,
    AntiAFK = true,
}

-- ═══════════════════════════════════════════
--                    UI
-- ═══════════════════════════════════════════

local gui = Instance.new("ScreenGui")
gui.Name = "MM2Impact_" .. tostring(math.random(1, 999999))
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 320, 0, 470)
Main.Position = UDim2.new(0.5, -160, 0.5, -235)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
Main.BorderSizePixel = 0
Main.Active = true
Main.Parent = gui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)
Instance.new("UIStroke", Main).ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local stroke = Main:FindFirstChildOfClass("UIStroke")
stroke.Color = Color3.fromRGB(110, 70, 230)
stroke.Thickness = 1.8

local bgGrad = Instance.new("UIGradient")
bgGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 24, 48)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 14, 22)),
})
bgGrad.Rotation = 45
bgGrad.Parent = Main

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 55)
Title.BackgroundTransparency = 1
Title.Text = "MM2 Impact"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = Main

local tGrad = Instance.new("UIGradient")
tGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 120, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 120, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 170, 255)),
})
tGrad.Parent = Title

local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0.88, 0, 0, 1)
Divider.Position = UDim2.new(0.06, 0, 0, 55)
Divider.BackgroundColor3 = Color3.fromRGB(90, 60, 180)
Divider.BorderSizePixel = 0
Divider.Parent = Main

-- Close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -34, 0, 14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(60, 40, 100)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = Main

Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Content — ScrollingFrame
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(0.88, 0, 0, 340)
Content.Position = UDim2.new(0.06, 0, 0, 72)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.ScrollBarImageColor3 = Color3.fromRGB(110, 70, 230)
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.ScrollingDirection = Enum.ScrollingDirection.Y
Content.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 10)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = Content

-- ═══════════════════════════════════════════
--                Components
-- ═══════════════════════════════════════════
local function createToggle(name, default, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 44)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 26, 44)
    Btn.AutoButtonColor = false
    Btn.Text = ""
    Btn.Parent = Content

    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)

    local s = Instance.new("UIStroke", Btn)
    s.Color = Color3.fromRGB(60, 50, 90)
    s.Thickness = 1

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -80, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(225, 225, 235)
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = Btn

    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, 44, 0, 22)
    track.Position = UDim2.new(1, -54, 0.5, -11)
    track.BackgroundColor3 = Color3.fromRGB(50, 44, 66)
    track.Parent = Btn

    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 2, 0.5, -9)
    knob.BackgroundColor3 = Color3.fromRGB(150, 150, 160)
    knob.Parent = track

    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local state = default or false

    local function render()
        TweenService:Create(track, TweenInfo.new(0.18), {
            BackgroundColor3 = state and Color3.fromRGB(110, 70, 230) or Color3.fromRGB(50, 44, 66)
        }):Play()
        TweenService:Create(knob, TweenInfo.new(0.18), {
            Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9),
            BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 160)
        }):Play()
    end

    render()

    Btn.MouseButton1Click:Connect(function()
        state = not state
        render()
        callback(state)
    end)
end

local function createSlider(name, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 62)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 26, 44)
    Frame.Parent = Content

    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

    local s = Instance.new("UIStroke", Frame)
    s.Color = Color3.fromRGB(60, 50, 90)
    s.Thickness = 1

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -24, 0, 24)
    label.Position = UDim2.new(0, 14, 0, 6)
    label.BackgroundTransparency = 1
    label.Text = name .. ": " .. tostring(default)
    label.TextColor3 = Color3.fromRGB(225, 225, 235)
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = Frame

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -28, 0, 6)
    bar.Position = UDim2.new(0, 14, 0, 42)
    bar.BackgroundColor3 = Color3.fromRGB(50, 44, 66)
    bar.Parent = Frame

    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(130, 80, 230)
    fill.Parent = bar

    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local dragging = false

    local function update(x)
        local rel = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max - min) * rel + 0.5)
        fill.Size = UDim2.new(rel, 0, 1, 0)
        label.Text = name .. ": " .. val
        callback(val)
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update(input.Position.X)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
            update(input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end
--[[
    ═══════════════════════════════════════════
              MM2 Impact  |  by Kogiv
         t.me/Kogiv_script
    ═══════════════════════════════════════════
    ЧАСТЬ 2A / 3 — Autofarm (smooth) + Auto Reset + Fly
]]

-- ═══════════════════════════════════════════
--           AUTOFARM + AUTO RESET
-- ═══════════════════════════════════════════

local coinCache = {}
local lastRefresh = 0
local farmConn = nil
local blacklist = {}

local roundCollected = {}
local roundCount = 0
local resetTriggered = false

local function isBlacklisted(coin)
    local t = blacklist[coin]
    if not t then return false end
    if tick() > t then
        blacklist[coin] = nil
        return false
    end
    return true
end

local function blacklistCoin(coin, sec)
    blacklist[coin] = tick() + (sec or 5)
end

local function refreshCoinCache()
    if tick() - lastRefresh < 0.7 then return end
    lastRefresh = tick()

    local newCache = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local n = obj.Name:lower()
            if n:find("coin") or n:find("money") or n:find("cash")
            or n:find("bitcoin") or n:find("gem") or n:find("orb") then
                table.insert(newCache, obj)
            end
        end
    end
    coinCache = newCache
end

local function stopFarm()
    if farmConn then
        farmConn:Disconnect()
        farmConn = nil
    end
end

local function triggerReset()
    if resetTriggered then return end
    resetTriggered = true
    task.spawn(function()
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                pcall(function() hum.Health = 0 end)
            end
        end
    end)
end

local function startFarm()
    stopFarm()

    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp and hrp:CanSetNetworkOwnership() then
            pcall(function() hrp:SetNetworkOwner(LocalPlayer) end)
        end
    end

    farmConn = RunService.Heartbeat:Connect(function(dt)
        if not Config.AutoFarm then return end

        refreshCoinCache()

        local char2 = LocalPlayer.Character
        if not char2 then return end
        local hrp = char2:FindFirstChild("HumanoidRootPart")
        local hum = char2:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end
        if hum.Health <= 0 then return end

        local target, minDist = nil, math.huge
        for i = #coinCache, 1, -1 do
            local coin = coinCache[i]
            if not coin or not coin.Parent or isBlacklisted(coin) then
                table.remove(coinCache, i)
            else
                local dy = coin.Position.Y - hrp.Position.Y
                if dy < 8 then
                    local d = (coin.Position - hrp.Position).Magnitude
                    if d < minDist then
                        target, minDist = coin, d
                    end
                end
            end
        end
        if target then
            if minDist <= 1.2 then
                blacklistCoin(target, 5)
                if not roundCollected[target] then
                    roundCollected[target] = true
                    roundCount = roundCount + 1
                end
                if Config.AutoReset and not resetTriggered and roundCount >= Config.MaxBag then
                    triggerReset()
                end
            else
                local dir = (target.Position - hrp.Position).Unit
                local step = math.min(Config.AutoFarmSpeed * dt, minDist - 0.8)
                if step > 0 then
                    hrp.CFrame = hrp.CFrame + dir * step
                end
            end
            hrp.AssemblyLinearVelocity = Vector3.zero
        end
    end)
end

-- ═══════════════════════════════════════════
--                    FLY
-- ═══════════════════════════════════════════

local flyConn

local function stopFly()
    if flyConn then
        flyConn:Disconnect()
        flyConn = nil
    end
end

local function startFly()
    stopFly()

    flyConn = RunService.RenderStepped:Connect(function(dt)
        if not Config.Fly then return end
        if Config.AutoFarm then return end

        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end

        local cam = workspace.CurrentCamera
        if not cam then return end

        local moveDir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)
        or UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDir -= Vector3.new(0, 1, 0)
        end

        if moveDir.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + moveDir.Unit * Config.FlySpeed * dt
        end
        hrp.AssemblyLinearVelocity = Vector3.zero
    end)
end
--[[
    ═══════════════════════════════════════════
              MM2 Impact  |  by Kogiv
         t.me/Kogiv_script
    ═══════════════════════════════════════════
    ЧАСТЬ 2B / 3 — ESP, Noclip, Ghost, Anti-AFK, UI, RShift
]]

-- ═══════════════════════════════════════════
--                    ESP
-- ═══════════════════════════════════════════

local espCache = {}

local function removeESP(player)
    if espCache[player] then
        espCache[player]:Destroy()
        espCache[player] = nil
    end
end

local function applyESP(player)
    if player == LocalPlayer then return end
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    removeESP(player)

    local bb = Instance.new("BillboardGui")
    bb.Name = "MM2Impact_ESP"
    bb.Adornee = hrp
    bb.Size = UDim2.new(0, 120, 0, 40)
    bb.AlwaysOnTop = true
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.Parent = hrp

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1, 0, 0.5, 0)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = player.Name
    nameLbl.TextColor3 = Color3.fromRGB(255, 90, 90)
    nameLbl.TextStrokeTransparency = 0
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextSize = 14
    nameLbl.Parent = bb
    local distLbl = Instance.new("TextLabel")
    distLbl.Size = UDim2.new(1, 0, 0.5, 0)
    distLbl.Position = UDim2.new(0, 0, 0.5, 0)
    distLbl.BackgroundTransparency = 1
    distLbl.Text = "0m"
    distLbl.TextColor3 = Color3.fromRGB(255, 220, 120)
    distLbl.TextStrokeTransparency = 0
    distLbl.Font = Enum.Font.Gotham
    distLbl.TextSize = 12
    distLbl.Parent = bb

    espCache[player] = bb
end

task.spawn(function()
    while true do
        if Config.ESP then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local char = player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        if not espCache[player] or espCache[player].Adornee ~= char.HumanoidRootPart then
                            applyESP(player)
                        end
                        local bb = espCache[player]
                        if bb then
                            local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if myHRP then
                                local d = math.floor((char.HumanoidRootPart.Position - myHRP.Position).Magnitude)
                                local labels = {}
                                for _, c in ipairs(bb:GetChildren()) do
                                    if c:IsA("TextLabel") then table.insert(labels, c) end
                                end
                                if labels[2] then labels[2].Text = d .. "m" end
                            end
                        end
                    else
                        removeESP(player)
                    end
                end
            end
            for p in pairs(espCache) do
                if not p.Parent or not p.Character then removeESP(p) end
            end
        else
            for p in pairs(espCache) do removeESP(p) end
        end
        task.wait(0.5)
    end
end)

Players.PlayerRemoving:Connect(removeESP)

-- ═══════════════════════════════════════════
--                   Noclip
-- ═══════════════════════════════════════════

local noclipConn
local function setNoclip(state)
    if noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end
    if state then
        noclipConn = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if not char then return end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    end
end

-- ═══════════════════════════════════════════
--                   Ghost
-- ═══════════════════════════════════════════

local GhostEnabled = false

local function applyGhost()
    local char = LocalPlayer.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = GhostEnabled and 1 or 0
        elseif part:IsA("Decal") or part:IsA("Texture") then
            part.Transparency = GhostEnabled and 1 or 0
        end
    end
end

-- ═══════════════════════════════════════════
--                  ANTI-AFK
-- ═══════════════════════════════════════════

local antiAfkConn
local function setAntiAFK(state)
    if antiAfkConn then
        antiAfkConn:Disconnect()
        antiAfkConn = nil
    end
    if state then
        antiAfkConn = LocalPlayer.Idled:Connect(function()
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new(0, 0))
            end)
        end)
    end
end

-- ═══════════════════════════════════════════
--               Подключение UI
-- ═══════════════════════════════════════════

createToggle("Autofarm", false, function(v)
    Config.AutoFarm = v
    if v then startFarm() else stopFarm() end
end)
createSlider("AutoFarm Speed", 10, 250, Config.AutoFarmSpeed, function(v)
    Config.AutoFarmSpeed = v
end)

createToggle("Auto Reset (bag full)", true, function(v)
    Config.AutoReset = v
end)

createSlider("Max Bag Size", 10, 100, Config.MaxBag, function(v)
    Config.MaxBag = v
end)

createToggle("Fly", false, function(v)
    Config.Fly = v
    if v then startFly() else stopFly() end
end)

createSlider("Fly Speed", 10, 200, Config.FlySpeed, function(v)
    Config.FlySpeed = v
end)

createToggle("ESP (Players)", false, function(v)
    Config.ESP = v
    if not v then
        for p in pairs(espCache) do removeESP(p) end
    end
end)

createToggle("Noclip", false, function(v)
    Config.Noclip = v
    setNoclip(v)
end)

createToggle("Ghost (Invisible)", false, function(v)
    GhostEnabled = v
    applyGhost()
end)

createToggle("Anti-AFK", true, function(v)
    Config.AntiAFK = v
    setAntiAFK(v)
end)

-- Включаем Anti-AFK сразу при загрузке (по умолчанию ON)
setAntiAFK(true)

-- ═══════════════════════════════════════════
--              RightShift — toggle меню
-- ═══════════════════════════════════════════

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        Main.Visible = not Main.Visible
    end
end)

-- ═══════════════════════════════════════════
--                  Footer
-- ═══════════════════════════════════════════

local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1, 0, 0, 40)
Footer.Position = UDim2.new(0, 0, 1, -46)
Footer.BackgroundTransparency = 1
Footer.Text = "by Kogiv  •  t.me/Kogiv_script\n[RShift] — скрыть/показать меню"
Footer.Font = Enum.Font.GothamMedium
Footer.TextSize = 12
Footer.TextColor3 = Color3.fromRGB(140, 130, 190)
Footer.Parent = Main

-- ═══════════════════════════════════════════
--            Респавн — сброс счётчиков
-- ═══════════════════════════════════════════

local function bindCharacter(char)
    roundCollected = {}
    roundCount = 0
    resetTriggered = false
    coinCache = {}
    lastRefresh = 0

    char:WaitForChild("HumanoidRootPart", 10)
    task.wait(0.3)

    if Config.Noclip then setNoclip(true) end
    if GhostEnabled then applyGhost() end
    if Config.AutoFarm then startFarm() end
    if Config.Fly then startFly() end
end

LocalPlayer.CharacterAdded:Connect(bindCharacter)
if LocalPlayer.Character then bindCharacter(LocalPlayer.Character) end

-- ═══════════════════════════════════════════
--            Перетаскивание окна
-- ═══════════════════════════════════════════

local dragging, dragStart, startPos
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
