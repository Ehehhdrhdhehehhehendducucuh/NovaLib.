local NovaLib = {}

function NovaLib:CreateWindow(windowName)
    local gui = Instance.new("ScreenGui")
    gui.Name = windowName or "NovaGui"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = game.CoreGui
    return gui
end

function NovaLib:CreateFrame(parent)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 200)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    return frame
end

function NovaLib:CreateTabs(parent, tabs)
    local tabHolder = Instance.new("Frame")
    tabHolder.Size = UDim2.new(1, 0, 0, 50)
    tabHolder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabHolder.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = tabHolder

    local buttons = {}

    for i, tabName in ipairs(tabs) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 100, 1, 0)
        button.Position = UDim2.new((i - 1) * 0.33, 0, 0, 0)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        button.Text = tabName
        button.Font = Enum.Font.GothamBold
        button.TextSize = 14
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Parent = tabHolder

        local cornerButton = Instance.new("UICorner")
        cornerButton.CornerRadius = UDim.new(0, 12)
        cornerButton.Parent = button

        button.MouseButton1Click:Connect(function()
            for _, btn in pairs(buttons) do
                btn:TweenSize(UDim2.new(0, 100, 1, 0), "Out", "Quad", 0.3, true)
                btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            end
            button:TweenSize(UDim2.new(0, 110, 1, 0), "Out", "Quad", 0.3, true)
            button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end)

        buttons[tabName] = button
    end

    return tabHolder, buttons
end

function NovaLib:CreateButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 100, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button

    button.MouseButton1Click:Connect(callback)

    return button
end

function NovaLib:CreateToggle(parent, text, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0, 150, 0, 50)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    toggleFrame.Parent = parent

    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Size = UDim2.new(0, 100, 1, 0)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Text = text
    toggleLabel.Font = Enum.Font.Gotham
    toggleLabel.TextSize = 14
    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleLabel.Parent = toggleFrame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 40, 0, 20)
    toggleButton.Position = UDim2.new(1, -50, 0.5, -10)
    toggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    toggleButton.Text = ""
    toggleButton.Parent = toggleFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = toggleButton

    local isToggled = false
    toggleButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        if isToggled then
            toggleButton.Position = UDim2.new(1, -50, 0.5, -10)
        else
            toggleButton.Position = UDim2.new(0, 10, 0.5, -10)
        end
        callback(isToggled)
    end)

    return toggleFrame
end

function NovaLib:CreateSlider(parent, text, min, max, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0, 200, 0, 60)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sliderFrame.Parent = parent

    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Size = UDim2.new(0, 200, 0, 20)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Text = text
    sliderLabel.Font = Enum.Font.Gotham
    sliderLabel.TextSize = 14
    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderLabel.Parent = sliderFrame

    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(1, 0, 0, 10)
    sliderBar.Position = UDim2.new(0, 0, 0, 30)
    sliderBar.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    sliderBar.Parent = sliderFrame

    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(0, 10, 1, 0)
    sliderButton.Position = UDim2.new(0, 0, 0, 0)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.Text = ""
    sliderButton.Parent = sliderBar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = sliderButton

    local mouse = game:GetService("Players").LocalPlayer:GetMouse()
    local dragging = false
    sliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local x = math.clamp(input.Position.X - sliderBar.AbsolutePosition.X, 0, sliderBar.AbsoluteSize.X)
            sliderButton.Position = UDim2.new(0, x, 0, 0)
            local value = math.floor((x / sliderBar.AbsoluteSize.X) * (max - min) + min)
            callback(value)
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    return sliderFrame
end

return NovaLib
