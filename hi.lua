local UILibrary = {}

-- Main UI Library Module
function UILibrary:CreateWindow(title)
    local windowInstance = {}

    -- Instances for Window
    local Confirmation = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Button = Instance.new("TextButton")

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
    MainFrame.Size = UDim2.new(0, 300, 0, 200)
    MainFrame.Active = true
    MainFrame.Draggable = true

    print("Setting properties for Title")
    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundColor3 = Color3.fromRGB(45, 45, 48)
    Title.Size = UDim2.new(1, 0, 0.2, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 24.000
    Title.TextXAlignment = Enum.TextXAlignment.Center

    print("Setting properties for Button")
    Button.Name = "Button"
    Button.Parent = MainFrame
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Button.Size = UDim2.new(0.8, 0, 0.2, 0)
    Button.Position = UDim2.new(0.1, 0, 0.6, 0)
    Button.Font = Enum.Font.GothamBold
    Button.Text = "Click Me"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 24.000

    -- Button functionality
    Button.MouseButton1Click:Connect(function()
        print("Button clicked!")
    end)

    return windowInstance
end

return UILibrary
