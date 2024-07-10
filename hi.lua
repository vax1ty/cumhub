local UILibrary = {}

-- Helper function to create UI corners
local function createUICorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
end

-- Helper function to create UI shadows
local function createShadow(parent, radius, color, transparency)
    local shadow = Instance.new("ImageLabel")
    shadow.BackgroundTransparency = 1
    shadow.BorderSizePixel = 0
    shadow.Size = UDim2.new(1, radius * 2, 1, radius * 2)
    shadow.Image = "rbxassetid://1316045217" -- Shadow asset ID
    shadow.ImageColor3 = color
    shadow.ImageTransparency = transparency
    shadow.ZIndex = parent.ZIndex - 1
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Parent = parent
end

-- Helper function to create UI gradients
local function createGradient(parent, color1, color2)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(color1, color2)
    gradient.Parent = parent
end

-- Helper function to create buttons
local function createButton(parent, text, size, position, callback)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(100, 0, 153)
    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 20
    button.Parent = parent
    createUICorner(button, 10)
    createShadow(button, 5, Color3.fromRGB(0, 0, 0), 0.6)

    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
        button:TweenSize(button.Size + UDim2.new(0, 10, 0, 10), "Out", "Quad", 0.2, true)
    end)

    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(100, 0, 153)
        button:TweenSize(button.Size - UDim2.new(0, 10, 0, 10), "Out", "Quad", 0.2, true)
    end)

    button.MouseButton1Click:Connect(callback)

    return button
end

-- Helper function to create tooltips
local function createTooltip(parent, text)
    local tooltip = Instance.new("TextLabel")
    tooltip.BackgroundTransparency = 0.8
    tooltip.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tooltip.TextColor3 = Color3.fromRGB(255, 255, 255)
    tooltip.Font = Enum.Font.Gotham
    tooltip.TextSize = 14
    tooltip.Text = text
    tooltip.Size = UDim2.new(0, 100, 0, 50)
    tooltip.Visible = false
    tooltip.Parent = parent
    createUICorner(tooltip, 5)

    parent.MouseEnter:Connect(function()
        tooltip.Position = UDim2.new(0.5, -50, 0, -60)
        tooltip.Visible = true
    end)

    parent.MouseLeave:Connect(function()
        tooltip.Visible = false
    end)
end

-- Function to create the main window
function UILibrary:CreateWindow(title)
    local windowInstance = {}

    local gui = Instance.new("ScreenGui")
    gui.Name = "ModernUI"
    gui.Parent = game.CoreGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Parent = gui
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.Size = UDim2.new(0, 600, 0, 700)
    mainFrame.Active = true
    mainFrame.Draggable = true
    createUICorner(mainFrame, 10)
    createShadow(mainFrame, 10, Color3.fromRGB(0, 0, 0), 0.7)
    createGradient(mainFrame, Color3.fromRGB(45, 45, 45), Color3.fromRGB(55, 55, 55))

    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Parent = mainFrame
    topBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    topBar.Size = UDim2.new(1, 0, 0, 50)
    createUICorner(topBar, 10)
    createShadow(topBar, 5, Color3.fromRGB(0, 0, 0), 0.6)
    createGradient(topBar, Color3.fromRGB(60, 60, 60), Color3.fromRGB(70, 70, 70))

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Parent = topBar
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 24
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Position = UDim2.new(0.05, 0, 0, 0)

    local closeButton = createButton(topBar, "X", UDim2.new(0, 40, 0, 40), UDim2.new(1, -45, 0, 5), function()
        gui:Destroy()
    end)
    createTooltip(closeButton, "Close")

    local minimizeButton = createButton(topBar, "-", UDim2.new(0, 40, 0, 40), UDim2.new(1, -90, 0, 5), function()
        mainFrame.Visible = not mainFrame.Visible
    end)
    createTooltip(minimizeButton, "Minimize")

    local tabHolder = Instance.new("ScrollingFrame")
    tabHolder.Name = "TabHolder"
    tabHolder.Parent = mainFrame
    tabHolder.BackgroundTransparency = 1
    tabHolder.Position = UDim2.new(0.025, 0, 0.1, 0)
    tabHolder.Size = UDim2.new(0.95, 0, 0.05, 0)
    tabHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabHolder.ScrollBarThickness = 0
    tabHolder.AutomaticCanvasSize = Enum.AutomaticSize.X

    local uiListLayoutTabs = Instance.new("UIListLayout")
    uiListLayoutTabs.Parent = tabHolder
    uiListLayoutTabs.FillDirection = Enum.FillDirection.Horizontal
    uiListLayoutTabs.HorizontalAlignment = Enum.HorizontalAlignment.Left
    uiListLayoutTabs.Padding = UDim.new(0, 5)

    local uiPaddingTabs = Instance.new("UIPadding")
    uiPaddingTabs.Parent = tabHolder
    uiPaddingTabs.PaddingTop = UDim.new(0, 10)
    uiPaddingTabs.PaddingBottom = UDim.new(0, 10)
    uiPaddingTabs.PaddingLeft = UDim.new(0, 10)
    uiPaddingTabs.PaddingRight = UDim.new(0, 10)

    local contentHolder = Instance.new("Frame")
    contentHolder.Name = "ContentHolder"
    contentHolder.Parent = mainFrame
    contentHolder.BackgroundTransparency = 1
    contentHolder.Position = UDim2.new(0.025, 0, 0.2, 0)
    contentHolder.Size = UDim2.new(0.95, 0, 0.75, 0)
    createUICorner(contentHolder, 10)
    createShadow(contentHolder, 10, Color3.fromRGB(0, 0, 0), 0.7)

    -- Function to add tabs
    function windowInstance:AddTab(tabName)
        local tab = {}

        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName
        tabButton.Parent = tabHolder
        tabButton.BackgroundColor3 = Color3.fromRGB(100, 0, 153)
        tabButton.Size = UDim2.new(0, 100, 0, 30)
        tabButton.Font = Enum.Font.GothamBold
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.TextSize = 18
        tabButton.AutomaticSize = Enum.AutomaticSize.X
        createUICorner(tabButton, 10)
        createShadow(tabButton, 5, Color3.fromRGB(0, 0, 0), 0.6)
        create

