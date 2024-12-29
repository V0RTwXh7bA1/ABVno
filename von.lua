local RS = game:GetService("RunService")
local Plrs = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Plr = Plrs.LocalPlayer
local hb = RS.Heartbeat

local toggle = false
local character, humanoid

local TeleportCheck = false
Plr.OnTeleport:Connect(function(State)
	if (not TeleportCheck) and queueteleport then
		TeleportCheck = true
		queueteleport("loadstring(game:HttpGet('"https://raw.githubusercontent.com/V0RTwXh7bA1/ABVno/refs/heads/main/von.lua'))()")
	end
end)

UIS.InputBegan:Connect(function(Input, GPE)
    if GPE then return end
    if Input.KeyCode == Enum.KeyCode.G then
        toggle = not toggle  -- Toggle the state

        if toggle then
            -- Enable movement
            character = Plr.Character
            humanoid = character and character:FindFirstChildWhichIsA("Humanoid")

            if humanoid then
                -- Start moving the character when the toggle is on
                while toggle and character and humanoid.Parent do
                    local delta = hb:Wait()
                    if humanoid.MoveDirection.Magnitude > 0 then
                        character:TranslateBy(humanoid.MoveDirection * 5 * delta * 10)
                    end
                end
            end
        end
    end
end)

UIS.InputEnded:Connect(function(Input, GPE)
    if GPE then return end
    if Input.KeyCode == Enum.KeyCode.G then
        -- Do nothing, the toggle is handled in InputBegan
    end
end)

-- Ensure that the humanoid and character are updated if they change during runtime
Plrs.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        character = char
        humanoid = char:FindFirstChildWhichIsA("Humanoid")
    end)
end)
