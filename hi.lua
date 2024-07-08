local UILibrary = {}

function UILibrary:CreateWindow(title)
    local ui = Instance.new("ScreenGui")
    ui.Name = "CumHubUI"
    ui.ResetOnSpawn = false
    ui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Parent = ui
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.BorderSizePixel = 0

    local function createUICorner(parent, radius)
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0, radius)
        uiCorner.Parent = parent
    end

    createUICorner(mainFrame, 5)

    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Parent = mainFrame
    titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BorderSizePixel = 0

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Parent = titleBar
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, -50, 1, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 20
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    titleLabel.Position = UDim2.new(0.05, 0, 0, 0)

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Parent = titleBar
    closeButton.BackgroundTransparency = 1
    closeButton.Position = UDim2.new(1, -40, 0, 0)
    closeButton.Size = UDim2.new(0, 40, 1, 0)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 20
    closeButton.MouseButton1Click:Connect(function()
        ui:Destroy()
    end)

    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Parent = mainFrame
    tabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    tabContainer.Position = UDim2.new(0, 0, 0, 40)
    tabContainer.Size = UDim2.new(1, 0, 1, -40)
    tabContainer.BorderSizePixel = 0

    local tabHolder = Instance.new("Frame")
    tabHolder.Name = "TabHolder"
    tabHolder.Parent = tabContainer
    tabHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tabHolder.Position = UDim2.new(0, 0, 0, 0)
    tabHolder.Size = UDim2.new(0.2, 0, 1, 0)
    tabHolder.BorderSizePixel = 0

    local tabContent = Instance.new("Frame")
    tabContent.Name = "TabContent"
    tabContent.Parent = tabContainer
    tabContent.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    tabContent.Position = UDim2.new(0.2, 0, 0, 0)
    tabContent.Size = UDim2.new(0.8, 0, 1, 0)
    tabContent.BorderSizePixel = 0

    local function createTabButton(name)
        local tabButton = Instance.new("TextButton")
        tabButton.Name = name .. "Tab"
        tabButton.Parent = tabHolder
        tabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        tabButton.Size = UDim2.new(1, 0, 0, 40)
        tabButton.Font = Enum.Font.Gotham
        tabButton.Text = name
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.TextSize = 16
        tabButton.TextXAlignment = Enum.TextXAlignment.Center
        tabButton.BorderSizePixel = 0

        tabButton.MouseEnter:Connect(function()
            tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end)

        tabButton.MouseLeave:Connect(function()
            tabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        end)

        return tabButton
    end

    local function createTabContent()
        local content = Instance.new("ScrollingFrame")
        content.Name = "TabContentFrame"
        content.Parent = tabContent
        content.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        content.Position = UDim2.new(0, 0, 0, 0)
        content.Size = UDim2.new(1, 0, 1, 0)
        content.CanvasSize = UDim2.new(0, 0, 2, 0)
        content.ScrollBarThickness = 4
        content.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
        content.BorderSizePixel = 0

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 5)
        layout.Parent = content

        return content
    end

    function UILibrary:CreateTab(name)
        local tabButton = createTabButton(name)
        local contentFrame = createTabContent()

        tabButton.MouseButton1Click:Connect(function()
            for _, child in pairs(tabContent:GetChildren()) do
                if child:IsA("ScrollingFrame") then
                    child.Visible = false
                end
            end
            contentFrame.Visible = true
        end)

        contentFrame.Visible = false

        return {
            Button = tabButton,
            Content = contentFrame
        }
    end

    function UILibrary:CreateButton(parent, text, callback)
        local button = Instance.new("TextButton")
        button.Parent = parent
        button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        button.Size = UDim2.new(0, 180, 0, 40)
        button.Font = Enum.Font.Gotham
        button.Text = text
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextSize = 16
        button.BorderSizePixel = 0

        button.MouseEnter:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end)

        button.MouseLeave:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        end)

        button.MouseButton1Click:Connect(function()
            callback()
        end)
    end

    function UILibrary:CreateLabel(parent, text)
        local label = Instance.new("TextLabel")
        label.Parent = parent
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(0, 180, 0, 40)
        label.Font = Enum.Font.Gotham
        label.Text = text
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 16
        label.TextXAlignment = Enum.TextXAlignment.Left
    end

    function UILibrary:CreateTextBox(parent, placeholderText, callback)
        local textBox = Instance.new("TextBox")
        textBox.Parent = parent
        textBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        textBox.Size = UDim2.new(0, 180, 0, 40)
        textBox.Font = Enum.Font.Gotham
        textBox.PlaceholderText = placeholderText
        textBox.Text = ""
        textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        textBox.TextSize = 16
        textBox.BorderSizePixel = 0

        textBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                callback(textBox.Text)
            end
        end)
    end

    function UILibrary:CreateDropdown(parent, items, callback)
        local dropdown = Instance.new("TextButton")
        dropdown.Parent = parent
        dropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        dropdown.Size = UDim2.new(0, 180, 0, 40)
        dropdown.Font = Enum.Font.Gotham
        dropdown.Text = items[1]
        dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
        dropdown.TextSize = 16
        dropdown.BorderSizePixel = 0

        local dropdownFrame = Instance.new("Frame")
        dropdownFrame.Parent = dropdown
        dropdownFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        dropdownFrame.Size = UDim2.new(1, 0, #items * 40, 0)
        dropdownFrame.Position = UDim2.new(0, 0, 1, 0)
        dropdownFrame.Visible = false

        local layout = Instance.new("UIListLayout")
        layout.Parent = dropdownFrame

        for _, item in ipairs(items) do
            local option = Instance.new("TextButton")
            option.Parent = dropdownFrame
            option.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            option.Size = UDim2.new(1, 0, 0, 40)
            option.Font = Enum.Font.Gotham
            option.Text = item
            option.TextColor3 = Color3.fromRGB(255, 255, 255)
            option.TextSize = 16
            option.BorderSizePixel = 0

            option.MouseButton1Click:Connect(function()
                dropdown.Text = item
                dropdownFrame.Visible = false
                callback(item)
            end)
        end

        dropdown.MouseButton1Click:Connect(function()
            dropdownFrame.Visible = not dropdownFrame.Visible
        end)
    end

    function UILibrary:CreateSlider(parent, min, max, callback)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Parent = parent
        sliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        sliderFrame.Size = UDim2.new(0, 180, 0, 40)
        sliderFrame.BorderSizePixel = 0

        local sliderBar = Instance.new("Frame")
        sliderBar.Parent = sliderFrame
        sliderBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        sliderBar.Position = UDim2.new(0.1, 0, 0.5, -2)
        sliderBar.Size = UDim2.new(0.8, 0, 0, 4)

        local sliderButton = Instance.new("TextButton")
        sliderButton.Parent = sliderFrame
        sliderButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        sliderButton.Size = UDim2.new(0, 20, 0, 20)
        sliderButton.Position = UDim2.new(0.1, -10, 0.5, -10)
        sliderButton.BorderSizePixel = 0
        sliderButton.AutoButtonColor = false

        local valueLabel = Instance.new("TextLabel")
        valueLabel.Parent = sliderFrame
        valueLabel.BackgroundTransparency = 1
        valueLabel.Position = UDim2.new(0.5, 0, 0, 0)
        valueLabel.Size = UDim2.new(0.5, 0, 1, 0)
        valueLabel.Font = Enum.Font.Gotham
        valueLabel.Text = tostring(min)
        valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        valueLabel.TextSize = 16
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right

        local dragging = false

        sliderButton.MouseButton1Down:Connect(function()
            dragging = true
        end)

        game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        sliderButton.MouseMoved:Connect(function()
            if dragging then
                local mouse = game.Players.LocalPlayer:GetMouse()
                local relativePos = mouse.X - sliderBar.AbsolutePosition.X
                local relativeScale = math.clamp(relativePos / sliderBar.AbsoluteSize.X, 0, 1)
                local value = min + (max - min) * relativeScale

                sliderButton.Position = UDim2.new(relativeScale, -10, 0.5, -10)
                valueLabel.Text = string.format("%.2f", value)

                callback(value)
            end
        end)
    end

    function UILibrary:CreateToggle(parent, text, callback)
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Parent = parent
        toggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        toggleFrame.Size = UDim2.new(0, 180, 0, 40)
        toggleFrame.BorderSizePixel = 0

        local toggleLabel = Instance.new("TextLabel")
        toggleLabel.Parent = toggleFrame
        toggleLabel.BackgroundTransparency = 1
        toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
        toggleLabel.Font = Enum.Font.Gotham
        toggleLabel.Text = text
        toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleLabel.TextSize = 16
        toggleLabel.TextXAlignment = Enum.TextXAlignment.Left

        local toggleButton = Instance.new("TextButton")
        toggleButton.Parent = toggleFrame
        toggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        toggleButton.Size = UDim2.new(0.3, -10, 0.6, 0)
        toggleButton.Position = UDim2.new(0.7, 5, 0.2, 0)
        toggleButton.BorderSizePixel = 0
        toggleButton.AutoButtonColor = false

        local toggled = false

        toggleButton.MouseButton1Click:Connect(function()
            toggled = not toggled
            if toggled then
                toggleButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
            else
                toggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            end
            callback(toggled)
        end)
    end

    return {
        CreateTab = function(name)
            return UILibrary:CreateTab(name)
        end,
        CreateButton = function(parent, text, callback)
            UILibrary:CreateButton(parent, text, callback)
        end,
        CreateLabel = function(parent, text)
            UILibrary:CreateLabel(parent, text)
        end,
        CreateTextBox = function(parent, placeholderText, callback)
            UILibrary:CreateTextBox(parent, placeholderText, callback)
        end,
        CreateDropdown = function(parent, items, callback)
            UILibrary:CreateDropdown(parent, items, callback)
        end,
        CreateSlider = function(parent, min, max, callback)
            UILibrary:CreateSlider(parent, min, max, callback)
        end,
        CreateToggle = function(parent, text, callback)
            UILibrary:CreateToggle(parent, text, callback)
        end
    }
end

return UILibrary
