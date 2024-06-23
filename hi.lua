-- CumhubLib UI Library
CumhubLib = {}

-- Utility function to make UI elements draggable
local function makeDraggable(topBarObject, object)
    local UserInputService = game:GetService("UserInputService")
    local dragging, dragInput, dragStart, startPos

    topBarObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = object.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    topBarObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            object.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Function to create a new window
function CumhubLib:CreateWindow(title)
    local window = {}
    local HttpService = game:GetService("HttpService")
    local defaultColors = {
        backgroundColor = Color3.fromRGB(35, 35, 35),
        buttonColor = Color3.fromRGB(60, 60, 60),
        textColor = Color3.fromRGB(255, 255, 255),
        accentColor = Color3.fromRGB(0, 170, 255),
        hoverColor = Color3.fromRGB(80, 80, 80),
    }

    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("ScrollingFrame")
    local UICorner = Instance.new("UICorner")
    local TitleLabel = Instance.new("TextLabel")
    local Sidebar = Instance.new("ScrollingFrame")
    local UIListLayoutSidebar = Instance.new("UIListLayout")
    local ContentFrame = Instance.new("Frame")
    local UIPadding = Instance.new("UIPadding")
    local UIListLayout = Instance.new("UIListLayout")
    local TopBar = Instance.new("Frame")

    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false

    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = defaultColors.backgroundColor
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.ClipsDescendants = true

    UICorner.CornerRadius = UDim.new(0, 15)
    UICorner.Parent = MainFrame

    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TopBar.Size = UDim2.new(1, 0, 0, 40)

    makeDraggable(TopBar, MainFrame)

    TitleLabel.Parent = TopBar
    TitleLabel.BackgroundTransparency = 1.000
    TitleLabel.Position = UDim2.new(0.5, -50, 0, 0)
    TitleLabel.Size = UDim2.new(0, 100, 1, 0)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = defaultColors.textColor
    TitleLabel.TextSize = 28.000
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Center

    Sidebar.Parent = MainFrame
    Sidebar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Sidebar.Position = UDim2.new(0, 10, 0, 50)
    Sidebar.Size = UDim2.new(0, 140, 1, -60)
    Sidebar.CanvasSize = UDim2.new(0, 0, 2, 0)
    Sidebar.ScrollBarThickness = 8

    local sidebarCorner = Instance.new("UICorner")
    sidebarCorner.CornerRadius = UDim.new(0, 10)
    sidebarCorner.Parent = Sidebar

    UIListLayoutSidebar.Parent = Sidebar
    UIListLayoutSidebar.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayoutSidebar.Padding = UDim.new(0, 10)

    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    ContentFrame.Position = UDim2.new(0, 160, 0, 50)
    ContentFrame.Size = UDim2.new(1, -170, 1, -60)
    ContentFrame.ClipsDescendants = true

    UIPadding.Parent = ContentFrame
    UIPadding.PaddingBottom = UDim.new(0, 10)
    UIPadding.PaddingLeft = UDim.new(0, 10)
    UIPadding.PaddingRight = UDim.new(0, 10)
    UIPadding.PaddingTop = UDim.new(0, 10)

    UIListLayout.Parent = ContentFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)

    function window:AddTab(text, iconId)
        local tab = {}
        local TabButton = Instance.new("TextButton")
        local UICornerSidebar = Instance.new("UICorner")
        local TabContentFrame = Instance.new("Frame")

        TabButton.Parent = Sidebar
        TabButton.BackgroundColor3 = defaultColors.buttonColor
        TabButton.Size = UDim2.new(1, 0, 0, 40)
        TabButton.Font = Enum.Font.GothamBold
        TabButton.Text = text
        TabButton.TextColor3 = defaultColors.textColor
        TabButton.TextSize = 18.000
        TabButton.AutoButtonColor = true

        UICornerSidebar.CornerRadius = UDim.new(0, 10)
        UICornerSidebar.Parent = TabButton

        TabContentFrame.Parent = ContentFrame
        TabContentFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabContentFrame.Size = UDim2.new(1, 0, 1, 0)
        TabContentFrame.Visible = false

        local UIListLayoutTab = Instance.new("UIListLayout")
        UIListLayoutTab.Parent = TabContentFrame
        UIListLayoutTab.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayoutTab.Padding = UDim.new(0, 10)

        TabButton.MouseEnter:Connect(function()
            TabButton.BackgroundColor3 = defaultColors.hoverColor
        end)

        TabButton.MouseLeave:Connect(function()
            TabButton.BackgroundColor3 = defaultColors.buttonColor
        end)

        TabButton.MouseButton1Click:Connect(function()
            for _, frame in pairs(ContentFrame:GetChildren()) do
                if frame:IsA("Frame") then
                    frame.Visible = false
                end
            end
            TabContentFrame.Visible = true
        end)

        function tab:AddButton(text, iconId, callback)
            local Button = Instance.new("TextButton")
            local UICorner_3 = Instance.new("UICorner")

            Button.Parent = TabContentFrame
            Button.BackgroundColor3 = defaultColors.buttonColor
            Button.Size = UDim2.new(1, -20, 0, 40)
            Button.Font = Enum.Font.GothamBold
            Button.Text = text
            Button.TextColor3 = defaultColors.textColor
            Button.TextSize = 18.000

            UICorner_3.CornerRadius = UDim.new(0, 10)
            UICorner_3.Parent = Button

            if iconId then
                local Icon = Instance.new("ImageLabel")
                Icon.Parent = Button
                Icon.Size = UDim2.new(0, 20, 0, 20)
                Icon.Position = UDim2.new(0, -30, 0.5, -10)
                Icon.Image = "rbxassetid://" .. iconId
                Icon.BackgroundTransparency = 1
            end

            Button.MouseEnter:Connect(function()
                Button.BackgroundColor3 = defaultColors.hoverColor
            end)

            Button.MouseLeave:Connect(function()
                Button.BackgroundColor3 = defaultColors.buttonColor
            end)

            Button.MouseButton1Click:Connect(function()
                if callback then
                    callback()
                end
            end)
        end

        function tab:AddToggle(text, iconId, default, callback)
            local ToggleFrame = Instance.new("Frame")
            local ToggleButton = Instance.new("TextButton")
            local ToggleText = Instance.new("TextLabel")
            local UICorner_4 = Instance.new("UICorner")
            local UICorner_5 = Instance.new("UICorner")

            ToggleFrame.Parent = TabContentFrame
            ToggleFrame.BackgroundColor3 = defaultColors.buttonColor
            ToggleFrame.Size = UDim2.new(1, -20, 0, 50)

            UICorner_4.CornerRadius = UDim.new(0, 10)
            UICorner_4.Parent = ToggleFrame

           

 ToggleText.Parent = ToggleFrame
            ToggleText.BackgroundTransparency = 1.000
            ToggleText.Position = UDim2.new(0, 10, 0, 0)
            ToggleText.Size = UDim2.new(0.8, -10, 1, 0)
            ToggleText.Font = Enum.Font.GothamBold
            ToggleText.Text = text
            ToggleText.TextColor3 = defaultColors.textColor
            ToggleText.TextSize = 18.000
            ToggleText.TextXAlignment = Enum.TextXAlignment.Left

            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundColor3 = default and defaultColors.accentColor or Color3.fromRGB(80, 80, 80)
            ToggleButton.Size = UDim2.new(0.2, -10, 0.8, 0)
            ToggleButton.Position = UDim2.new(0.8, 0, 0.1, 0)
            ToggleButton.Font = Enum.Font.GothamBold
            ToggleButton.Text = ""
            ToggleButton.TextColor3 = defaultColors.textColor
            ToggleButton.TextSize = 18.000

            UICorner_5.CornerRadius = UDim.new(0, 10)
            UICorner_5.Parent = ToggleButton

            if iconId then
                local Icon = Instance.new("ImageLabel")
                Icon.Parent = ToggleButton
                Icon.Size = UDim2.new(0, 20, 0, 20)
                Icon.Position = UDim2.new(0, -30, 0.5, -10)
                Icon.Image = "rbxassetid://" .. iconId
                Icon.BackgroundTransparency = 1
            end

            local switched = default

            local function handleClick()
                switched = not switched
                ToggleButton.BackgroundColor3 = switched and defaultColors.accentColor or Color3.fromRGB(80, 80, 80)
                if callback then
                    callback(switched)
                end
            end

            ToggleButton.MouseButton1Click:Connect(handleClick)
        end

        function tab:AddDropdown(text, items, iconId, callback)
            local DropdownFrame = Instance.new("Frame")
            local DropdownText = Instance.new("TextLabel")
            local DropdownButton = Instance.new("TextButton")
            local UICorner_8 = Instance.new("UICorner")
            local DropdownItems = Instance.new("Frame")
            local UIPadding_2 = Instance.new("UIPadding")
            local UICorner_9 = Instance.new("UICorner")

            DropdownFrame.Parent = TabContentFrame
            DropdownFrame.BackgroundColor3 = defaultColors.buttonColor
            DropdownFrame.Size = UDim2.new(1, -20, 0, 40)
            DropdownFrame.LayoutOrder = #TabContentFrame:GetChildren()

            DropdownText.Parent = DropdownFrame
            DropdownText.BackgroundTransparency = 1.000
            DropdownText.Position = UDim2.new(0, 10, 0, 0)
            DropdownText.Size = UDim2.new(0.5, -10, 1, 0)
            DropdownText.Font = Enum.Font.GothamBold
            DropdownText.Text = text
            DropdownText.TextColor3 = defaultColors.textColor
            DropdownText.TextSize = 18.000
            DropdownText.TextXAlignment = Enum.TextXAlignment.Left

            DropdownButton.Parent = DropdownFrame
            DropdownButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            DropdownButton.Position = UDim2.new(0.5, 10, 0.1, 0)
            DropdownButton.Size = UDim2.new(0.4, 0, 0.8, 0)
            DropdownButton.Font = Enum.Font.GothamBold
            DropdownButton.Text = "Select"
            DropdownButton.TextColor3 = defaultColors.textColor
            DropdownButton.TextSize = 18.000

            UICorner_8.CornerRadius = UDim.new(0, 10)
            UICorner_8.Parent = DropdownButton

            DropdownItems.Parent = DropdownFrame
            DropdownItems.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            DropdownItems.Position = UDim2.new(0, 0, 1, 0)
            DropdownItems.Size = UDim2.new(1, 0, 0, 0)
            DropdownItems.Visible = false
            DropdownItems.ClipsDescendants = true
            DropdownItems.ZIndex = 2

            UIPadding_2.Parent = DropdownItems
            UIPadding_2.PaddingBottom = UDim.new(0, 5)
            UIPadding_2.PaddingLeft = UDim.new(0, 5)
            UIPadding_2.PaddingRight = UDim.new(0, 5)
            UIPadding_2.PaddingTop = UDim.new(0, 5)

            UICorner_9.CornerRadius = UDim.new(0, 10)
            UICorner_9.Parent = DropdownItems

            local function updateDropdown()
                DropdownItems:ClearAllChildren()
                local itemCount = #items
                DropdownItems.Size = UDim2.new(1, 0, 0, itemCount * 30)
                for i, item in ipairs(items) do
                    local ItemButton = Instance.new("TextButton")
                    local UICorner_10 = Instance.new("UICorner")

                    ItemButton.Parent = DropdownItems
                    ItemButton.BackgroundColor3 = defaultColors.buttonColor
                    ItemButton.Size = UDim2.new(1, -10, 0, 30)
                    ItemButton.Position = UDim2.new(0, 5, 0, (i - 1) * 30)
                    ItemButton.Font = Enum.Font.GothamBold
                    ItemButton.Text = item
                    ItemButton.TextColor3 = defaultColors.textColor
                    ItemButton.TextSize = 18.000

                    UICorner_10.CornerRadius = UDim.new(0, 10)
                    UICorner_10.Parent = ItemButton

                    ItemButton.MouseButton1Click:Connect(function()
                        DropdownButton.Text = item
                        DropdownItems.Visible = false
                        if callback then
                            callback(item)
                        end
                    end)
                end
            end

            updateDropdown()

            DropdownButton.MouseButton1Click:Connect(function()
                DropdownItems.Visible = not DropdownItems.Visible
            end)

            if iconId then
                local Icon = Instance.new("ImageLabel")
                Icon.Parent = DropdownButton
                Icon.Size = UDim2.new(0, 20, 0, 20)
                Icon.Position = UDim2.new(0, -30, 0.5, -10)
                Icon.Image = "rbxassetid://" .. iconId
                Icon.BackgroundTransparency = 1
            end
        end

        function tab:AddColorPicker(text, iconId, defaultColor, callback)
            local ColorPickerFrame = Instance.new("Frame")
            local ColorPickerButton = Instance.new("TextButton")
            local ColorPickerText = Instance.new("TextLabel")
            local UICorner_4 = Instance.new("UICorner")
            local UICorner_5 = Instance.new("UICorner")

            ColorPickerFrame.Parent = TabContentFrame
            ColorPickerFrame.BackgroundColor3 = defaultColors.buttonColor
            ColorPickerFrame.Size = UDim2.new(1, -20, 0, 50)
            ColorPickerFrame.LayoutOrder = #TabContentFrame:GetChildren()

            UICorner_4.CornerRadius = UDim.new(0, 10)
            UICorner_4.Parent = ColorPickerFrame

            ColorPickerText.Parent = ColorPickerFrame
            ColorPickerText.BackgroundTransparency = 1.000
            ColorPickerText.Position = UDim2.new(0, 10, 0, 0)
            ColorPickerText.Size = UDim2.new(0.8, -10, 1, 0)
            ColorPickerText.Font = Enum.Font.GothamBold
            ColorPickerText.Text = text
            ColorPickerText.TextColor3 = defaultColors.textColor
            ColorPickerText.TextSize = 18.000
            ColorPickerText.TextXAlignment = Enum.TextXAlignment.Left

            ColorPickerButton.Parent = ColorPickerFrame
            ColorPickerButton.BackgroundColor3 = defaultColor
            ColorPickerButton.Size = UDim2.new(0.2, -10, 0.8, 0)
            ColorPickerButton.Position = UDim2.new(0.8, 0, 0.1, 0)
            ColorPickerButton.Font = Enum.Font.GothamBold
            ColorPickerButton.Text = ""
            ColorPickerButton.TextColor3 = defaultColors.textColor
            ColorPickerButton.TextSize = 18.000

            UICorner_5.CornerRadius = UDim.new(0, 10)
            UICorner_5.Parent = ColorPickerButton

            local function handleColorChange(newColor)
                ColorPickerButton.BackgroundColor3 = newColor
                if callback then
                    callback(newColor)
                end
            end

            ColorPickerButton.MouseButton1Click:Connect(function()
                -- Create the color picker UI
                local ColorPickerUI = Instance.new("Frame")
                local ColorPickerCloseButton = Instance.new("TextButton")
                local ColorPickerTitle = Instance.new("TextLabel")
                local UICornerCP = Instance.new("UICorner")

                ColorPickerUI.Parent = ScreenGui
                ColorPickerUI.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                ColorPickerUI.Position = UDim2.new(

0.5, -150, 0.5, -100)
                ColorPickerUI.Size = UDim2.new(0, 300, 0, 200)

                UICornerCP.CornerRadius = UDim.new(0, 15)
                UICornerCP.Parent = ColorPickerUI

                ColorPickerTitle.Parent = ColorPickerUI
                ColorPickerTitle.BackgroundTransparency = 1.000
                ColorPickerTitle.Position = UDim2.new(0.5, -75, 0, 10)
                ColorPickerTitle.Size = UDim2.new(0, 150, 0, 20)
                ColorPickerTitle.Font = Enum.Font.GothamBold
                ColorPickerTitle.Text = "Select Color"
                ColorPickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                ColorPickerTitle.TextSize = 18.000
                ColorPickerTitle.TextXAlignment = Enum.TextXAlignment.Center

                ColorPickerCloseButton.Parent = ColorPickerUI
                ColorPickerCloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                ColorPickerCloseButton.Position = UDim2.new(1, -30, 0, 10)
                ColorPickerCloseButton.Size = UDim2.new(0, 20, 0, 20)
                ColorPickerCloseButton.Font = Enum.Font.GothamBold
                ColorPickerCloseButton.Text = "X"
                ColorPickerCloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                ColorPickerCloseButton.TextSize = 14.000

                local function createColorSlider(labelText, position, defaultValue, onChange)
                    local Label = Instance.new("TextLabel")
                    local Slider = Instance.new("Frame")
                    local Fill = Instance.new("Frame")
                    local Handle = Instance.new("Frame")
                    local UICornerS = Instance.new("UICorner")
                    local UICornerF = Instance.new("UICorner")

                    Label.Parent = ColorPickerUI
                    Label.BackgroundTransparency = 1.000
                    Label.Position = UDim2.new(0, 10, 0, position)
                    Label.Size = UDim2.new(0, 20, 0, 20)
                    Label.Font = Enum.Font.GothamBold
                    Label.Text = labelText
                    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Label.TextSize = 18.000
                    Label.TextXAlignment = Enum.TextXAlignment.Center

                    Slider.Parent = ColorPickerUI
                    Slider.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    Slider.Position = UDim2.new(0, 40, 0, position)
                    Slider.Size = UDim2.new(1, -60, 0, 20)

                    UICornerS.CornerRadius = UDim.new(0, 10)
                    UICornerS.Parent = Slider

                    Fill.Parent = Slider
                    Fill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    Fill.Size = UDim2.new(defaultValue / 255, 0, 1, 0)

                    UICornerF.CornerRadius = UDim.new(0, 10)
                    UICornerF.Parent = Fill

                    Handle.Parent = Slider
                    Handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Handle.Size = UDim2.new(0, 10, 0, 20)
                    Handle.Position = UDim2.new(defaultValue / 255, -5, 0, 0)

                    local dragging = false

                    local function updateSlider(input)
                        local delta = input.Position.X - Slider.AbsolutePosition.X
                        local percent = math.clamp(delta / Slider.AbsoluteSize.X, 0, 1)
                        Fill.Size = UDim2.new(percent, 0, 1, 0)
                        Handle.Position = UDim2.new(percent, -5, 0, 0)
                        local value = math.floor(255 * percent)
                        if onChange then
                            onChange(value)
                        end
                    end

                    Handle.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            dragging = true
                        end
                    end)

                    Handle.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            dragging = false
                        end
                    end)

                    game:GetService("UserInputService").InputChanged:Connect(function(input)
                        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType.Touch) then
                            updateSlider(input)
                        end
                    end)

                    return Slider, Fill, Handle
                end

                local selectedColor = defaultColor

                local RSlider, RFill, RHandle = createColorSlider("R", 40, selectedColor.R * 255, function(value)
                    selectedColor = Color3.fromRGB(value, selectedColor.G * 255, selectedColor.B * 255)
                    handleColorChange(selectedColor)
                end)

                local GSlider, GFill, GHandle = createColorSlider("G", 80, selectedColor.G * 255, function(value)
                    selectedColor = Color3.fromRGB(selectedColor.R * 255, value, selectedColor.B * 255)
                    handleColorChange(selectedColor)
                end)

                local BSlider, BFill, BHandle = createColorSlider("B", 120, selectedColor.B * 255, function(value)
                    selectedColor = Color3.fromRGB(selectedColor.R * 255, selectedColor.G * 255, value)
                    handleColorChange(selectedColor)
                end)

                ColorPickerCloseButton.MouseButton1Click:Connect(function()
                    ColorPickerUI:Destroy()
                end)
            end)

            if iconId then
                local Icon = Instance.new("ImageLabel")
                Icon.Parent = ColorPickerButton
                Icon.Size = UDim2.new(0, 20, 0, 20)
                Icon.Position = UDim2.new(0, -30, 0.5, -10)
                Icon.Image = "rbxassetid://" .. iconId
                Icon.BackgroundTransparency = 1
            end
        end

        function tab:AddTextInput(text, iconId, default, callback)
            local TextInputFrame = Instance.new("Frame")
            local TextInput = Instance.new("TextBox")
            local TextInputLabel = Instance.new("TextLabel")
            local UICorner_4 = Instance.new("UICorner")
            local UICorner_5 = Instance.new("UICorner")

            TextInputFrame.Parent = TabContentFrame
            TextInputFrame.BackgroundColor3 = defaultColors.buttonColor
            TextInputFrame.Size = UDim2.new(1, -20, 0, 50)
            TextInputFrame.LayoutOrder = #TabContentFrame:GetChildren()

            UICorner_4.CornerRadius = UDim.new(0, 10)
            UICorner_4.Parent = TextInputFrame

            TextInputLabel.Parent = TextInputFrame
            TextInputLabel.BackgroundTransparency = 1.000
            TextInputLabel.Position = UDim2.new(0, 10, 0, 0)
            TextInputLabel.Size = UDim2.new(0.8, -10, 1, 0)
            TextInputLabel.Font = Enum.Font.GothamBold
            TextInputLabel.Text = text
            TextInputLabel.TextColor3 = defaultColors.textColor
            TextInputLabel.TextSize = 18.000
            TextInputLabel.TextXAlignment = Enum.TextXAlignment.Left

            TextInput.Parent = TextInputFrame
            TextInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            TextInput.Position = UDim2.new(0.8, 0, 0.1, 0)
            TextInput.Size = UDim2.new(0.2, -10, 0.8, 0)
            TextInput.Font = Enum.Font.GothamBold
            TextInput.PlaceholderText = default
            TextInput.Text = ""
            TextInput.TextColor3 = defaultColors.textColor
            TextInput.TextSize = 18.000

            UICorner_5.CornerRadius = UDim.new(0, 10)
            UICorner_5.Parent = TextInput

            TextInput.FocusLost:Connect(function(enterPressed)
                if enterPressed and callback then
                    callback(TextInput.Text)
                end
            end)

            if iconId then
                local Icon = Instance.new("ImageLabel")
                Icon.Parent = TextInput
                Icon.Size = UDim2.new(0, 20, 0, 20)
                Icon.Position = UDim2.new(0, -30, 0.5, -10)
                Icon.Image = "rbxassetid://" .. iconId
                Icon.BackgroundTransparency = 1
            end
        end

        function tab:AddSlider(text, min, max, default, iconId, callback)
            local SliderFrame = Instance.new("Frame")
            local SliderText = Instance.new("TextLabel")
            local SliderBar = Instance.new("Frame")
            local SliderFill = Instance.new("Frame")
            local SliderHandle = Instance.new("Frame")
            local UICorner_6 = Instance.new("UICorner")
            local UICorner_7 = Instance.new("UICorner")
            local UICorner_8 =

 Instance.new("UICorner")
            local UICorner_9 = Instance.new("UICorner")

            SliderFrame.Parent = TabContentFrame
            SliderFrame.BackgroundColor3 = defaultColors.buttonColor
            SliderFrame.Size = UDim2.new(1, -20, 0, 60)
            SliderFrame.LayoutOrder = #TabContentFrame:GetChildren()

            SliderText.Parent = SliderFrame
            SliderText.BackgroundTransparency = 1.000
            SliderText.Position = UDim2.new(0, 10, 0, 5)
            SliderText.Size = UDim2.new(1, -20, 0, 20)
            SliderText.Font = Enum.Font.GothamBold
            SliderText.Text = text
            SliderText.TextColor3 = defaultColors.textColor
            SliderText.TextSize = 18.000
            SliderText.TextXAlignment = Enum.TextXAlignment.Left

            SliderBar.Parent = SliderFrame
            SliderBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            SliderBar.Position = UDim2.new(0, 10, 0, 30)
            SliderBar.Size = UDim2.new(1, -20, 0, 10)

            UICorner_6.CornerRadius = UDim.new(0, 5)
            UICorner_6.Parent = SliderBar

            SliderFill.Parent = SliderBar
            SliderFill.BackgroundColor3 = defaultColors.accentColor
            SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)

            UICorner_9.CornerRadius = UDim.new(0, 5)
            UICorner_9.Parent = SliderFill

            SliderHandle.Parent = SliderBar
            SliderHandle.BackgroundColor3 = defaultColors.accentColor
            SliderHandle.Size = UDim2.new(0, 20, 0, 20)
            SliderHandle.Position = UDim2.new((default - min) / (max - min), -10, -0.5, 0)

            UICorner_7.CornerRadius = UDim.new(1, 0)
            UICorner_7.Parent = SliderHandle

            -- Create a TextLabel to display the slider value
            local SliderValueLabel = Instance.new("TextLabel")
            SliderValueLabel.Parent = SliderFrame
            SliderValueLabel.BackgroundTransparency = 1
            SliderValueLabel.Position = UDim2.new(1, -70, 0, 5) -- Adjusted position for top right of the slider
            SliderValueLabel.Size = UDim2.new(0, 60, 0, 20)
            SliderValueLabel.Font = Enum.Font.GothamBold
            SliderValueLabel.TextColor3 = defaultColors.textColor
            SliderValueLabel.TextSize = 18
            SliderValueLabel.Text = tostring(default)  -- Default value

            local dragging = false

            local function updateSlider(input)
                local delta = input.Position.X - SliderBar.AbsolutePosition.X
                local percent = math.clamp(delta / SliderBar.AbsoluteSize.X, 0, 1)
                SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                SliderHandle.Position = UDim2.new(percent, -10, -0.5, 0)
                local value = math.floor(min + ((max - min) * percent))
                SliderValueLabel.Text = tostring(value)
                if callback then
                    callback(value)
                end
            end

            SliderHandle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                end
            end)

            SliderHandle.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            game:GetService("UserInputService").InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType.Touch) then
                    updateSlider(input)
                end
            end)

            if iconId then
                local Icon = Instance.new("ImageLabel")
                Icon.Parent = SliderFrame
                Icon.Size = UDim2.new(0, 20, 0, 20)
                Icon.Position = UDim2.new(0, -30, 0.5, -10)
                Icon.Image = "rbxassetid://" .. iconId
                Icon.BackgroundTransparency = 1
            end
        end

        function tab:AddImage(imageId, imageSize)
            local ImageLabel = Instance.new("ImageLabel")

            ImageLabel.Parent = TabContentFrame
            ImageLabel.Size = UDim2.new(0, imageSize.X, 0, imageSize.Y)
            ImageLabel.Image = "rbxassetid://" .. imageId
            ImageLabel.BackgroundTransparency = 1
        end

        function tab:AddCheckbox(text, iconId, default, callback)
            local CheckboxFrame = Instance.new("Frame")
            local CheckboxButton = Instance.new("TextButton")
            local CheckboxText = Instance.new("TextLabel")
            local UICorner_4 = Instance.new("UICorner")
            local UICorner_5 = Instance.new("UICorner")

            CheckboxFrame.Parent = TabContentFrame
            CheckboxFrame.BackgroundColor3 = defaultColors.buttonColor
            CheckboxFrame.Size = UDim2.new(1, -20, 0, 50)
            CheckboxFrame.LayoutOrder = #TabContentFrame:GetChildren()

            UICorner_4.CornerRadius = UDim.new(0, 10)
            UICorner_4.Parent = CheckboxFrame

            CheckboxText.Parent = CheckboxFrame
            CheckboxText.BackgroundTransparency = 1.000
            CheckboxText.Position = UDim2.new(0, 10, 0, 0)
            CheckboxText.Size = UDim2.new(0.8, -10, 1, 0)
            CheckboxText.Font = Enum.Font.GothamBold
            CheckboxText.Text = text
            CheckboxText.TextColor3 = defaultColors.textColor
            CheckboxText.TextSize = 18.000
            CheckboxText.TextXAlignment = Enum.TextXAlignment.Left

            CheckboxButton.Parent = CheckboxFrame
            CheckboxButton.BackgroundColor3 = default and defaultColors.accentColor or Color3.fromRGB(80, 80, 80)
            CheckboxButton.Size = UDim2.new(0.2, -10, 0.8, 0)
            CheckboxButton.Position = UDim2.new(0.8, 0, 0.1, 0)
            CheckboxButton.Font = Enum.Font.GothamBold
            CheckboxButton.Text = ""
            CheckboxButton.TextColor3 = defaultColors.textColor
            CheckboxButton.TextSize = 18.000

            UICorner_5.CornerRadius = UDim.new(0, 10)
            UICorner_5.Parent = CheckboxButton

            local checked = default

            local function handleClick()
                checked = not checked
                CheckboxButton.BackgroundColor3 = checked and defaultColors.accentColor or Color3.fromRGB(80, 80, 80)
                if callback then
                    callback(checked)
                end
            end

            CheckboxButton.MouseButton1Click:Connect(handleClick)

            if iconId then
                local Icon = Instance.new("ImageLabel")
                Icon.Parent = CheckboxButton
                Icon.Size = UDim2.new(0, 20, 0, 20)
                Icon.Position = UDim2.new(0, -30, 0.5, -10)
                Icon.Image = "rbxassetid://" .. iconId
                Icon.BackgroundTransparency = 1
            end
        end

        function tab:AddRadioButton(text, options, iconId, callback)
            local RadioButtonFrame = Instance.new("Frame")
            local RadioButtonText = Instance.new("TextLabel")
            local UICorner_4 = Instance.new("UICorner")

            RadioButtonFrame.Parent = TabContentFrame
            RadioButtonFrame.BackgroundColor3 = defaultColors.buttonColor
            RadioButtonFrame.Size = UDim2.new(1, -20, 0, 50)
            RadioButtonFrame.LayoutOrder = #TabContentFrame:GetChildren()

            UICorner_4.CornerRadius = UDim.new(0, 10)
            UICorner_4.Parent = RadioButtonFrame

            RadioButtonText.Parent = RadioButtonFrame
            RadioButtonText.BackgroundTransparency = 1.000
            RadioButtonText.Position = UDim2.new(0, 10, 0, 0)
            RadioButtonText.Size = UDim2.new(0.8, -10, 1, 0)
            RadioButtonText.Font = Enum.Font.GothamBold
            RadioButtonText.Text = text
            RadioButtonText.TextColor3 = defaultColors.textColor
            RadioButtonText.TextSize = 18.000
            RadioButtonText.TextXAlignment = Enum.TextXAlignment.Left

            local selectedOption = options[1]

            local function updateRadioButtons()
                for i, option in ipairs(options) do
                    local OptionButton = Instance.new("TextButton")
                    local UICorner_5 = Instance.new("UICorner")

                    OptionButton.Parent = RadioButtonFrame
                    OptionButton.BackgroundColor3 = option == selectedOption and defaultColors.accentColor or Color3.fromRGB(80, 80, 80)
                    OptionButton.Size = UDim2.new(

1, -20, 0, 30)
                    OptionButton.Position = UDim2.new(0, 10, 0, (i - 1) * 30 + 20)
                    OptionButton.Font = Enum.Font.GothamBold
                    OptionButton.Text = option
                    OptionButton.TextColor3 = defaultColors.textColor
                    OptionButton.TextSize = 18.000

                    UICorner_5.CornerRadius = UDim.new(0, 10)
                    UICorner_5.Parent = OptionButton

                    OptionButton.MouseButton1Click:Connect(function()
                        selectedOption = option
                        updateRadioButtons()
                        if callback then
                            callback(option)
                        end
                    end)
                end
            end

            updateRadioButtons()

            if iconId then
                local Icon = Instance.new("ImageLabel")
                Icon.Parent = RadioButtonFrame
                Icon.Size = UDim2.new(0, 20, 0, 20)
                Icon.Position = UDim2.new(0, -30, 0.5, -10)
                Icon.Image = "rbxassetid://" .. iconId
                Icon.BackgroundTransparency = 1
            end
        end

        function tab:AddTextLabel(text, iconId)
            local TextLabel = Instance.new("TextLabel")

            TextLabel.Parent = TabContentFrame
            TextLabel.BackgroundTransparency = 1
            TextLabel.Position = UDim2.new(0, 10, 0, 0)
            TextLabel.Size = UDim2.new(1, -20, 0, 50)
            TextLabel.Font = Enum.Font.GothamBold
            TextLabel.Text = text
            TextLabel.TextColor3 = defaultColors.textColor
            TextLabel.TextSize = 18.000
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left

            if iconId then
                local Icon = Instance.new("ImageLabel")
                Icon.Parent = TextLabel
                Icon.Size = UDim2.new(0, 20, 0, 20)
                Icon.Position = UDim2.new(0, -30, 0.5, -10)
                Icon.Image = "rbxassetid://" .. iconId
                Icon.BackgroundTransparency = 1
            end
        end

        function tab:AddTooltip(element, text)
            local Tooltip = Instance.new("TextLabel")

            Tooltip.BackgroundTransparency = 1
            Tooltip.Position = UDim2.new(0, 0, 0, 0)
            Tooltip.Size = UDim2.new(0, 200, 0, 50)
            Tooltip.Font = Enum.Font.GothamBold
            Tooltip.Text = text
            Tooltip.TextColor3 = defaultColors.textColor
            Tooltip.TextSize = 18.000
            Tooltip.TextXAlignment = Enum.TextXAlignment.Center
            Tooltip.BackgroundTransparency = 0.5
            Tooltip.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Tooltip.Visible = false

            Tooltip.Parent = ScreenGui

            element.MouseEnter:Connect(function()
                Tooltip.Position = UDim2.new(0, element.AbsolutePosition.X + element.AbsoluteSize.X / 2 - Tooltip.Size.X.Offset / 2, 0, element.AbsolutePosition.Y - Tooltip.Size.Y.Offset)
                Tooltip.Visible = true
            end)

            element.MouseLeave:Connect(function()
                Tooltip.Visible = false
            end)
        end

        function tab:AddTabbedPanel(tabNames)
            local TabbedPanelFrame = Instance.new("Frame")
            local TabButtonsFrame = Instance.new("Frame")
            local ContentFrames = {}

            TabbedPanelFrame.Parent = TabContentFrame
            TabbedPanelFrame.BackgroundColor3 = defaultColors.buttonColor
            TabbedPanelFrame.Size = UDim2.new(1, -20, 0, 200)
            TabbedPanelFrame.LayoutOrder = #TabContentFrame:GetChildren()

            local UICornerTabbed = Instance.new("UICorner")
            UICornerTabbed.CornerRadius = UDim.new(0, 10)
            UICornerTabbed.Parent = TabbedPanelFrame

            TabButtonsFrame.Parent = TabbedPanelFrame
            TabButtonsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            TabButtonsFrame.Size = UDim2.new(1, 0, 0, 30)

            local UICornerTabButtons = Instance.new("UICorner")
            UICornerTabButtons.CornerRadius = UDim.new(0, 10)
            UICornerTabButtons.Parent = TabButtonsFrame

            for i, tabName in ipairs(tabNames) do
                local TabButton = Instance.new("TextButton")
                TabButton.Parent = TabButtonsFrame
                TabButton.BackgroundColor3 = defaultColors.buttonColor
                TabButton.Size = UDim2.new(1 / #tabNames, 0, 1, 0)
                TabButton.Position = UDim2.new((i - 1) / #tabNames, 0, 0, 0)
                TabButton.Font = Enum.Font.GothamBold
                TabButton.Text = tabName
                TabButton.TextColor3 = defaultColors.textColor
                TabButton.TextSize = 18.000

                local ContentFrame = Instance.new("Frame")
                ContentFrame.Parent = TabbedPanelFrame
                ContentFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                ContentFrame.Size = UDim2.new(1, 0, 1, -30)
                ContentFrame.Position = UDim2.new(0, 0, 0, 30)
                ContentFrame.Visible = false

                local UIListLayoutTabbedContent = Instance.new("UIListLayout")
                UIListLayoutTabbedContent.Parent = ContentFrame
                UIListLayoutTabbedContent.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayoutTabbedContent.Padding = UDim.new(0, 10)

                ContentFrames[tabName] = ContentFrame

                TabButton.MouseButton1Click:Connect(function()
                    for _, frame in pairs(ContentFrames) do
                        frame.Visible = false
                    end
                    ContentFrame.Visible = true
                end)
            end

            function tab:AddToTab(tabName, element)
                if ContentFrames[tabName] then
                    element.Parent = ContentFrames[tabName]
                end
            end
        end

        return tab
    end

    return window
end
