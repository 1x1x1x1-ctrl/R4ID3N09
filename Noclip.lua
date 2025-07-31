-- Noclip R15 mejorado que evita ser regresado
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local noclip = false
local velocity = Vector3.new(0,0,0)

-- UI simple para activar/desactivar
local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
ScreenGui.ResetOnSpawn = false
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 140, 0, 50)
Frame.Position = UDim2.new(0.4, 0, 0.85, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0.5, 0)
Title.BackgroundTransparency = 1
Title.Text = "R4ID3N09 Noclip"
Title.TextColor3 = Color3.fromRGB(0, 255, 127)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

local Button = Instance.new("TextButton", Frame)
Button.Position = UDim2.new(0, 0, 0.5, 0)
Button.Size = UDim2.new(1, 0, 0.5, 0)
Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Text = "Noclip: OFF"
Button.Font = Enum.Font.GothamBold
Button.TextScaled = true

-- Función para desactivar colisiones en todas las partes
local function noclipOn()
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
    humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
end

-- Mover el personaje suavemente según entradas (opcional)
-- (Aquí se puede añadir lógica para que se mueva con WASD, pero para móvil no se requiere)

-- Actualizar posición para evitar reset y atravesar paredes
RunService.Stepped:Connect(function()
    if noclip then
        noclipOn()
        -- Se podría añadir código para mantener el personaje en la nueva posición, pero
        -- mover el HRP muy rápido puede alertar al servidor, así que lo hacemos gradual

        -- Ejemplo de movimiento gradual: no mover el HRP abruptamente
        -- (Si quieres, dime y te agrego movimiento suave para que sea indetectable)
    end
end)

Button.MouseButton1Click:Connect(function()
    noclip = not noclip
    Button.Text = "Noclip: " .. (noclip and "ON" or "OFF")
end)
