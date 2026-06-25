--// TIKTOK : ALEX@11 - Velocidad Ajustable + Menú Fijo
-- LocalScript (Listo para Loadstring)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local infJump = false
local noclip = false
local god = false
local currentSpeed = 16

local function playSound()
	local s = Instance.new("Sound")
	s.SoundId = "rbxassetid://131057999"
	s.Volume = 0.5
	s.Parent = game.SoundService
	s:Play()
	game.Debris:AddItem(s, 2)
end

local function loadMenu()
	local sg = Instance.new("ScreenGui")
	sg.ResetOnSpawn = false
	sg.Parent = playerGui

	local eye = Instance.new("Frame")
	eye.Size = UDim2.new(0, 52, 0, 52)
	eye.Position = UDim2.new(0.02, 0, 0.02, 0)
	eye.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	eye.Parent = sg
	Instance.new("UICorner", eye).CornerRadius = UDim.new(1, 0)

	local pupil = Instance.new("Frame")
	pupil.Size = UDim2.new(0, 22, 0, 22)
	pupil.Position = UDim2.new(0.5, -11, 0.5, -11)
	pupil.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	pupil.Parent = eye
	Instance.new("UICorner", pupil).CornerRadius = UDim.new(1, 0)

	local menu = Instance.new("Frame")
	menu.Size = UDim2.new(0, 460, 0, 620)
	menu.Position = UDim2.new(0.5, -230, 0.5, -310)
	menu.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
	menu.Visible = false
	menu.Parent = sg
	Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 18)

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1,0,0,70)
	title.Text = "TIKTOK : ALEX@11"
	title.TextColor3 = Color3.fromRGB(255, 0, 0)
	title.TextScaled = true
	title.Font = Enum.Font.GothamBold
	title.BackgroundTransparency = 1
	title.Parent = menu

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
	scroll.ScrollBarThickness = 6
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
		return b
	end

	local function updateChar(char)
		if not char then return end
		local hum = char:WaitForChild("Humanoid", 5)
		if hum then
			if god then
				hum.MaxHealth = math.huge
				hum.Health = math.huge
			end
			hum.WalkSpeed = currentSpeed
		end
	end

	addBtn("Infinite Jump (OFF)", function(btn)
		infJump = not infJump
		playSound()
		btn.Text = "Infinite Jump (" .. (infJump and "ON" or "OFF") .. ")"
		StarterGui:SetCore("SendNotification", {Title = "ALEX@11", Text = "Infinite Jump: " .. (infJump and "ON" or "OFF"), Duration = 3})
	end)

	addBtn("Noclip (OFF)", function(btn)
		noclip = not noclip
		playSound()
		btn.Text = "Noclip (" .. (noclip and "ON" or "OFF") .. ")"
		StarterGui:SetCore("SendNotification", {Title = "ALEX@11", Text = "Noclip: " .. (noclip and "ON" or "OFF"), Duration = 3})
	end)

	addBtn("God Mode (OFF)", function(btn)
		god = not god
		playSound()
		btn.Text = "God Mode (" .. (god and "ON" or "OFF") .. ")"
		if player.Character then
			local hum = player.Character:FindFirstChild("Humanoid")
			if hum then
				hum.MaxHealth = god and math.huge or 100
				hum.Health = god and math.huge or 100
			end
		end
		StarterGui:SetCore("SendNotification", {Title = "ALEX@11", Text = "God Mode: " .. (god and "ON" or "OFF"), Duration = 3})
	end)

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
			if newSpeed and newSpeed >= 16 then
				currentSpeed = newSpeed
				if player.Character and player.Character:FindFirstChild("Humanoid") then
					player.Character.Humanoid.WalkSpeed = currentSpeed
				end
				StarterGui:SetCore("SendNotification", {Title = "ALEX@11", Text = "Velocidad puesta a " .. currentSpeed, Duration = 4})
			end
			speedGui:Destroy()
		end)
	end)

	local dragging = false
	local dragStart, startPos

	menu.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = i.Position
			startPos = menu.Position
		end
	end)

	UserInputService.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			local delta = i.Position - dragStart
			menu.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	eye.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			menu.Visible = not menu.Visible
		end
	end)

	close.MouseButton1Click:Connect(function() menu.Visible = false end)

	player.CharacterAdded:Connect(updateChar)
	if player.Character then updateChar(player.Character) end

	RunService.Heartbeat:Connect(function()
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.WalkSpeed = currentSpeed
		end

		if noclip and player.Character then
			for _, part in pairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end
	end)

	UserInputService.JumpRequest:Connect(function()
		if infJump and player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
end

loadMenu()
