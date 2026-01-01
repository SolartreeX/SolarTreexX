-- === ScreenGui erstellen ===
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Parent = playerGui
gui.ResetOnSpawn = false

-- === Launch Screen / zentrales Menü ===
local launchScreen = Instance.new("Frame")
launchScreen.Parent = gui
launchScreen.Size = UDim2.new(0, 300, 0, 150)
launchScreen.Position = UDim2.new(0.5, -150, 0.5, -75)
launchScreen.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
launchScreen.BackgroundTransparency = 0.1
launchScreen.BorderSizePixel = 0
launchScreen.AnchorPoint = Vector2.new(0.5, 0.5)

-- Titel
local title = Instance.new("TextLabel")
title.Parent = launchScreen
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Menu"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1

-- Loading Button
local loadingBtn = Instance.new("TextButton")
loadingBtn.Parent = launchScreen
loadingBtn.Size = UDim2.new(0, 200, 0, 50)
loadingBtn.Position = UDim2.new(0.5, -100, 0.5, -25)
loadingBtn.Text = "Loading"
loadingBtn.Font = Enum.Font.GothamBold
loadingBtn.TextScaled = true
loadingBtn.TextColor3 = Color3.fromRGB(255,255,255)
loadingBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
loadingBtn.AutoButtonColor = false

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = loadingBtn

-- Hover Effekt
loadingBtn.MouseEnter:Connect(function()
    loadingBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
end)
loadingBtn.MouseLeave:Connect(function()
    loadingBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
end)

-- === Blaues Panel mit Drag, Buttons und Minimize Feature ===
local function createMainPanel()
    -- Launch Screen verschwindet
    launchScreen.Visible = false

    local panel = Instance.new("Frame")
    panel.Parent = gui
    panel.Size = UDim2.new(0, 300, 0, 200)
    panel.Position = UDim2.new(0.5, -150, 0.5, -100)
    panel.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    panel.BackgroundTransparency = 0.5
    panel.BorderSizePixel = 1
    panel.BorderColor3 = Color3.fromRGB(0, 90, 200)
    panel.AnchorPoint = Vector2.new(0.5, 0.5)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = panel

    -- Draggable
    panel.Active = true
    panel.Draggable = true

    -- === Info / Minimize / Maximize ===
    local infoBar = Instance.new("Frame")
    infoBar.Parent = panel
    infoBar.Size = UDim2.new(1, 0, 0, 25)
    infoBar.Position = UDim2.new(0,0,0,0)
    infoBar.BackgroundColor3 = Color3.fromRGB(20,20,20)

    local infoText = Instance.new("TextLabel")
    infoText.Parent = infoBar
    infoText.Size = UDim2.new(1, -30, 1, 0)
    infoText.Position = UDim2.new(0,5,0,0)
    infoText.Text = "Made by Waynism"
    infoText.Font = Enum.Font.GothamBold
    infoText.TextColor3 = Color3.fromRGB(255,255,255)
    infoText.BackgroundTransparency = 1
    infoText.TextScaled = true
    infoText.TextXAlignment = Enum.TextXAlignment.Left

    -- Buttons oben rechts
    local minBtn = Instance.new("TextButton")
    minBtn.Parent = infoBar
    minBtn.Size = UDim2.new(0, 25, 0, 25)
    minBtn.Position = UDim2.new(1, -55, 0, 0)
    minBtn.Text = "-"
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextColor3 = Color3.fromRGB(255,255,255)
    minBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    minBtn.AutoButtonColor = false
    local cornerMin = Instance.new("UICorner", minBtn)
    cornerMin.CornerRadius = UDim.new(0,4)

    local maxBtn = Instance.new("TextButton")
    maxBtn.Parent = infoBar
    maxBtn.Size = UDim2.new(0, 25, 0, 25)
    maxBtn.Position = UDim2.new(1, -25, 0, 0)
    maxBtn.Text = "+"
    maxBtn.Font = Enum.Font.GothamBold
    maxBtn.TextColor3 = Color3.fromRGB(255,255,255)
    maxBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    maxBtn.AutoButtonColor = false
    local cornerMax = Instance.new("UICorner", maxBtn)
    cornerMax.CornerRadius = UDim.new(0,4)

    -- Container für die Buttons (damit wir sie minimieren)
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Parent = panel
    buttonContainer.Size = UDim2.new(1,0,1, -25)
    buttonContainer.Position = UDim2.new(0,0,0,25)
    buttonContainer.BackgroundTransparency = 1

    -- === Funktion um Buttons zu erstellen ===
    local function createButton(text, pos, url)
        local btn = Instance.new("TextButton")
        btn.Parent = buttonContainer
        btn.Size = UDim2.new(0, 120, 0, 50)
        btn.Position = pos
        btn.Text = text
        btn.Font = Enum.Font.GothamBold
        btn.TextScaled = true
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
        btn.AutoButtonColor = false

        local cornerBtn = Instance.new("UICorner")
        cornerBtn.CornerRadius = UDim.new(0, 6)
        cornerBtn.Parent = btn

        -- Hover Effekt
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
        end)

        -- Klick Animation + Executen
        btn.MouseButton1Click:Connect(function()
            btn:TweenSize(UDim2.new(0, 110, 0, 45), "Out", "Quad", 0.1, true)
            wait(0.1)
            btn:TweenSize(UDim2.new(0, 120, 0, 50), "Out", "Quad", 0.1, true)

            pcall(function()
                loadstring(game:HttpGet(url))()
            end)
        end)
    end

    -- Buttons hinzufügen
    createButton("Infinite Yield", UDim2.new(0, 20, 0, 10), "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
    createButton("Bee-Swarm", UDim2.new(0, 160, 0, 10), "https://rawscripts.net/raw/Bee-Swarm-Simulator-Atlas-49277")

    -- Minimize / Maximize Funktion
    minBtn.MouseButton1Click:Connect(function()
        buttonContainer.Visible = false
        panel.Size = UDim2.new(0,300,0,25) -- nur Balken sichtbar
    end)

    maxBtn.MouseButton1Click:Connect(function()
        buttonContainer.Visible = true
        panel.Size = UDim2.new(0,300,0,200)
    end)
end

loadingBtn.MouseButton1Click:Connect(createMainPanel)
