-- CROCO HUB - LOADER AVEC VÉRIFICATION GITHUB AUTOMATIQUE 🐊

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- ========================================
-- CONFIGURATION
-- ========================================

-- URL du fichier keys.json sur GitHub (raw)
local KEYS_URL = "https://raw.githubusercontent.com/TexxSave/crocohub/refs/heads/main/keys.json"

-- Discord
local DISCORD_INVITE = "https://discord.gg/bES4cJPgqc"

-- ========================================
-- HWID
-- ========================================

local function getHWID()
    return game:GetService("RbxAnalyticsService"):GetClientId()
end

local HWID = getHWID()

-- ========================================
-- STOCKAGE LOCAL
-- ========================================

local function saveKey(key, expiration)
    writefile("croco_key.dat", HttpService:JSONEncode({
        key = key,
        hwid = HWID,
        expiration = expiration,
        username = player.Name
    }))
end

local function loadKey()
    if isfile("croco_key.dat") then
        local success, data = pcall(function()
            return HttpService:JSONDecode(readfile("croco_key.dat"))
        end)
        
        if success and data then
            -- Vérifier expiration (timestamp en millisecondes)
            if data.expiration > Date.now() and data.hwid == HWID then
                return data.key
            else
                delfile("croco_key.dat")
            end
        end
    end
    return nil
end

-- ========================================
-- VÉRIFICATION AUTOMATIQUE
-- ========================================

local function verifyKey(key)
    local success, result = pcall(function()
        -- Télécharger le fichier depuis GitHub
        local response = game:HttpGet(KEYS_URL)
        local keysData = HttpService:JSONDecode(response)
        
        -- Chercher la clé
        if keysData.keys and keysData.keys[key] then
            local keyData = keysData.keys[key]
            
            -- Vérifier expiration
            if os.time() * 1000 > keyData.expiration then
                return {
                    valid = false,
                    message = "Clé expirée"
                }
            end
            
            -- Si pas de HWID, OK (première utilisation)
            if not keyData.hwid or keyData.hwid == "" then
                return {
                    valid = true,
                    expiration = math.floor(keyData.expiration / 1000),
                    message = "Clé activée"
                }
            end
            
            -- Vérifier HWID
            if keyData.hwid == HWID then
                return {
                    valid = true,
                    expiration = math.floor(keyData.expiration / 1000),
                    message = "Clé valide"
                }
            else
                return {
                    valid = false,
                    message = "Clé déjà utilisée sur un autre appareil"
                }
            end
        end
        
        return {
            valid = false,
            message = "Clé invalide"
        }
    end)
    
    if success then
        return result
    end
    
    return {
        valid = false,
        message = "Erreur de connexion"
    }
end

-- ========================================
-- GUI
-- ========================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CrocoKeySystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999999999

pcall(function()
    if gethui then
        ScreenGui.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = CoreGui
    else
        ScreenGui.Parent = CoreGui
    end
end)

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 15)
Corner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(40, 200, 80)
Stroke.Thickness = 3
Stroke.Parent = MainFrame

-- Logo
local Logo = Instance.new("Frame")
Logo.Size = UDim2.new(0, 100, 0, 100)
Logo.Position = UDim2.new(0.5, -50, 0, 30)
Logo.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
Logo.BorderSizePixel = 0
Logo.Parent = MainFrame

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 20)
LogoCorner.Parent = Logo

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "🐊"
LogoText.Font = Enum.Font.GothamBold
LogoText.TextSize = 60
LogoText.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoText.Parent = Logo

-- Titre
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 35)
Title.Position = UDim2.new(0, 20, 0, 145)
Title.BackgroundTransparency = 1
Title.Text = "CROCO HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 28
Title.TextColor3 = Color3.fromRGB(40, 200, 80)
Title.Parent = MainFrame

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -40, 0, 25)
Subtitle.Position = UDim2.new(0, 20, 0, 180)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Automatic Key System"
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 14
Subtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
Subtitle.Parent = MainFrame

-- Instructions
local Instructions = Instance.new("TextLabel")
Instructions.Size = UDim2.new(1, -60, 0, 80)
Instructions.Position = UDim2.new(0, 30, 0, 220)
Instructions.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Instructions.BorderSizePixel = 0
Instructions.Text = "📌 How to get a key:\n\n1. Join our Discord server\n2. Type !getkey in any channel\n3. Copy your key and paste it here"
Instructions.Font = Enum.Font.Gotham
Instructions.TextSize = 13
Instructions.TextColor3 = Color3.fromRGB(200, 200, 200)
Instructions.TextWrapped = true
Instructions.Parent = MainFrame

local InstCorner = Instance.new("UICorner")
InstCorner.CornerRadius = UDim.new(0, 10)
InstCorner.Parent = Instructions

-- HWID
local HWIDLabel = Instance.new("TextLabel")
HWIDLabel.Size = UDim2.new(1, -60, 0, 25)
HWIDLabel.Position = UDim2.new(0, 30, 0, 315)
HWIDLabel.BackgroundTransparency = 1
HWIDLabel.Text = "🔑 Your HWID: " .. HWID:sub(1, 28) .. "..."
HWIDLabel.Font = Enum.Font.GothamMono
HWIDLabel.TextSize = 10
HWIDLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
HWIDLabel.TextXAlignment = Enum.TextXAlignment.Left
HWIDLabel.Parent = MainFrame

