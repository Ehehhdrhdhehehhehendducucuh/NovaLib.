local NovaLib = {}

function NovaLib:CreateGui()
    local gui = Instance.new("ScreenGui")
    gui.Name = "Nova"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = game.CoreGui
    return gui
end

function NovaLib:CreateFrame(parent, size, color)
    local frame = Instance.new("Frame")
    frame.Size = size or UDim2.new(0, 300, 0, 200)
    frame.BackgroundColor3 = color or Color3.fromRGB(30, 30, 30)
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
    tabHolder.Size = UDim2.new(1, 0, 0, 40)
    tabHolder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabHolder.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = tabHolder

    local buttons = {}

    for i, tabName in ipairs(tabs) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 80, 1, 0)
        button.Position = UDim2.new((i - 1) * 0.2, 0, 0, 0)
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
                btn:TweenSize(UDim2.new(0, 80, 1, 0), "Out", "Quad", 0.3, true)
                btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            end
            button:TweenSize(UDim2.new(0, 90, 1, 0), "Out", "Quad", 0.3, true)
            button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end)

        buttons[tabName] = button
    end

    return tabHolder, buttons
end
