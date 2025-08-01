-- ULTRA Optimización Tha Bronx 3 + FLOAT - by R4ID3N09

local ws = game:GetService("Workspace")
local lp = game:GetService("Players").LocalPlayer
local lighting = game:GetService("Lighting")
local run = game:GetService("RunService")

-- 🔇 Desactivar sombras, reflejos y luz innecesaria
pcall(function()
    lighting.GlobalShadows = false
    lighting.FogEnd = 1e10
    lighting.Brightness = 0
    lighting.ClockTime = 14
end)

-- 🌊 Eliminar efectos del terreno
local terrain = ws:FindFirstChildOfClass("Terrain")
if terrain then
    terrain.WaterWaveSize = 0
    terrain.WaterWaveSpeed = 0
    terrain.WaterReflectance = 0
    terrain.WaterTransparency = 1
end

-- 🧱 Eliminar edificios y partes grandes del mapa
for _, obj in ipairs(ws:GetDescendants()) do
    if obj:IsA("BasePart") and obj.Size.Magnitude > 15 then
        obj:Destroy()
    elseif obj:IsA("MeshPart") and obj.Size.Magnitude > 15 then
        obj:Destroy()
    elseif obj:IsA("Decal") then
        obj.Transparency = 1
    end
end

-- 💨 Eliminar efectos visuales innecesarios
for _, v in pairs(lighting:GetChildren()) do
    if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
        v:Destroy()
    end
end

-- 👕 Eliminar ropa y accesorios de otros jugadores
for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
    if plr ~= lp and plr.Character then
        for _, item in pairs(plr.Character:GetChildren()) do
            if item:IsA("Accessory") or item:IsA("Clothing") then
                item:Destroy()
            end
        end
    end
end

-- ☁️ Activar FLOAT con plataforma invisible

local char = lp.Character or lp.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Crear plataforma invisible
local platform = Instance.new("Part")
platform.Size = Vector3.new(6, 1, 6)
platform.Transparency = 1
platform.Anchored = true
platform.CanCollide = true
platform.Name = "FloatPlatform"
platform.Parent = ws

local offsetY = -3 -- distancia debajo del HRP para la plataforma

run.Heartbeat:Connect(function()
    if hrp and platform then
        -- Mover la plataforma para que siga al personaje justo debajo
        platform.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y + offsetY, hrp.Position.Z)
    end
end)

-- ♻️ Limpiar memoria
if collectgarbage then
    for i = 1, 3 do
        collectgarbage("collect")
    end
end

print("[✅ R4ID3N09] Ultra optimización + Float activado con plataforma invisible.")
