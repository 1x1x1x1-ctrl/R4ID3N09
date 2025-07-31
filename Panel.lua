-- Panel avanzado con toggle real para activar/desactivar scripts
-- Autor: RAIDEN09
-- Compatible con Krnl Mobile - R15

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Eliminar panel existente para evitar duplicados
local existingGui = PlayerGui:FindFirstChild("RAIDEN09_ScriptsPanel")
if existingGui then existingGui:Destroy() end

-- Crear ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RAIDEN09_ScriptsPanel"
screenGui.Parent = PlayerGui

-- Crear Frame principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 350)
frame.Position = UDim2.new(1, 0, 0.2, 0) -- inicia fuera de pantalla a la derecha
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Parent = screenGui
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true
frame.ZIndex = 5

-- Animaciones para mostrar y ocultar
local function slideIn()
    for i = 0, 1, 0.1 do
        frame.Position = UDim2.new(1 - i * 0.25, 0, 0.2, 0)
        wait(0.03)
    end
    frame.Position = UDim2.new(0.75, 0, 0.2, 0)
end
local function slideOut()
    for i = 0, 1, 0.1 do
        frame.Position = UDim2.new(0.75 + i * 0.25, 0, 0.2, 0)
        wait(0.03)
    end
    screenGui:Destroy()
end
slideIn()

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Text = "Panel de Scripts"
title.Parent = frame

-- Botón cerrar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 24
closeBtn.Text = "X"
closeBtn.AutoButtonColor = true
closeBtn.Parent = frame

closeBtn.MouseButton1Click:Connect(function()
    slideOut()
end)

-- Contenedor para botones
local buttonContainer = Instance.new("ScrollingFrame")
buttonContainer.Size = UDim2.new(1, -20, 1, -55)
buttonContainer.Position = UDim2.new(0, 10, 0, 45)
buttonContainer.BackgroundTransparency = 1
buttonContainer.ScrollBarThickness = 6
buttonContainer.Parent = frame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0,8)
UIListLayout.Parent = buttonContainer

-- Tabla para guardar funciones de desactivación
local desactivarFunciones = {}

-- Función para crear botones toggle con activación/desactivación real
local function crearBotonToggle(texto, activarCodigo)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Text = texto .. " [OFF]"
    btn.AutoButtonColor = true
    btn.Parent = buttonContainer
    btn.ZIndex = 10

    local activado = false

    btn.MouseButton1Click:Connect(function()
        if activado then
            -- Desactivar script
            if desactivarFunciones[texto] then
                local success, err = pcall(desactivarFunciones[texto])
                if not success then
                    warn("Error al desactivar script '"..texto.."': "..err)
                else
                    print(texto.." desactivado correctamente.")
                end
            end
            activado = false
            btn.Text = texto .. " [OFF]"
        else
            -- Activar script y guardar función para desactivar
            local success, desactivarFuncOrErr = pcall(function()
                local func = loadstring(activarCodigo)()
                return func
            end)
            if success and type(desactivarFuncOrErr) == "function" then
                desactivarFunciones[texto] = desactivarFuncOrErr
                activado = true
                btn.Text = texto .. " [ON]"
                print(texto.." activado correctamente.")
            else
                warn("Error al activar script '"..texto.."': "..tostring(desactivarFuncOrErr))
            end
        end
    end)
end

-- Scripts con retorno de función para desactivar
local scripts = {}

scripts["Invulnerabilidad (Anti-Daño)"] = [[
    return function()
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")

        local conn
        local function bloquearDaño()
            humanoid.Health = humanoid.MaxHealth
            conn = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                if humanoid.Health < humanoid.MaxHealth then
                    humanoid.Health = humanoid.MaxHealth
                end
            end)
        end

        bloquearDaño()

        local charAddedConn = player.CharacterAdded:Connect(function(newChar)
            char = newChar
            humanoid = char:WaitForChild("Humanoid")
            bloquearDaño()
        end)

        -- Función para desconectar todo y desactivar
        return function()
            if conn then conn:Disconnect() end
            if charAddedConn then charAddedConn:Disconnect() end
            print("Invulnerabilidad desactivada.")
        end
    end
]]

scripts["Noclip (R15)"] = [[
    return function()
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local noclip = false

        local inputConn
        local steppedConn

        inputConn = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.N then
                noclip = not noclip
                if noclip then
                    print("Noclip activado")
                else
                    print("Noclip desactivado")
                end
            end
        end)

        steppedConn = game:GetService("RunService").Stepped:Connect(function()
            if noclip and char then
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            elseif char then
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end)

        -- Función para desactivar conexiones y restaurar colisiones
        return function()
            if inputConn then inputConn:Disconnect() end
            if steppedConn then steppedConn:Disconnect() end
            if char then
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
            print("Noclip desactivado.")
        end
    end
]]

scripts["Velocidad Extra"] = [[
    return function()
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local velocidadNormal = humanoid.WalkSpeed
        local velocidadExtra = 50
        humanoid.WalkSpeed = velocidadExtra

        local charAddedConn
        charAddedConn = player.CharacterAdded:Connect(function(newChar)
            char = newChar
            humanoid = char:WaitForChild("Humanoid")
            humanoid.WalkSpeed = velocidadExtra
        end)

        -- Función para restaurar velocidad normal y desconectar
        return function()
            humanoid.WalkSpeed = velocidadNormal
            if charAddedConn then charAddedConn:Disconnect() end
            print("Velocidad extra desactivada.")
        end
    end
]]

-- Crear botones toggle para todos los scripts
for nombre, codigo in pairs(scripts) do
    crearBotonToggle(nombre, codigo)
end
