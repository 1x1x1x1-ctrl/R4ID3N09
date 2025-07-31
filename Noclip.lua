-- Noclip móvil R15 con botón flotante
-- Autor: RAIDEN09
-- Compatible con Krnl Mobile / Arceus X / Hydrogen
-- Avatar: R15

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local noclip = false

-- Activar/desactivar colisión en R15
game:GetService("RunService").Stepped:Connect(function()
    if noclip and char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide == true then
                part.CanCollide = false
            end
        end
    end
end)

-- Interfaz flotante
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "R4ID3N09_GUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 60)
frame.Position = UDim2.new(0.5, -100, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.4, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "R4ID3N09"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.BackgroundTransparency = 1

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(1, -10, 0.5, -5)
button.Position = UDim2.new(0, 5, 0.45, 0)
button.Text = "Activar Noclip"
button.TextColor3 = Color3.new(1, 1, 1)
button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button.Font = Enum.Font.SourceSans
button.TextSize = 16

button.MouseButton1Click:Connect(function()
    noclip = not noclip
    button.Text = noclip and "Desactivar Noclip" or "Activar Noclip"
end)
