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
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 20
    button.Parent = parent
    createUICorner(button, 10)
    createShadow(button, 5, Color3.fromRGB(0, 0, 0), 0.6)

    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
        button:TweenSize(button.Size + UDim2.new(0, 10, 0, 10), "Out", "Quad", 0.2, true)
    end)

    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
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
    mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.Size = UDim2.new(0, 600, 0, 700)
    mainFrame.Active = true
    mainFrame.Draggable = true
    createUICorner(mainFrame, 10)
    createShadow(mainFrame, 10, Color3.fromRGB(0, 0, 0), 0.7)
    createGradient(mainFrame, Color3.fromRGB(35, 35, 35), Color3.fromRGB(45, 45, 45))

    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Parent = mainFrame
    topBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    topBar.Size = UDim2.new(1, 0, 0, 50)
    createUICorner(topBar, 10)
    createShadow(topBar, 5, Color3.fromRGB(0, 0, 0), 0.6)
    createGradient(topBar, Color3.fromRGB(50, 50, 50), Color3.fromRGB(60, 60, 60))

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
        tabButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        tabButton.Size = UDim2.new(0, 100, 0, 30)
        tabButton.Font = Enum.Font.GothamBold
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.TextSize = 18
        tabButton.AutomaticSize = Enum.AutomaticSize.X
        createUICorner(tabButton, 10)
        createShadow(tabButton, 5, Color3.fromRGB(0, 0, 0), 0.6)
        createGradient(tabButton, Color3.fromRGB(153, 0, 153), Color3.fromRGB(204, 0, 204))

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

        function tab:AddButton(buttonText, callback)
            local button = createButton(tabContent, buttonText, UDim2.new(0, 100, 0, 50), UDim2.new(0, 0, 0, 0), callback)
            return button
        end

        return tab
    end

    return windowInstance
end

return UILibrary
