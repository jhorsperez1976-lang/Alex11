--// TIKTOK : ALEX@11 - Velocidad Ajustable + Menú Fijo
-- LocalScript

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local infJump = false
local noclip = false
local god = false
local currentSpeed = 16  -- Velocidad actual

-- Sonido
local function playSound()
	local s = Instance.new("Sound")
	s.SoundId = "rbxassetid://131057999"
	s.Volume = 0.5
	s.Parent = game.SoundService
	s:Play()
	game.Debris:AddItem(s, 2)
end

-- Key
local keyScreen = Instance.new("ScreenGui")
keyScreen.ResetOnSpawn = false
keyScreen.Parent = playerGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 400, 0, 220)
keyFrame.Position = UDim2.new(0.5, -200, 0.15, 0)
keyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
keyFrame.Parent = keyScreen
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 16)

local kt = Instance.new("TextLabel")
kt.Size = UDim2.new(1,0,0,50)
kt.Text = "TIKTOK : ALEX@11"
kt.TextColor3 = Color3.fromRGB(255, 0, 0)
kt.TextScaled = true
kt.Font = Enum.Font.GothamBold
kt.BackgroundTransparency = 1
kt.Parent = keyFrame

local ki = Instance.new("TextBox")
ki.Size = UDim2.new(0.85,0,0,50)
ki.Position = UDim2.new(0.075,0,0.35,0)
ki.PlaceholderText = "v1script=alex"
ki.TextScaled = true
ki.Parent = keyFrame
Instance.new("UICorner", ki).CornerRadius = UDim.new(0,10)

local kb = Instance.new("TextButton")
kb.Size = UDim2.new(0.5,0,0,45)
kb.Position = UDim2.new(0.25,0,0.65,0)
kb.Text = "VERIFICAR KEY"
kb.BackgroundColor3 = Color3.fromRGB(255,0,0)
kb.TextColor3 = Color3.fromRGB(255,255,255)
kb.TextScaled = true
kb.Parent = keyFrame
Instance.new("UICorner", kb).CornerRadius = UDim.new(0,10)

kb.MouseButton1Click:Connect(function()
	if ki.Text == "v1script=alex" then
		keyScreen:Destroy()
		loadMenu()
	end
end)

