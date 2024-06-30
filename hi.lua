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

    -- Close and Minimize Functionality
    CloseButton.MouseButton1Click:Connect(function()
        print("Close button clicked")
        Confirmation:Destroy()
    end)

    MinimizeButton.MouseButton1Click:Connect(function()
        print("Minimize button clicked")
        MainFrame.Visible = not MainFrame.Visible
    end)

    return windowInstance
end

return UILibrary
