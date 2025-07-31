local player = game.Players.LocalPlayer
repeat wait() until player.Character
local character = player.Character

-- Obtener brazos
local rightArm = character:FindFirstChild("RightUpperArm") or character:WaitForChild("RightUpperArm")
local leftArm = character:FindFirstChild("LeftUpperArm") or character:WaitForChild("LeftUpperArm")

-- Obtener motores
local rightMotor = rightArm:FindFirstChildWhichIsA("Motor6D")
local leftMotor = leftArm:FindFirstChildWhichIsA("Motor6D")

if not rightMotor or not leftMotor then
	warn("No se encontraron los motores de los brazos.")
	return
end

-- Movimiento de subida y bajada
local arriba = CFrame.Angles(math.rad(-45), 0, 0)
local abajo = CFrame.Angles(math.rad(10), 0, 0)

-- Animación
task.spawn(function()
	while true do
		rightMotor.Transform = arriba
		leftMotor.Transform = arriba
		wait(0.25)
		rightMotor.Transform = abajo
		leftMotor.Transform = abajo
		wait(0.25)
	end
end)