-- Input
local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -60, 0, 50)
KeyInput.Position = UDim2.new(0, 30, 0, 350)
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
KeyInput.BorderSizePixel = 0
KeyInput.Text = ""
KeyInput.PlaceholderText = "CROCO-XXXX-XXXX-XXXX"
KeyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
KeyInput.Font = Enum.Font.GothamBold
KeyInput.TextSize = 16
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 10)
InputCorner.Parent = KeyInput

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(45, 45, 50)
InputStroke.Thickness = 2
InputStroke.Parent = KeyInput

-- Bouton Discord
local DiscordBtn = Instance.new("TextButton")
DiscordBtn.Size = UDim2.new(1, -60, 0, 50)
DiscordBtn.Position = UDim2.new(0, 30, 0, 415)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordBtn.Text = "💬 Join Discord"
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.TextSize = 18
DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordBtn.BorderSizePixel = 0
DiscordBtn.Parent = MainFrame

local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 10)
DiscordCorner.Parent = DiscordBtn

-- Bouton Verify
local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(1, -60, 0, 50)
VerifyBtn.Position = UDim2.new(0, 30, 0, 480)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
VerifyBtn.Text = "✅ Verify Key"
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.TextSize = 18
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.BorderSizePixel = 0
VerifyBtn.Parent = MainFrame

local VerifyCorner = Instance.new("UICorner")
VerifyCorner.CornerRadius = UDim.new(0, 10)
VerifyCorner.Parent = VerifyBtn

-- Status
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -60, 0, 30)
Status.Position = UDim2.new(0, 30, 0, 545)
Status.BackgroundTransparency = 1
Status.Text = ""
Status.Font = Enum.Font.GothamBold
Status.TextSize = 13
Status.TextColor3 = Color3.fromRGB(255, 255, 255)
Status.Parent = MainFrame

-- ========================================
-- FONCTIONS
-- ========================================

local function showStatus(text, color)
    Status.Text = text
    Status.TextColor3 = color
end

local function openFrame()
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 450, 0, 595)
    })
    tween:Play()
end

local function closeFrame()
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    })
    tween:Play()
    tween.Completed:Wait()
    ScreenGui:Destroy()
end

local function loadHub()
    closeFrame()
    -- Charger ton hub complet
    loadstring(game:HttpGet("https://raw.githubusercontent.com/TexxSave/crocohub/refs/heads/main/hub.lua"))()
end

-- ========================================
-- LOGIQUE
-- ========================================

-- Vérifier clé en cache
local cachedKey = loadKey()
if cachedKey then
    showStatus("⏳ Verifying cached key...", Color3.fromRGB(255, 180, 50))
    openFrame()
    task.wait(1)
    
    local result = verifyKey(cachedKey)
    if result.valid then
        showStatus("✅ Key valid! Loading hub...", Color3.fromRGB(40, 200, 80))
        task.wait(1)
        loadHub()
        return
    else
        showStatus("❌ " .. result.message, Color3.fromRGB(255, 80, 80))
        delfile("croco_key.dat")
        task.wait(2)
    end
end

openFrame()
showStatus("💡 Get your key on Discord!", Color3.fromRGB(150, 150, 150))

-- Bouton Discord
DiscordBtn.MouseButton1Click:Connect(function()
    setclipboard(DISCORD_INVITE)
    showStatus("📋 Discord link copied! Press CTRL+V to paste", Color3.fromRGB(88, 101, 242))
end)

-- Bouton Verify
VerifyBtn.MouseButton1Click:Connect(function()
    local key = KeyInput.Text:upper():gsub("%s+", "")
    
    if key == "" then
        showStatus("⚠️ Please enter a key!", Color3.fromRGB(255, 180, 50))
        return
    end
    
    if not key:match("^CROCO%-") then
        showStatus("❌ Invalid key format!", Color3.fromRGB(255, 80, 80))
        return
    end
    
    VerifyBtn.Text = "⏳ Verifying..."
    VerifyBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 50)
    showStatus("⏳ Checking key on GitHub...", Color3.fromRGB(255, 180, 50))
    
    task.spawn(function()
        task.wait(0.5) -- Petit délai pour l'animation
        
        local result = verifyKey(key)
        
        if result.valid then
            showStatus("✅ Key accepted! Loading hub...", Color3.fromRGB(40, 200, 80))
            VerifyBtn.Text = "✅ Success!"
            VerifyBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 100)
            
            saveKey(key, result.expiration)
            
            task.wait(1.5)
            loadHub()
        else
            showStatus("❌ " .. result.message, Color3.fromRGB(255, 80, 80))
            VerifyBtn.Text = "❌ Failed"
            VerifyBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            
            task.wait(2)
            VerifyBtn.Text = "✅ Verify Key"
            VerifyBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
            KeyInput.Text = ""
        end
    end)
end)

-- Vérifier avec Entrée
KeyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed and KeyInput.Text ~= "" then
        VerifyBtn.MouseButton1Click:Fire()
    end
end)

print("🐊 Croco Hub - Automatic Key System loaded!")
print("Discord: " .. DISCORD_INVITE)
