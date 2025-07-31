local allowedIds = {
    123456789,
    987654321,
    112233445,
    9064162696, -- tu ID agregado
}

local player = game.Players.LocalPlayer
local userId = player.UserId

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local noclipActive = false
local character = player.Character or player.CharacterAdded:Wait()

local function isAllowed(id)
    for _, allowedId in pairs(allowedIds) do
        if id == allowedId then
            return true
        end
    end
    return false
end

if not isAllowed(userId) then
    warn("No tienes permiso para usar noclip.")
    return
end

-- Funciones noclip
local function setCanCollide(value)
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = value
        end
    end
end

local noclipConnection

local function startNoclip()
    noclipActive = true
    setCanCollide(false)
    noclipConnection = RunService.Stepped:Connect(function()
        if not noclipActive then
            noclipConnection:Disconnect()
            setCanCollide(true)
            return
        end
        setCanCollide(false)
    end)
end

local function stopNoclip()
    noclipActive = false
end

local function toggleNoclip()
    if noclipActive then
        stopNoclip()
    else
        startNoclip()
    end
end

-- Crear GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "R4ID3N09_NoclipGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 100)
mainFrame.Position = UDim2.new(0.5, -100, 0.3, -50)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.BorderSizePixel = 0
title.Text = "R4ID3N09"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 25)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Noclip: Desactivado"
statusLabel.TextColor3 = Color3.new(1, 1, 1)
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextSize = 18
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = mainFrame

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(1, -20, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 65)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "Activar Noclip"
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 18
toggleButton.Parent = mainFrame

toggleButton.MouseButton1Click:Connect(function()
    toggleNoclip()
    if noclipActive then
        statusLabel.Text = "Noclip: Activado"
        toggleButton.Text = "Desactivar Noclip"
        toggleButton.BackgroundColor3 = Color3.fromRGB(100, 30, 30)
    else
        statusLabel.Text = "Noclip: Desactivado"
        toggleButton.Text = "Activar Noclip"
        toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)
