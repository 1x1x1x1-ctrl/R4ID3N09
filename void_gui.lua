-- Creador: R4ID3N09 para Krnl
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local Button = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Name = "VoidSenderGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 250, 0, 120)

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

TextBox.Parent = Frame
TextBox.PlaceholderText = "Nombre del jugador"
TextBox.Position = UDim2.new(0.1, 0, 0.15, 0)
TextBox.Size = UDim2.new(0.8, 0, 0.3, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.ClearTextOnFocus = false

Button.Parent = Frame
Button.Text = "Enviar al Void"
Button.Position = UDim2.new(0.2, 0, 0.6, 0)
Button.Size = UDim2.new(0.6, 0, 0.25, 0)
Button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)

Button.MouseButton1Click:Connect(function()
    local playerName = TextBox.Text
    local targetPlayer = game.Players:FindFirstChild(playerName)

    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        targetPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, -1000, 0)
        Button.Text = "¡Enviado!"
    else
        Button.Text = "Jugador no encontrado"
    end

    wait(2)
    Button.Text = "Enviar al Void"
end)
