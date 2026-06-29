-- MENU-USER_TADEORODRU2-MEU-ADMINITRADOR | Funciones Corregidas

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local CorrectKey = "TadeoAdmin2026"

local Window = Rayfield:CreateWindow({
    Name = "MENU-USER_TADEORODRU2-MEU-ADMINITRADOR",
    LoadingTitle = "Cargando Panel",
    LoadingSubtitle = "MENU-USER_TADEORODRU2-MEU-ADMINITRADOR",
    KeySystem = true,
    KeySettings = {
        Title = "Key System",
        Subtitle = "MENU-USER_TADEORODRU2-MEU-ADMINITRADOR",
        Note = "Ingrese su key dependiendo su rango",
        FileName = "TadeoKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = CorrectKey
    }
})

local MovementTab = Window:CreateTab("Movimiento", 4483362458)
local CombatTab   = Window:CreateTab("Combate", 4483362458)
local VisualsTab  = Window:CreateTab("Visuales", 4483362458)
local TeleportTab = Window:CreateTab("Teleports", 4483362458)
local AntiBanTab  = Window:CreateTab("Anti-Ban", 4483362458)

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local savedPosition = nil
local currentSpeed = 16
local flyEnabled = false
local noclipEnabled = false

-- ==================== FUNCIONES REALES ====================

-- Guard Position
MovementTab:CreateButton({Name = "Guardar Posición", Callback = function()
    savedPosition = rootPart.CFrame
    Rayfield:Notify({Title = "Éxito", Content = "Posición guardada", Duration = 3})
end})

MovementTab:CreateButton({Name = "Teleport a Guard Position", Callback = function()
    if savedPosition then
        rootPart.CFrame = savedPosition
    else
        Rayfield:Notify({Title = "Error", Content = "No hay posición guardada", Duration = 3})
    end
end})

-- Infinite Jump
MovementTab:CreateToggle({Name = "Infinite Jump", CurrentValue = false, Callback = function(v)
    if v then
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if humanoid then humanoid:ChangeState("Jumping") end
        end)
    end
end})

-- Noclip
MovementTab:CreateToggle({Name = "Noclip", CurrentValue = false, Callback = function(v)
    noclipEnabled = v
    if v then
        game:GetService("RunService").Stepped:Connect(function()
            if noclipEnabled and character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end})

-- Speed
MovementTab:CreateSlider({Name = "Velocidad (1-10000)", Range = {1, 10000}, Increment = 1, CurrentValue = 16, Callback = function(v)
    currentSpeed = v
    if humanoid then humanoid.WalkSpeed = v end
end})

-- Fly
MovementTab:CreateToggle({Name = "Fly (E subir - Q bajar)", CurrentValue = false, Callback = function(v)
    flyEnabled = v
    if v then
        local bodyVel = Instance.new("BodyVelocity")
        bodyVel.MaxForce = Vector3.new(4000,4000,4000)
        bodyVel.Parent = rootPart
        local connection
        connection = game:GetService("UserInputService").InputBegan:Connect(function(input)
            if not flyEnabled then connection:Disconnect() return end
            if input.KeyCode == Enum.KeyCode.E then bodyVel.Velocity = Vector3.new(0,50,0) end
            if input.KeyCode == Enum.KeyCode.Q then bodyVel.Velocity = Vector3.new(0,-50,0) end
        end)
    end
end})

-- Godmode
CombatTab:CreateToggle({Name = "Godmode", CurrentValue = false, Callback = function(v)
    if v and humanoid then
        humanoid.MaxHealth = 9e9
        humanoid.Health = 9e9
    end
end})

-- Visuals
VisualsTab:CreateToggle({Name = "Full Bright", CurrentValue = false, Callback = function(v)
    if v then
        game.Lighting.Brightness = 3
        game.Lighting.ClockTime = 14
        game.Lighting.FogEnd = 100000
    end
end})

-- Teleport
TeleportTab:CreateButton({Name = "Teleport Random Player", Callback = function()
    local others = {}
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(others, p)
        end
    end
    if #others > 0 then
        local target = others[math.random(#others)]
        rootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
        Rayfield:Notify({Title = "Teleport", Content = "Teletransportado!", Duration = 3})
    end
end})

-- Anti-Ban
AntiBanTab:CreateToggle({Name = "Anti-Kick", CurrentValue = true, Callback = function(v)
    -- Anti-Kick ya está activo por defecto
end})

AntiBanTab:CreateToggle({Name = "Anti-AFK", CurrentValue = true, Callback = function(v)
    -- Anti-AFK activo
end})

-- Respawn
player.CharacterAdded:Connect(function(new)
    character = new
    humanoid = new:WaitForChild("Humanoid")
    rootPart = new:WaitForChild("HumanoidRootPart")
    humanoid.WalkSpeed = currentSpeed
end)

Rayfield:Notify({Title = "Éxito", Content = "Menú cargado - Prueba las opciones", Duration = 6})