Gradient(tabButton, Color3.fromRGB(153, 0, 204), Color3.fromRGB(204, 0, 255))

        local tabContent = Instance.new("Frame")
        tabContent.Name = tabName .. "Content"
        tabContent.Parent = contentHolder
        tabContent.BackgroundTransparency = 1
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.Visible = false
        createUICorner(tabContent, 10)
        createShadow(tabContent, 10, Color3.fromRGB(0, 0, 0), 0.7)

        local paddingTabContent = Instance.new("UIPadding")
        paddingTabContent.Parent = tabContent
        paddingTabContent.PaddingTop = UDim.new(0, 10)
        paddingTabContent.PaddingBottom = UDim.new(0, 10)
        paddingTabContent.PaddingLeft = UDim.new(0, 10)
        paddingTabContent.PaddingRight = UDim.new(0, 10)

        local uiListLayoutTabContent = Instance.new("UIListLayout")
        uiListLayoutTabContent.Parent = tabContent
        uiListLayoutTabContent.FillDirection = Enum.FillDirection.Vertical
        uiListLayoutTabContent.HorizontalAlignment = Enum.HorizontalAlignment.Center
        uiListLayoutTabContent.Padding = UDim.new(0, 5)

        tabButton.MouseButton1Click:Connect(function()
            for _, frame in pairs(contentHolder:GetChildren()) do
                if frame:IsA("Frame") then
                    frame.Visible = false
                end
            end
            tabContent.Visible = true
        end)

        tab.AddButton = function(buttonText, callback)
            local button = createButton(tabContent, buttonText, UDim2.new(0, 100, 0, 30), UDim2.new(0, 0, 0, 0))
            button.MouseButton1Click:Connect(callback)
        end

        tab.AddDropdown = function(dropdownText, options, callback)
            local dropdown = createDropdown(tabContent, options, UDim2.new(0, 100, 0, 30), UDim2.new(0, 0, 0, 0), callback)
            dropdown.MouseButton1Click:Connect(callback)
        end

        tab.AddToggle = function(toggleText, callback)
            local toggle = createToggle(tabContent, toggleText, UDim2.new(0, 100, 0, 30), UDim2.new(0, 0, 0, 0), callback)
            toggle.MouseButton1Click:Connect(callback)
        end

        tab.AddLabel = function(labelText)
            createLabel(tabContent, labelText, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0))
        end

        tab.AddTextBox = function(callback)
            local textBox = createTextBox(tabContent, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), callback)
            textBox.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    callback(textBox.Text)
                end
            end)
        end

        tab.AddCheckbox = function(checkboxText, callback)
            createCheckbox(tabContent, checkboxText, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), callback)
        end

        return tab
    end

    return windowInstance
end

return UILibrary

-- Helper function to create text labels
local function createLabel(parent, text, size, position)
    local label = Instance.new("TextLabel")
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.Gotham
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 18
    label.Parent = parent

    return label
end

-- Helper function to create text boxes
local function createTextBox(parent, size, position, callback)
    local textBox = Instance.new("TextBox")
    textBox.Size = size
    textBox.Position = position
    textBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    textBox.Font = Enum.Font.Gotham
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.TextSize = 18
    textBox.ClearTextOnFocus = false
    textBox.Parent = parent
    createUICorner(textBox, 5)
    createShadow(textBox, 5, Color3.fromRGB(0, 0, 0), 0.6)

    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(textBox.Text)
        end
    end)

    return textBox
