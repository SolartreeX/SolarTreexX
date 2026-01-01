-- === Button Container (unter dem Titel) ===
local buttonBar = Instance.new("Frame")
buttonBar.Parent = launchScreen
buttonBar.Size = UDim2.new(1, -20, 0, 70)
buttonBar.Position = UDim2.new(0, 10, 0, 60)
buttonBar.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout")
layout.Parent = buttonBar
layout.FillDirection = Enum.FillDirection.Horizontal
layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
layout.Padding = UDim.new(0, 12)

------------------------------------------------
-- Funktion: moderner, flacher Button
------------------------------------------------
local function createFlatButton(text, callback)
	local btn = Instance.new("TextButton")
	btn.Parent = buttonBar
	btn.Size = UDim2.new(0, 160, 0, 60)
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.BackgroundColor3 = Color3.fromRGB(240, 140, 90) -- orange wie im Bild
	btn.AutoButtonColor = false

	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0, 8)

	-- leichter Glow-Rand
	local stroke = Instance.new("UIStroke", btn)
	stroke.Thickness = 1.5
	stroke.Color = Color3.fromRGB(255,180,120)
	stroke.Transparency = 0.3

	-- Hover Effekt
	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(255, 160, 110)
	end)
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(240, 140, 90)
	end)

	btn.MouseButton1Click:Connect(callback)
end

------------------------------------------------
-- 🧪 Game‑Test Button (hier kannst du später alles reinpacken)
------------------------------------------------
createFlatButton("Game-Test", function()
	-- hier kommt dein Testcode rein
	-- Beispiel:
	print("Game Test started") -- kannst du auch entfernen
end)

------------------------------------------------
-- ♾️ Infinity Yield Button
------------------------------------------------
createFlatButton("Infinity Yield", function()
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
	end)
end)
