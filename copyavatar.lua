-- Pastikan game sudah loaded sepenuhnya
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Membuat UI sederhana langsung di PlayerGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DeltaAvatarChanger"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 180)
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -90)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Delta Avatar Changer"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Tombol Save
local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.new(0.8, 0, 0, 35)
saveBtn.Position = UDim2.new(0.1, 0, 0, 50)
saveBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
saveBtn.Text = "Save Avatar ID"
saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
saveBtn.Font = Enum.Font.GothamSemibold
saveBtn.TextSize = 14
saveBtn.Parent = mainFrame
Instance.new("UICorner", saveBtn).CornerRadius = UDim.new(0, 6)

-- Tombol Load
local loadBtn = Instance.new("TextButton")
loadBtn.Size = UDim2.new(0.8, 0, 0, 35)
loadBtn.Position = UDim2.new(0.1, 0, 0, 95)
loadBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 100)
loadBtn.Text = "Load Avatar"
loadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loadBtn.Font = Enum.Font.GothamSemibold
loadBtn.TextSize = 14
loadBtn.Parent = mainFrame
Instance.new("UICorner", loadBtn).CornerRadius = UDim.new(0, 6)

-- Status Text
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 30)
statusLabel.Position = UDim2.new(0, 0, 0, 140)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Ready"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

-- Variabel penyimpanan lokal/file di Delta (menggunakan writefile/readfile jika didukung, atau variabel lokal)
local savedDescriptionData = nil

saveBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        local desc = hum and hum:FindFirstChildOfClass("HumanoidDescription")
        if desc then
            -- Simpan UserId atau HumanoidDescription saat ini
            savedDescriptionData = player.UserId
            statusLabel.Text = "Status: Avatar Disimpan!"
        else
            statusLabel.Text = "Status: Gagal (No Desc)"
        end
    end
end)

loadBtn.MouseButton1Click:Connect(function()
    if savedDescriptionData then
        statusLabel.Text = "Status: Memuat Avatar..."
        local success, model = pcall(function()
            return Players:GetHumanoidDescriptionFromUserId(savedDescriptionData)
        end)
        
        if success and model then
            local char = player.Character or player.CharacterAdded:Wait()
            local hum = char:WaitForChild("Humanoid")
            hum:ApplyDescriptionReset(model)
            statusLabel.Text = "Status: Berhasil Dimuat!"
        else
            statusLabel.Text = "Status: Gagal Load!"
        end
    else
        statusLabel.Text = "Status: Belum ada yang disimpen!"
    end
end)

print("Delta Avatar Changer Loaded successfully!")
