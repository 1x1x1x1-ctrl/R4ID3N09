-- R4ID3N09 Noclip para Steal a Brainrot (R15) con UI y movimiento suave
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local noclip = false

-- Crear UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "R4ID3N09NoclipGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 160, 0, 60)
Frame.Position = UDim2.new(0.4, 0, 0.85, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0.5, 0)
Title.BackgroundTransparency = 1
Title.Text = "R4ID3N09 Noclip"
Title.TextColor3 = Color3.fromRGB(0, 255, 127)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.Parent = Frame

local Button = Instance.new("TextButton")
Button.Position = UDim2.new(0, 0, 0.5, 0)
Button.Size = UDim2.new(1, 0, 0.5, 0)
Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Text = "Noclip: OFF"
Button.Font = Enum.Font.GothamBold
Button.TextScaled = true
Button.Parent = Frame

-- Función para activar noclip
local function noclipOn()
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.CanCollide = true
        end
    end
    hrp.CanCollide = false
    if humanoid:GetState() ~= Enum.HumanoidStateType.Physics then
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    end
end

-- Función para desactivar noclip
local function noclipOff()
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end

local speed = 50
local moveVector = Vector3.new()

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if noclip then
        if input.KeyCode == Enum.KeyCode.W then
            moveVector = moveVector + workspace.CurrentCamera.CFrame.LookVector
        elseif input.KeyCode == Enum.KeyCode.S then
            moveVector = moveVector - workspace.CurrentCamera.CFrame.LookVector
        elseif input.KeyCode == Enum.KeyCode.A then
            moveVector = moveVector - workspace.CurrentCamera.CFrame.RightVector
        elseif input.KeyCode == Enum.KeyCode.D then
            moveVector = moveVector + workspace.CurrentCamera.CFrame.RightVector
        elseif input.KeyCode == Enum.KeyCode
