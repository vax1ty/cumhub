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
    mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.BorderSizePixel = 0

    local function createUICorner(parent, radius)
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0, radius)
        uiCorner.Parent = parent
    end

    createUICorner(mainFrame, 10)

    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Parent = mainFrame
    titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.BorderSizePixel = 0
    createUICorner(titleBar, 10)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Parent = titleBar
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, -50, 1, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 24
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
    tabContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    tabContainer.Position = UDim2.new(0, 0, 0, 50)
    tabContainer.Size = UDim2.new(1, 0, 1, -50)
    tabContainer.BorderSizePixel = 0
    createUICorner(tabContainer, 10)

    local tabHolder = Instance.new("Frame")
    tabHolder.Name = "TabHolder"
    tabHolder.Parent = tabContainer
    tabHolder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabHolder.Position = UDim2.new(0, 0, 0, 0)
    tabHolder.Size = UDim2.new(0.2, 0, 1, 0)
    tabHolder.BorderSizePixel = 0
    createUICorner(tabHolder, 10)

    local tabContent = Instance.new("Frame")
    tabContent.Name = "TabContent"
    tabContent.Parent = tabContainer
    tabContent.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    tabContent.Position = UDim2.new(0.2, 0, 0, 0)
    tabContent.Size = UDim2.new(0.8, 0, 1, 0)
    tabContent.BorderSizePixel = 0
    createUICorner(tabContent, 10)

    local function createTabButton(name)
        local tabButton = Instance.new("TextButton")
        tabButton.Name = name .. "Tab"
        tabButton.Parent = tabHolder
        tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        tabButton.Size = UDim2.new(1, 0, 0, 50)
        tabButton.Font = Enum.Font.Gotham
        tabButton.Text = name
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.TextSize = 18
        tabButton.TextXAlignment = Enum.TextXAlignment.Center
        tabButton.BorderSizePixel = 0
        createUICorner(tabButton, 10)

        tabButton.MouseEnter:Connect(function()
            tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end)

        tabButton.MouseLeave:Connect(function()
            tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end)

        return tabButton
    end

    local function createTabContent()
        local content = Instance.new("ScrollingFrame")
        content.Name = "TabContentFrame"
        content.Parent = tabContent
        content.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        content.Position = UDim2.new(0, 0, 0, 0)
        content.Size = UDim2.new(1, 0, 1, 0)
        content.CanvasSize = UDim2.new(0, 0, 2, 0)
        content.ScrollBarThickness = 6
        content.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
        content.BorderSizePixel = 0
        createUICorner(content, 10)

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 10)
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
        button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        button.Size = UDim2.new(0, 200, 0, 50)
        button.Font = Enum.Font.Gotham
        button.Text = text
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextSize = 18
        button.BorderSizePixel = 0
        createUICorner(button, 10)

        button.MouseEnter:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end)

        button.MouseLeave:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end)

        button.MouseButton1Click:Connect(function()
            callback()
        end)
    end

    function UILibrary:CreateLabel(parent, text)
        local label = Instance.new("TextLabel")
        label.Parent = parent
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(0, 200, 0, 50)
        label.Font = Enum.Font.Gotham
        label.Text = text
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 18
        label.TextXAlignment = Enum.TextXAlignment.Left
    end

    function UILibrary:CreateTextBox(parent, placeholderText, callback)
        local textBox = Instance.new("TextBox")
        textBox.Parent = parent
        textBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        textBox.Size = UDim2.new(0, 200, 0, 50)
        textBox.Font = Enum.Font.Gotham
        textBox.PlaceholderText = placeholderText
        textBox.Text = ""
        textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        textBox.TextSize = 18
        textBox.BorderSizePixel = 0
        createUICorner(textBox, 10)

        textBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                callback(textBox.Text)
            end
        end)
    end

    return {
        MainFrame = mainFrame,
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
        end
    }
end

return UILibrary
