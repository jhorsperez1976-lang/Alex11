--// TIKTOK : ALEX@11 - Orbiez Escape (v8 - Posición Arreglada)
-- LocalScript

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local savedPosition = nil
local infiniteJumpEnabled = false
local noclipEnabled = false
local autoTeleportEnabled = false
local flyEnabled = false
local currentSpeed = 16
local flySpeed = 60

local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- OJO
local eyeButton = Instance.new("ImageButton")
eyeButton.Size = UDim2.new(0, 70, 0, 70)
eyeButton.Position = UDim2.new(0, 20, 0, 20)
eyeButton.BackgroundTransparency = 1
eyeButton.Image = "rbxassetid://3926305904"
eyeButton.ImageColor3 = Color3.fromRGB(0, 255, 170)
eyeButton.Parent = screenGui

-- MENÚ
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 480)
mainFrame.Position = UDim2.new(0.5, -160, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 65)
title.BackgroundColor3 = Color3.fromRGB(0, 170, 140)
title.Text = "TIKTOK : ALEX@11"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local y = 0.14
local function createButton(text, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 48)
    btn.Position = UDim2.new(0.05, 0, y, 0)
    btn.BackgroundColor3 = color or Color3.fromRGB(0, 120, 110)
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = mainFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    y = y + 0.105
    return btn
end

local btnSave = createButton("💾 GUARDAR POSICIÓN", Color3.fromRGB(0, 180, 160))
local btnTP = createButton("⚡ TELEPORT MANUAL")
local btnAutoTP = createButton("🔄 AUTO TELEPORT: OFF")
local btnFly = createButton("🕊️ FLY: OFF")
local btnInfJump = createButton("♾️ INFINITE JUMP: OFF")
local btnNoclip = createButton("👻 NOCLIP: OFF")
local btnGod = createButton("🛡️ ANTI MUERTE")

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.9, 0, 0, 35)
speedLabel.Position = UDim2.new(0.05, 0, y, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Velocidad: " .. currentSpeed
speedLabel.TextColor3 = Color3.new(1,1,1)
speedLabel.TextScaled = true
speedLabel.Parent = mainFrame

local speedSlider = Instance.new("TextBox")
speedSlider.Size = UDim2.new(0.9, 0, 0, 45)
speedSlider.Position = UDim2.new(0.05, 0, y + 0.08, 0)
speedSlider.BackgroundColor3 = Color3.fromRGB(0, 100, 90)
speedSlider.Text = "16"
speedSlider.TextColor3 = Color3.new(1,1,1)
speedSlider.TextScaled = true
speedSlider.Parent = mainFrame

-- Toggle menú
eyeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- Guardar Posición (Arreglado)
btnSave.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        savedPosition = player.Character.HumanoidRootPart.Position
        btnSave.Text = "✅ POSICIÓN GUARDADA"
        task.wait(1.5)
        btnSave.Text = "💾 GUARDAR POSICIÓN"
    end
end)

btnTP.MouseButton1Click:Connect(function()
    if savedPosition and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition + Vector3.new(0, 6, 0))
    end
end)

btnAutoTP.MouseButton1Click:Connect(function()
    autoTeleportEnabled = not autoTeleportEnabled
    btnAutoTP.Text = "🔄 AUTO TELEPORT: " .. (autoTeleportEnabled and "ON" or "OFF")
end)

btnFly.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    btnFly.Text = "🕊️ FLY: " .. (flyEnabled and "ON" or "OFF")
end)

btnInfJump.MouseButton1Click:Connect(function()
    infiniteJumpEnabled = not infiniteJumpEnabled
    btnInfJump.Text = "♾️ INFINITE JUMP: " .. (infiniteJumpEnabled and "ON" or "OFF")
end)

btnNoclip.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    btnNoclip.Text = "👻 NOCLIP: " .. (noclipEnabled and "ON" or "OFF")
end)

btnGod.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.MaxHealth = math.huge
        player.Character.Humanoid.Health = math.huge
    end
end)

-- Loop principal
RunService.Heartbeat:Connect(function()
    -- Velocidad persistente
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = currentSpeed
    end

    -- Noclip
    if noclipEnabled and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end

    -- Auto Teleport
    if autoTeleportEnabled and savedPosition and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition + Vector3.new(0, 6, 0))
    end
end)

-- Fly
local bodyVelocity
btnFly.MouseButton1Click:Connect(function()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if flyEnabled and root then
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bodyVelocity.Parent = root
        while flyEnabled and root do
            local move = Vector3.new(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + root.CFrame.LookVector * flySpeed end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - root.CFrame.LookVector * flySpeed end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - root.CFrame.RightVector * flySpeed end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + root.CFrame.RightVector * flySpeed end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) * flySpeed end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0,1,0) * flySpeed end
            bodyVelocity.Velocity = move
            task.wait()
        end
        if bodyVelocity then bodyVelocity:Destroy() end
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Velocidad
speedSlider.FocusLost:Connect(function()
    local num = tonumber(speedSlider.Text)
    if num then
        currentSpeed = math.clamp(num, 1, 200000)
        speedLabel.Text = "Velocidad: " .. currentSpeed
        speedSlider.Text = tostring(currentSpeed)
    end
end)

player.CharacterAdded:Connect(function(char)
    task.wait(1)
    if char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = currentSpeed
    end
end)