end

-- Helper function to create checkboxes
local function createCheckbox(parent, text, size, position, callback)
    local checkbox = Instance.new("Frame")
    checkbox.Size = size
    checkbox.Position = position
    checkbox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    checkbox.Parent = parent
    createUICorner(checkbox, 5)
    createShadow(checkbox, 5, Color3.fromRGB(0, 0, 0), 0.6)

    local checkmark = Instance.new("ImageLabel")
    checkmark.Size = UDim2.new(0.8, 0, 0.8, 0)
    checkmark.Position = UDim2.new(0.1, 0, 0.1, 0)
    checkmark.BackgroundTransparency = 1
    checkmark.Image = "rbxassetid://3926305904" -- Checkmark asset ID
    checkmark.ImageColor3 = Color3.fromRGB(255, 255, 255)
    checkmark.Visible = false
    checkmark.Parent = checkbox

    local label = createLabel(checkbox, text, UDim2.new(0.7, -30, 1, 0), UDim2.new(0.2, 30, 0, 0))

    checkbox.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            checkmark.Visible = not checkmark.Visible
            callback(checkmark.Visible)
        end
    end)

    return checkbox
end

-- Helper function to create toggles
local function createToggle(parent, text, size, position, callback)
    local toggle = Instance.new("Frame")
    toggle.Size = size
    toggle.Position = position
    toggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    toggle.Parent = parent
    createUICorner(toggle, 5)
    createShadow(toggle, 5, Color3.fromRGB(0, 0, 0), 0.6)

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0.5, 0, 1, 0)
    toggleButton.Position = UDim2.new(0, 0, 0, 0)
    toggleButton.BackgroundColor3 = Color3.fromRGB(100, 0, 153)
    toggleButton.Text = ""
    toggleButton.Parent = toggle
    createUICorner(toggleButton, 5)
    createShadow(toggleButton, 5, Color3.fromRGB(0, 0, 0), 0.6)

    local toggleIndicator = Instance.new("Frame")
    toggleIndicator.Size = UDim2.new(0.4, 0, 0.8, 0)
    toggleIndicator.Position = UDim2.new(0.05, 0, 0.1, 0)
    toggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleIndicator.Parent = toggleButton
    createUICorner(toggleIndicator, 5)

    local label = createLabel(toggle, text, UDim2.new(0.4, -40, 1, 0), UDim2.new(0.55, 40, 0, 0))

    local isToggled = false

    toggleButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        toggleIndicator.Position = isToggled and UDim2.new(0.55, 0, 0.1, 0) or UDim2.new(0.05, 0, 0.1, 0)
        callback(isToggled)
    end)

    return toggle
end

-- Helper function to create sliders
local function createSlider(parent, text, minValue, maxValue, defaultValue, position, callback)
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, 0, 0, 50)
    slider.Position = position
    slider.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    slider.Parent = parent
    createUICorner(slider, 5)
    createShadow(slider, 5, Color3.fromRGB(0, 0, 0), 0.6)

    local label = createLabel(slider, text, UDim2.new(0.4, -40, 0.4, 0), UDim2.new(0.05, 40, 0.05, 0))

   

 local valueLabel = createLabel(slider, tostring(defaultValue), UDim2.new(0.2, -40, 0.4, 0), UDim2.new(0.75, 40, 0.05, 0))

    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(0.7, 0, 0.1, 0)
    sliderBar.Position = UDim2.new(0.05, 0, 0.55, 0)
    sliderBar.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    sliderBar.Parent = slider
    createUICorner(sliderBar, 5)

    local sliderIndicator = Instance.new("Frame")
    sliderIndicator.Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 0.8, 0)
    sliderIndicator.Position = UDim2.new(0, 0, 0.1, 0)
    sliderIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderIndicator.Parent = sliderBar
    createUICorner(sliderIndicator, 5)

    local isDragging = false

    local function updateValue()
        local value = math.floor(minValue + (maxValue - minValue) * sliderIndicator.Size.X.Scale)
        valueLabel.Text = tostring(value)
        callback(value)
    end

    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
        end
    end)

    sliderBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 th
            isDragging = false
        end
    end)

    sliderBar.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePosition = input.Position.X
            local sliderPosition = sliderBar.AbsolutePosition.X
            local sliderSize = sliderBar.AbsoluteSize.X
            local normalizedValue = math.clamp((mousePosition - sliderPosition) / sliderSize, 0, 1)
            sliderIndicator.Size = UDim2.new(normalizedValue, 0, 0.8, 0)
            updateValue()
        end
    end)

    return slider
end

return UILibrary
