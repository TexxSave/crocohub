-- CROCO HUB V4 - LOADER AVEC CLÉ UNIVERSELLE 🐊

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- ========================================
-- CLÉ UNIVERSELLE
-- ========================================

local UNIVERSAL_KEY = "CROCO2026" -- TOUT LE MONDE UTILISE CETTE CLÉ !

-- ========================================
-- VÉRIFICATION
-- ========================================

local function verifyKey(enteredKey)
    return enteredKey:upper() == UNIVERSAL_KEY
end

-- ========================================
-- GUI
-- ========================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CrocoKeyLoader"
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

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 0, 0, 0)
KeyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
KeyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
KeyFrame.BorderSizePixel = 0
KeyFrame.ClipsDescendants = true
KeyFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 15)
Corner.Parent = KeyFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(40, 200, 80)
Stroke.Thickness = 3
Stroke.Parent = KeyFrame

-- Logo
local Logo = Instance.new("Frame")
Logo.Size = UDim2.new(0, 100, 0, 100)
Logo.Position = UDim2.new(0.5, -50, 0, 30)
Logo.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
Logo.BorderSizePixel = 0
Logo.Parent = KeyFrame

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

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 35)
Title.Position = UDim2.new(0, 20, 0, 145)
Title.BackgroundTransparency = 1
Title.Text = "CROCO HUB V4"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 26
Title.TextColor3 = Color3.fromRGB(40, 200, 80)
Title.Parent = KeyFrame

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -40, 0, 25)
Subtitle.Position = UDim2.new(0, 20, 0, 180)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Enter the universal key"
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 14
Subtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
Subtitle.Parent = KeyFrame

-- Instructions
local Instructions = Instance.new("TextLabel")
Instructions.Size = UDim2.new(1, -60, 0, 60)
Instructions.Position = UDim2.new(0, 30, 0, 220)
Instructions.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Instructions.BorderSizePixel = 0
Instructions.Text = "📌 Universal Key:\nCROCO2026\n\nEveryone uses the same key!"
Instructions.Font = Enum.Font.Gotham
Instructions.TextSize = 13
Instructions.TextColor3 = Color3.fromRGB(200, 200, 200)
Instructions.TextWrapped = true
Instructions.Parent = KeyFrame

local InstCorner = Instance.new("UICorner")
InstCorner.CornerRadius = UDim.new(0, 10)
InstCorner.Parent = Instructions

-- Input
local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -60, 0, 50)
KeyInput.Position = UDim2.new(0, 30, 0, 295)
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
KeyInput.BorderSizePixel = 0
KeyInput.Text = ""
KeyInput.PlaceholderText = "Enter key here..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
KeyInput.Font = Enum.Font.GothamBold
KeyInput.TextSize = 16
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = KeyFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 10)
InputCorner.Parent = KeyInput

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(45, 45, 50)
InputStroke.Thickness = 2
InputStroke.Parent = KeyInput

-- Bouton Copy Key
local CopyBtn = Instance.new("TextButton")
CopyBtn.Size = UDim2.new(1, -60, 0, 50)
CopyBtn.Position = UDim2.new(0, 30, 0, 360)
CopyBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
CopyBtn.Text = "📋 Copy Key"
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.TextSize = 18
CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyBtn.BorderSizePixel = 0
CopyBtn.Parent = KeyFrame

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 10)
CopyCorner.Parent = CopyBtn

-- Bouton Verify
local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(1, -60, 0, 50)
VerifyBtn.Position = UDim2.new(0, 30, 0, 425)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
VerifyBtn.Text = "✅ Verify Key"
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.TextSize = 18
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.BorderSizePixel = 0
VerifyBtn.Parent = KeyFrame

local VerifyCorner = Instance.new("UICorner")
VerifyCorner.CornerRadius = UDim.new(0, 10)
VerifyCorner.Parent = VerifyBtn

-- Status
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -60, 0, 30)
Status.Position = UDim2.new(0, 30, 0, 490)
Status.BackgroundTransparency = 1
Status.Text = ""
Status.Font = Enum.Font.GothamBold
Status.TextSize = 13
Status.TextColor3 = Color3.fromRGB(255, 255, 255)
Status.Parent = KeyFrame

-- ========================================
-- FONCTIONS
-- ========================================

local function showStatus(text, color)
    Status.Text = text
    Status.TextColor3 = color
end

local function openFrame()
    local tween = TweenService:Create(KeyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 450, 0, 540)
    })
    tween:Play()
end

local function closeFrame()
    local tween = TweenService:Create(KeyFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    })
    tween:Play()
    tween.Completed:Wait()
    ScreenGui:Destroy()
end

local function loadHub()
    closeFrame()
    -- CHARGER TON HUB ICI
    loadstring(game:HttpGet("https://raw.githubusercontent.com/TexxSave/crocohub/refs/heads/main/hub.lua"))()
end

-- ========================================
-- LOGIQUE
-- ========================================

openFrame()
showStatus("💡 Universal key: CROCO2026", Color3.fromRGB(150, 150, 150))

-- Bouton Copy
CopyBtn.MouseButton1Click:Connect(function()
    setclipboard(UNIVERSAL_KEY)
    showStatus("📋 Key copied to clipboard!", Color3.fromRGB(88, 101, 242))
end)

-- Bouton Verify
VerifyBtn.MouseButton1Click:Connect(function()
    local key = KeyInput.Text:upper():gsub("%s+", "")
    
    if key == "" then
        showStatus("⚠️ Please enter a key!", Color3.fromRGB(255, 180, 50))
        return
    end
    
    VerifyBtn.Text = "⏳ Verifying..."
    VerifyBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 50)
    showStatus("⏳ Checking key...", Color3.fromRGB(255, 180, 50))
    
    task.spawn(function()
        task.wait(0.5)
        
        if verifyKey(key) then
            showStatus("✅ Key accepted! Loading hub...", Color3.fromRGB(40, 200, 80))
            VerifyBtn.Text = "✅ Success!"
            VerifyBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 100)
            
            task.wait(1)
            loadHub()
        else
            showStatus("❌ Invalid key! Try: CROCO2026", Color3.fromRGB(255, 80, 80))
            VerifyBtn.Text = "❌ Failed"
            VerifyBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            
            task.wait(2)
            VerifyBtn.Text = "✅ Verify Key"
            VerifyBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
            KeyInput.Text = ""
        end
    end)
end)

-- Verify avec Enter
KeyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed and KeyInput.Text ~= "" then
        VerifyBtn.MouseButton1Click:Fire()
    end
end)

print("🐊 Croco Hub V4 - Universal Key System")
print("Universal Key: CROCO2026")
