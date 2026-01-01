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

-- === Hilfsfunktion: sicheres Fetch mit mehreren Fallbacks ===
local function safeFetch(url)
    local ok, res
    -- syn.request
    if syn and syn.request then
        ok, res = pcall(function() return syn.request{Url = url, Method = "GET"}.Body end)
        if ok and res and res ~= "" then return res end
    end
    -- request
    if request then
        ok, res = pcall(function() return request({Url = url, Method = "GET"}).Body end)
        if ok and res and res ~= "" then return res end
    end
    -- http.request
    if http and http.request then
        ok, res = pcall(function() local r = http.request{Url = url, Method = "GET"}; return (r and (r.Body or r.body)) end)
        if ok and res and res ~= "" then return res end
    end
    -- http_request
    if http_request then
        ok, res = pcall(function() local r = http_request({Url = url, Method = "GET"}); return (r and (r.Body or r.body)) end)
        if ok and res and res ~= "" then return res end
    end
    -- game HttpGetAsync / HttpGet
    if game and game.HttpGetAsync then
        ok, res = pcall(function() return game:HttpGetAsync(url) end)
        if ok and res and res ~= "" then return res end
    end
    if game and game.HttpGet then
        ok, res = pcall(function() return game:HttpGet(url) end)
        if ok and res and res ~= "" then return res end
    end
    return nil, "no_method_available"
end

-- === Blaues Panel mit Drag, Buttons und Minimize Feature (sicherer) ===
local function createMainPanel()
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

    panel.Active = true
    panel.Draggable = true

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

    local buttonContainer = Instance.new("Frame")
    buttonContainer.Parent = panel
    buttonContainer.Size = UDim2.new(1,0,1, -25)
    buttonContainer.Position = UDim2.new(0,0,0,25)
    buttonContainer.BackgroundTransparency = 1

    -- Confirmation modal (reused for external scripts)
    local function showConfirmation(titleText, url)
        local modal = Instance.new("Frame")
        modal.Name = "ConfirmModal"
        modal.Parent = gui
        modal.AnchorPoint = Vector2.new(0.5,0.5)
        modal.Size = UDim2.new(0, 420, 0, 150)
        modal.Position = UDim2.new(0.5, 0, 0.5, 0)
        modal.BackgroundColor3 = Color3.fromRGB(30,30,30)
        modal.BorderSizePixel = 0
        local mCorner = Instance.new("UICorner", modal)
        mCorner.CornerRadius = UDim.new(0,8)

        local header = Instance.new("TextLabel", modal)
        header.Size = UDim2.new(1,0,0,30)
        header.Position = UDim2.new(0,0,0,0)
        header.BackgroundTransparency = 1
        header.Text = titleText or "Confirm"
        header.Font = Enum.Font.GothamBold
        header.TextScaled = true
        header.TextColor3 = Color3.fromRGB(255,255,255)

        local body = Instance.new("TextLabel", modal)
        body.Size = UDim2.new(1,-20,0,70)
        body.Position = UDim2.new(0,10,0,40)
        body.TextWrapped = true
        body.BackgroundTransparency = 1
        body.Text = "External scripts can trigger anti-cheat and get you kicked.\nURL: " .. tostring(url) .. "\n\nUse 'Copy Link' to copy the URL and run it manually if you understand the risks."
        body.Font = Enum.Font.SourceSans
        body.TextColor3 = Color3.fromRGB(220,220,220)
        body.TextXAlignment = Enum.TextXAlignment.Left

        local copyBtn = Instance.new("TextButton", modal)
        copyBtn.Size = UDim2.new(0, 120, 0, 30)
        copyBtn.Position = UDim2.new(0.5, -130, 1, -40)
        copyBtn.Text = "Copy Link"
        copyBtn.Font = Enum.Font.GothamBold
        copyBtn.TextColor3 = Color3.fromRGB(255,255,255)
        copyBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
        local copyCorner = Instance.new("UICorner", copyBtn)
        copyCorner.CornerRadius = UDim.new(0,6)

        local execBtn = Instance.new("TextButton", modal)
        execBtn.Size = UDim2.new(0, 120, 0, 30)
        execBtn.Position = UDim2.new(0.5, 10, 1, -40)
        execBtn.Text = "Execute (unsafe)"
        execBtn.Font = Enum.Font.GothamBold
        execBtn.TextColor3 = Color3.fromRGB(255,255,255)
        execBtn.BackgroundColor3 = Color3.fromRGB(180,60,60)
        local execCorner = Instance.new("UICorner", execBtn)
        execCorner.CornerRadius = UDim.new(0,6)

        local cancelBtn = Instance.new("TextButton", modal)
        cancelBtn.Size = UDim2.new(0, 60, 0, 24)
        cancelBtn.Position = UDim2.new(1, -70, 0, 6)
        cancelBtn.Text = "X"
        cancelBtn.Font = Enum.Font.GothamBold
        cancelBtn.TextColor3 = Color3.fromRGB(255,255,255)
        cancelBtn.BackgroundColor3 = Color3.fromRGB(90,90,90)
        local cancelCorner = Instance.new("UICorner", cancelBtn)
        cancelCorner.CornerRadius = UDim.new(0,6)

        -- Button actions
        copyBtn.MouseButton1Click:Connect(function()
            if setclipboard then
                pcall(function() setclipboard(tostring(url)) end)
            else
                -- fallback: print URL so user can copy
                print("Copy this URL:", url)
            end
        end)

        cancelBtn.MouseButton1Click:Connect(function()
            modal:Destroy()
        end)

        execBtn.MouseButton1Click:Connect(function()
            -- Warn user and then attempt fetch+execute. This is explicitly unsafe.
            local src, ferr = safeFetch(url)
            if not src then
                warn("Konnte externe Datei nicht laden:", ferr)
                return
            end
            local f, err = loadstring(src)
            if not f then
                warn("loadstring failed:", err)
                return
            end
            -- execute in protected call
            local ok, err2 = pcall(f)
            if not ok then
                warn("Execution error:", err2)
            end
            modal:Destroy()
        end)
    end

    -- === Funktion um Buttons zu erstellen (ändert Verhalten: zeigt Bestätigungsdialog statt sofort auszuführen) ===
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

        -- Klick: Zeige Bestätigungsdialog an statt sofortigem loadstring
        btn.MouseButton1Click:Connect(function()
            btn:TweenSize(UDim2.new(0, 110, 0, 45), "Out", "Quad", 0.1, true)
            wait(0.1)
            btn:TweenSize(UDim2.new(0, 120, 0, 50), "Out", "Quad", 0.1, true)

            if type(url) == "string" and url ~= "" then
                showConfirmation("Externe Ausführung", url)
            else
                print("Button pressed:", text)
            end
        end)
    end

    -- Buttons hinzufügen (URLs bleiben sichtbar, aber werden nicht automatisch ausgeführt)
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
