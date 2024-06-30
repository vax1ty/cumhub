local UILibrary = {}

-- Main UI Library Module
function UILibrary:CreateWindow(title)
    local windowInstance = {}

    -- Instances for Window
    local Confirmation = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local CloseButton = Instance.new("TextButton")
    local MinimizeButton = Instance.new("TextButton")
    local Title = Instance.new("TextLabel")
    local TabHolder = Instance.new("Frame")
    local ContentHolder = Instance.new("Frame")

    -- Properties for Window
    print("Setting properties for Confirmation")
    Confirmation.Name = "Confirmation"
    Confirmation.Parent = game.CoreGui

    print("Setting properties for MainFrame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Confirmation
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 602, 0, 673)
    MainFrame.Active = true
    MainFrame.Draggable = true

    print("Setting properties for TopBar")
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(45, 45, 48)
    TopBar.Size = UDim2.new(1, 0, 0, 50)

    print("Setting properties for CloseButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TopBar
    CloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(1, -45, 0, 5)
    CloseButton.Size = UDim2.new(0, 40, 0, 40)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 24.000

    print("Setting properties for MinimizeButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = TopBar
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Position = UDim2.new(1, -90, 0, 5)
    MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 24.000

    print("Setting properties for Title")
    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundColor3 = Color3.fromRGB(45, 45, 48)
    Title.BackgroundTransparency = 1.000
    Title.Size = UDim2.new(0.8, 0, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 24.000
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Position = UDim2.new(0.05, 0, 0, 0)

    print("Setting properties for TabHolder")
    TabHolder.Name = "TabHolder"
    TabHolder.Parent = MainFrame
    TabHolder.BackgroundColor3 = Color3.fromRGB(45, 45, 48)
    TabHolder.Position = UDim2.new(0, 0, 0.1, 0)
    TabHolder.Size = UDim2.new(1, 0, 0.1, 0)

    print("Setting properties for ContentHolder")
    ContentHolder.Name = "ContentHolder"
    ContentHolder.Parent = MainFrame
    ContentHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ContentHolder.Position = UDim2.new(0, 0, 0.2, 0)
    ContentHolder.Size = UDim2.new(1, 0, 0.8, 0)

    -- Close and Minimize Functionality
    CloseButton.MouseButton1Click:Connect(function()
        print("Close button clicked")
        Confirmation:Destroy()
    end)

    MinimizeButton.MouseButton1Click:Connect(function()
        print("Minimize button clicked")
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- Function to Add Tabs
    function windowInstance:AddTab(tabName)
        local tab = {}
        local TabButton = Instance.new("TextButton")
        local TabContent = Instance.new("Frame")

        -- Properties for Tab Button
        print("Creating Tab Button for tab:", tabName)
        TabButton.Name = tabName
        TabButton.Parent = TabHolder
        TabButton.BackgroundColor3 = Color3.fromRGB(48, 48, 53)
        TabButton.Size = UDim2.new(0, 100, 0, 30)
        TabButton.Font = Enum.Font.FredokaOne
        TabButton.Text = tabName
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 24.000

        -- Properties for Tab Content
        print("Creating Tab Content for tab:", tabName)
        TabContent.Name = tabName .. "_Content"
        TabContent.Parent = ContentHolder
        TabContent.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.Visible = false

        -- Show/Hide Tabs
        TabButton.MouseButton1Click:Connect(function()
            print("TabButton Clicked:", tabName)
            for _, child in ipairs(ContentHolder:GetChildren()) do
                if child:IsA("Frame") then
                    child.Visible = false
                end
            end
            TabContent.Visible = true
        end)

        -- Default to showing the first tab
        if #ContentHolder:GetChildren() == 1 then
            TabContent.Visible = true
        end

        -- Function to Add Buttons
        function tab:CreateButton(text, callback)
            print("Creating Button with text:", text)
            local Button = Instance.new("TextButton")

            -- Properties for Button
            Button.Name = "Button"
            Button.Parent = TabContent
            Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Button.Size = UDim2.new(1, 0, 0, 40)
            Button.Font = Enum.Font.FredokaOne
            Button.Text = text
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 24.000

            Button.MouseButton1Click:Connect(callback)
        end

        return tab
    end

    return windowInstance
end

return UILibrary