-- ==================== MENÚ ====================
function loadMenu()
	local sg = Instance.new("ScreenGui")
	sg.ResetOnSpawn = false
	sg.Parent = playerGui

	-- Ojo pequeño fijo
	local eye = Instance.new("Frame")
	eye.Size = UDim2.new(0, 45, 0, 45)
	eye.Position = UDim2.new(0.02, 0, 0.02, 0)
	eye.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	eye.Parent = sg
	Instance.new("UICorner", eye).CornerRadius = UDim.new(1, 0)

	local pupil = Instance.new("Frame")
	pupil.Size = UDim2.new(0, 18, 0, 18)
	pupil.Position = UDim2.new(0.5, -9, 0.5, -9)
	pupil.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	pupil.Parent = eye
	Instance.new("UICorner", pupil).CornerRadius = UDim.new(1, 0)

	-- Menú fijo
	local menu = Instance.new("Frame")
	menu.Size = UDim2.new(0, 460, 0, 620)
	menu.Position = UDim2.new(0.5, -230, 0.5, -310)
	menu.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
	menu.Visible = false
	menu.Parent = sg
	Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 18)

	local mtitle = Instance.new("TextLabel")
	mtitle.Size = UDim2.new(1,0,0,70)
	mtitle.Text = "TIKTOK : ALEX@11"
	mtitle.TextColor3 = Color3.fromRGB(255, 0, 0)
	mtitle.TextScaled = true
	mtitle.Font = Enum.Font.GothamBold
	mtitle.BackgroundTransparency = 1
	mtitle.Parent = menu

	local close = Instance.new("TextButton")
	close.Size = UDim2.new(0,50,0,50)
	close.Position = UDim2.new(1,-55,0,10)
	close.Text = "✕"
	close.TextColor3 = Color3.fromRGB(255,80,80)
	close.TextScaled = true
	close.BackgroundTransparency = 1
	close.Parent = menu

	local scroll = Instance.new("ScrollingFrame")
	scroll.Size = UDim2.new(1,-20,1,-90)
	scroll.Position = UDim2.new(0,10,0,80)
	scroll.BackgroundTransparency = 1
	scroll.Parent = menu
	Instance.new("UIListLayout", scroll).Padding = UDim.new(0,8)

	local function addBtn(text, callback)
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(1,0,0,55)
		b.BackgroundColor3 = Color3.fromRGB(35,35,35)
		b.Text = text
		b.TextColor3 = Color3.fromRGB(255,255,255)
		b.TextScaled = true
		b.Parent = scroll
		Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
		b.MouseButton1Click:Connect(callback)
	end

	-- Opciones
	addBtn("Infinite Jump (OFF)", function()
		infJump = not infJump
		playSound()
		game:GetService("StarterGui"):SetCore("SendNotification", {Title = "ALEX@11", Text = "Infinite Jump: " .. (infJump and "ON" or "OFF"), Duration = 3})
	end)

	addBtn("Noclip (OFF)", function()
		noclip = not noclip
		playSound()
		game:GetService("StarterGui"):SetCore("SendNotification", {Title = "ALEX@11", Text = "Noclip: " .. (noclip and "ON" or "OFF"), Duration = 3})
	end)

	addBtn("Inmortal (OFF)", function()
		god = not god
		playSound()
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.MaxHealth = god and math.huge or 100
			player.Character.Humanoid.Health = god and math.huge or 100
		end
		game:GetService("StarterGui"):SetCore("SendNotification", {Title = "ALEX@11", Text = "God Mode: " .. (god and "ON" or "OFF"), Duration = 3})
	end)

	-- Velocidad Ajustable
	addBtn("Velocidad Ajustable", function()
		local speedGui = Instance.new("ScreenGui")
		speedGui.ResetOnSpawn = false
		speedGui.Parent = playerGui

		local sframe = Instance.new("Frame")
		sframe.Size = UDim2.new(0, 350, 0, 200)
		sframe.Position = UDim2.new(0.5, -175, 0.4, 0)
		sframe.BackgroundColor3 = Color3.fromRGB(15,15,15)
		sframe.Parent = speedGui
		Instance.new("UICorner", sframe).CornerRadius = UDim.new(0, 16)

		local slabel = Instance.new("TextLabel")
		slabel.Size = UDim2.new(1,0,0,50)
		slabel.Text = "Velocidad (16-500)"
		slabel.TextColor3 = Color3.fromRGB(255,0,0)
		slabel.TextScaled = true
		slabel.BackgroundTransparency = 1
		slabel.Parent = sframe

		local sinput = Instance.new("TextBox")
		sinput.Size = UDim2.new(0.7,0,0,50)
		sinput.Position = UDim2.new(0.15,0,0.4,0)
		sinput.Text = tostring(currentSpeed)
		sinput.TextScaled = true
		sinput.Parent = sframe
		Instance.new("UICorner", sinput).CornerRadius = UDim.new(0,10)

		local sbtn = Instance.new("TextButton")
		sbtn.Size = UDim2.new(0.6,0,0,45)
		sbtn.Position = UDim2.new(0.2,0,0.7,0)
		sbtn.Text = "Aplicar Velocidad"
		sbtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
		sbtn.TextColor3 = Color3.fromRGB(255,255,255)
		sbtn.TextScaled = true
		sbtn.Parent = sframe
		Instance.new("UICorner", sbtn).CornerRadius = UDim.new(0,10)

		sbtn.MouseButton1Click:Connect(function()
			local newSpeed = tonumber(sinput.Text)
			if newSpeed and newSpeed > 0 then
				currentSpeed = newSpeed
				if player.Character and player.Character:FindFirstChild("Humanoid") then
					player.Character.Humanoid.WalkSpeed = currentSpeed
				end
				game:GetService("StarterGui"):SetCore("SendNotification", {Title = "ALEX@11", Text = "Velocidad puesta a " .. currentSpeed, Duration = 4})
			end
			speedGui:Destroy()
		end)

		playSound()
	end)

	addBtn("Teleport a Jugador", function()
		-- Selector completo (igual que antes)
		local selectGui = Instance.new("ScreenGui")
		selectGui.ResetOnSpawn = false
		selectGui.Parent = playerGui

		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(0, 420, 0, 520)
		frame.Position = UDim2.new(0.5, -210, 0.3, 0)
		frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
		frame.Parent = selectGui
		Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 18)

		local stitle = Instance.new("TextLabel")
		stitle.Size = UDim2.new(1,0,0,60)
		stitle.Text = "Jugadores en el Servidor"
		stitle.TextColor3 = Color3.fromRGB(255, 0, 0)
		stitle.TextScaled = true
		stitle.Font = Enum.Font.GothamBold
		stitle.BackgroundTransparency = 1
		stitle.Parent = frame

		local sscroll = Instance.new("ScrollingFrame")
		sscroll.Size = UDim2.new(1,-20,1,-100)
		sscroll.Position = UDim2.new(0,10,0,70)
		sscroll.BackgroundTransparency = 1
		sscroll.Parent = frame

		local layout = Instance.new("UIListLayout", sscroll)
		layout.Padding = UDim.new(0,8)

		local sclose = Instance.new("TextButton")
		sclose.Size = UDim2.new(0,45,0,45)
		sclose.Position = UDim2.new(1,-50,0,10)
		sclose.Text = "✕"
		sclose.TextColor3 = Color3.fromRGB(255,80,80)
		sclose.TextScaled = true
		sclose.BackgroundTransparency = 1
		sclose.Parent = frame
		sclose.MouseButton1Click:Connect(function() selectGui:Destroy() end)

		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= player then
				local btn = Instance.new("TextButton")
				btn.Size = UDim2.new(1,0,0,55)
				btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
				btn.Text = plr.Name
				btn.TextColor3 = Color3.fromRGB(255,255,255)
				btn.TextScaled = true
				btn.Parent = sscroll
				Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

				btn.MouseButton1Click:Connect(function()
					if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
						player.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(4, 6, 0)
					end
					selectGui:Destroy()
				end)
			end
		end
	end)

	-- Draggable solo menú
	local function makeDraggable(f)
		local dragging = false
		local dragStart, startPos
		f.InputBegan:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = i.Position
				startPos = f.Position
			end
		end)
		UserInputService.InputChanged:Connect(function(i)
			if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
				local delta = i.Position - dragStart
				f.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
		end)
	end

	makeDraggable(menu)

	-- Toggle
	eye.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			menu.Visible = not menu.Visible
		end
	end)

	close.MouseButton1Click:Connect(function() menu.Visible = false end)

	-- Loop de velocidad ajustable
	RunService.Heartbeat:Connect(function()
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			if currentSpeed and currentSpeed > 16 then
				player.Character.Humanoid.WalkSpeed = currentSpeed
			end
		end

		if noclip and player.Character then
			for _, part in pairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") then part.CanCollide = false end
			end
		end
	end)

	UserInputService.JumpRequest:Connect(function()
		if infJump and player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
end
