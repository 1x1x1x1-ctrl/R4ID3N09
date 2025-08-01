-- SCRIPT: Optimizador Extremo FPS
-- Autor: R4ID3N09

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

-- Quitar efectos visuales
Lighting.GlobalShadows = false
Lighting.FogEnd = math.huge
Lighting.Brightness = 0
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0
Lighting.OutdoorAmbient = Color3.new(0, 0, 0)

-- Suelo plano sin decoraciones
if Terrain then
    Terrain.WaterWaveSize = 0
    Terrain.WaterWaveSpeed = 0
    Terrain.WaterReflectance = 0
    Terrain.WaterTransparency = 1
end

-- Quitar todo lo innecesario
for _, v in pairs(game:GetDescendants()) do
    if v:IsA("BasePart") then
        v.Material = Enum.Material.SmoothPlastic
        v.Reflectance = 0
        v.CastShadow = false
    elseif v:IsA("Decal") or v:IsA("Texture") then
        v:Destroy()
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Explosion") then
        v:Destroy()
    elseif v:IsA("ForceField") then
        v:Destroy()
    elseif v:IsA("Beam") then
        v:Destroy()
    elseif v:IsA("Sound") then
        v.Volume = 0
    elseif v:IsA("SurfaceGui") or v:IsA("BillboardGui") or v:IsA("TextLabel") or v:IsA("ImageLabel") then
        v:Destroy()
    end
end

-- Opcional: Eliminar efectos posteriores al iniciar (por si los crean luego)
game.DescendantAdded:Connect(function(v)
    if v:IsA("Decal") or v:IsA("Texture") or v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Explosion") or v:IsA("ForceField") or v:IsA("Beam") then
        v:Destroy()
    elseif v:IsA("Sound") then
        v.Volume = 0
    end
end)

-- Cap de FPS si tu ejecutor lo permite
pcall(function() setfpscap(60) end)

print("R4ID3N09 Optimizador Extremo cargado correctamente.")
