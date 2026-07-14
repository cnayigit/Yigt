-- Roblox Desync Script (LocalScript)
-- Bu script, karakterinizin sunucu ve istemci arasındaki senkronizasyonunu bozarak "desync" etkisi yaratır.
-- UYARI: Anti-cheat sistemleri tarafından tespit edilebilir.

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Desync konfigürasyonu
local desyncIntensity = 2 -- Titreşim şiddeti
local isDesyncing = true

-- RenderStepped ile karakteri sürekli olarak sunucudan farklı konumlara çek
RunService.RenderStepped:Connect(function()
    if isDesyncing and rootPart then
        -- CFrame'i rastgele ofset değerleriyle boz
        local offset = Vector3.new(
            math.random(-desyncIntensity, desyncIntensity),
            math.random(-desyncIntensity, desyncIntensity),
            math.random(-desyncIntensity, desyncIntensity)
        )
        
        -- Karakterin RootPart pozisyonuna anlık olarak ofset ekle
        -- Not: Bu işlem sunucuya gönderilen paketlerdeki konumu bozar
        rootPart.CFrame = rootPart.CFrame + offset
        
        -- Küçük bir bekletme ile titreme etkisini optimize et
        task.wait(0.01) 
    end
end)

-- Desync durumunu değiştirmek için basit bir komut
-- Sohbetten "toggle" yazarak açıp kapatabilirsiniz
player.Chatted:Connect(function(message)
    if message == "/toggle" then
        isDesyncing = not isDesyncing
        print("Desync Durumu: " .. tostring(isDesyncing))
    end
end)
