local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local optimizationOn = false
local originalSettings = {}

local function ultraOptimize()
    -- Guardar settings originales si no guardados
    if not originalSettings.Brightness then
        originalSettings.Brightness = Lighting.Brightness
        originalSettings.GlobalShadows = Lighting.GlobalShadows
        originalSettings.OutdoorAmbient = Lighting.OutdoorAmbient
        originalSettings.FogEnd = Lighting.FogEnd
    end

    optimizationOn = true

    -- Iluminación ultra baja
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.Brightness = 0
        Lighting.OutdoorAmbient = Color3.new(0,0,0)
        Lighting.FogEnd = math.huge
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") then v.Enabled = false end
        end
    end)

    -- Limpiar Workspace (menos personaje)
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj ~= player.Character then
            pcall(function() obj:Destroy() end)
        end
    end

    -- Borrar sonidos y UI
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Sound") then pcall(function() v:Destroy() end) end
    end
    pcall(function()
        local gui = player:FindFirstChildOfClass("PlayerGui")
        if gui then gui:ClearAllChildren() end
    end)

    -- Borrar accesorios, ropa, hats
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            for _, item in pairs(plr.Character:GetDescendants()) do
                if item:IsA("Accessory") or item:IsA("Clothing") or item:IsA("Shirt") or item:IsA("Pants") then
                    pcall(function() item:Destroy() end)
                end
            end
        end
    end

    -- Borrar efectos visuales
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Trail") or obj:IsA("Beam") then
            pcall(function() obj:Destroy() end)
        end
    end

    -- Material plástico, sin colisión, anclado para personaje
    if player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                pcall(function()
                    part.Material = Enum.Material.Plastic
                    part.Reflectance = 0
                    part.Transparency = 0
                    part.CanCollide = false
                    part.Anchored = true
                end)
            end
        end
    end

    -- Borrar scripts para evitar lag
    for _, scr in pairs(game:GetDescendants()) do
        if scr:IsA("Script") or scr:IsA("LocalScript") then
            pcall(function() scr:Destroy() end)
        end
    end

    -- Borrar luces en Workspace
    for _, light in pairs(Workspace:GetDescendants()) do
        if light:IsA("PointLight") or light:IsA("SurfaceLight") or light:IsA("SpotLight") then
            pcall(function() light:Destroy() end)
        end
    end

    -- Limpiar terrain
    pcall(function()
        local terrain = Workspace:FindFirstChildOfClass("Terrain")
        if terrain then terrain:Clear() end
    end)

    -- Desconectar eventos
    if getconnections then
        for _, con in pairs(getconnections()) do
            pcall(function() con:Disable() end)
        end
    end

    -- FPS reducido para ahorrar CPU/GPU
    pcall(function()
        settings().Physics.PhysicsSteppingMethod = Enum.PhysicsSteppingMethod.FixedTimeStep
        RunService:SetRobloxFPSCap(30)
        RunService:Set3dRenderingEnabled(true)
    end)

    print("✅ Ultra Optimización ACTIVADA")
end

local function restore()
    if not optimizationOn then return end
    optimizationOn = false

    -- Restaurar settings de iluminación
    pcall(function()
        Lighting.Brightness = originalSettings.Brightness or 1
        Lighting.GlobalShadows = originalSettings.GlobalShadows or true
        Lighting.OutdoorAmbient = originalSettings.OutdoorAmbient or Color3.new(0.5,0.5,0.5)
        Lighting.FogEnd = originalSettings.FogEnd or 100000
    end)

    -- Restaurar FPS y renderizado
    pcall(function()
        RunService:SetRobloxFPSCap(60)
        RunService:Set3dRenderingEnabled(true)
        settings().Physics.PhysicsSteppingMethod = Enum.PhysicsSteppingMethod.Integrator
    end)

    print("✅ Optimización RESTAURADA")
end

-- Para activar rápido, llama ultraOptimize()
-- Para restaurar, llama restore()

-- Ejemplo uso rápido (descomenta para activar automáticamente al ejecutar)
-- ultraOptimize()
