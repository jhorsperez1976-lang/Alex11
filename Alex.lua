--// MENU ADMIN - TIKTOK : ALEX@11 + OJO
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

local savedPosition = nil
local infiniteJumpEnabled = false
local noclipEnabled = false
local currentSpeed = 16
local menuVisible = true

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MenuAdmin"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- OJO FIJO
local eyeButton = Instance.new("ImageButton")
eyeButton.Size = UDim2.new(0, 55, 0, 55)
eyeButton.Position = UDim2.new(0, 15, 0, 15)
eyeButton.BackgroundTransparency = 1
eyeButton.Image = "rbxassetid://3926305904"
eyeButton.ImageColor3 = Color3.fromRGB(0, 255, 200)
eyeButton.Parent = screenGui

-- MENÚ
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 380)
mainFrame.Position = UDim2.new(0.5, -140, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 128, 128)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = true
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(0, 100, 100)
title.Text = "TIKTOK : ALEX@11"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local y = 0.12
local function createButton(text, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, y, 0)
    btn.BackgroundColor3 = color or Color3.fromRGB(0, 160, 160)
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = mainFrame
    y = y + 0.13
    return btn
end

local btnSave = createButton("💾 GUARDAR POSICIÓN", Color3.fromRGB(0, 180, 180))
local btnTP = createButton("⚡ TELEPORT", Color3.fromRGB(0, 200, 200))
local btnInfJump = createButton("♾️ INFINITE JUMP: OFF")
local btnNoclip = createButton("👻 NOCLIP: OFF")

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.9, 0, 0, 30)
speedLabel.Position = UDim2.new(0.05, 0, y, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Velocidad: " .. currentSpeed
speedLabel.TextColor3 = Color3.new(1,1,1)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.Gotham
speedLabel.Parent = mainFrame

local speedSlider = Instance.new("TextBox")
speedSlider.Size = UDim2.new(0.9, 0, 0, 40)
speedSlider.Position = UDim2.new(0.05, 0, y + 0.08, 0)
speedSlider.BackgroundColor3 = Color3.fromRGB(0, 100, 100)
speedSlider.Text = tostring(currentSpeed)
speedSlider.TextColor3 = Color3.new(1,1,1)
speedSlider.TextScaled = true
speedSlider.Font = Enum.Font.GothamBold
speedSlider.Parent = mainFrame

eyeButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    mainFrame.Visible = menuVisible
end)

-- Funciones del menú
btnSave.MouseButton1Click:Connect(function()
    savedPosition = root.Position
    btnSave.Text = "✅ POSICIÓN GUARDADA"
    task.wait(1)
    btnSave.Text = "💾 GUARDAR POSICIÓN"
end)

btnTP.MouseButton1Click:Connect(function()
    if savedPosition then
        root.CFrame = CFrame.new(savedPosition + Vector3.new(0, 4, 0))
        btnTP.Text = "✅ TELEPORT!"
        task.wait(1)
        btnTP.Text = "⚡ TELEPORT"
    else
        btnTP.Text = "❌ Guarda primero"
        task.wait(1.5)
        btnTP.Text = "⚡ TELEPORT"
    end
end)

btnInfJump.MouseButton1Click:Connect(function()
    infiniteJumpEnabled = not infiniteJumpEnabled
    btnInfJump.Text = "♾️ INFINITE JUMP: " .. (infiniteJumpEnabled and "ON" or "OFF")
    btnInfJump.BackgroundColor3 = infiniteJumpEnabled and Color3.fromRGB(0, 220, 100) or Color3.fromRGB(0, 160, 160)
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if infiniteJumpEnabled and humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

local noclipLoop
btnNoclip.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    btnNoclip.Text = "👻 NOCLIP: " .. (noclipEnabled and "ON" or "OFF")
    btnNoclip.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 220, 100) or Color3.fromRGB(0, 160, 160)

    if noclipEnabled then
        noclipLoop = game:GetService("RunService").Stepped:Connect(function()
            if character and character.Parent then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipLoop then noclipLoop:Disconnect() end
        if character and character.Parent then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
    end
end)

speedSlider.FocusLost:Connect(function()
    local num = tonumber(speedSlider.Text)
    if num then
        currentSpeed = math.clamp(num, 1, 10000)
        humanoid.WalkSpeed = currentSpeed
        speedLabel.Text = "Velocidad: " .. currentSpeed
        speedSlider.Text = tostring(currentSpeed)
    end
end)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    root = newChar:WaitForChild("HumanoidRootPart")
    humanoid.WalkSpeed = currentSpeed
end)

humanoid.WalkSpeed = currentSpeed
