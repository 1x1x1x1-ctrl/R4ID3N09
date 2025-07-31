--[[
    R4ID3N09 Advanced Noclip R15
    GUI estilo CoolKidd, movible y simple
    Compatible con Krnl Mobile y otros exploits
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local noclipEnabled = false
local connections = {}

-- Función para activar/desactivar noclip sin teletransportar ni romper físicas
local function setNoclip(state)
    noclipEnabled = state
    if state then
        -- Desactivar colisiones suavemente, sin cambiar la posición
        connections["Step"] = RunService.Stepped:Connect(function()
            if hrp then
                -- Para evitar detección, en vez de CanCollide false directo, usar un hack:
                for _, part in pairs(character:GetChildren()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        -- Reactivar colisiones
        if connections["Step"] then
            connections["Step"]:Disconnect()
            connections["Step"] = nil
        end
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- Crear GUI movible estilo CoolKidd
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "R4ID3N09_NoclipGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Name = "MainFrame"
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 180, 0, 80)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Parent = ScreenGui
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Font = Enum.Font.GothamBold
Title.Text = "R4ID3N09"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Parent = Frame

local Button = Instance.new("TextButton")
Button.Name = "ToggleButton"
Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Button.Position = UDim2.new(0.1, 0, 0.5, 0)
Button.Size = UDim2.new(0.8, 0, 0, 35)
Button.Font = Enum.Font.GothamSemibold
Button.Text = "Activar Noclip"
Button.TextColor3 = Color3.fromRGB(200, 200, 200)
Button.TextSize = 18
Button.Parent = Frame

Button.MouseButton1Click:Connect(function()
    setNoclip(not noclipEnabled)
    Button.Text = noclipEnabled and "Desactivar Noclip" or "Activar Noclip"
end)

-- Evitar detección extra: suavizar movimientos mientras noclip está activo
RunService.Heartbeat:Connect(function()
    if noclipEnabled and hrp then
        -- Forzar velocidad horizontal cero para evitar detección brusca
        local vel = hrp.Velocity
        hrp.Velocity = Vector3.new(vel.X * 0.1, vel.Y, vel.Z * 0.1)
    end
end)

-- Reconectar si el personaje muere/reaparece
player.CharacterAdded:Connect(function(char)
    character = char
    hrp = character:WaitForChild("HumanoidRootPart")
    humanoid = character:WaitForChild("Humanoid")
    if noclipEnabled then
        setNoclip(true)
    end
end)
