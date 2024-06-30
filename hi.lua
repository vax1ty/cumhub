local UILibrary = {}

-- Main UI Library Module
function UILibrary:CreateWindow(title)
    local windowInstance = {}

    -- Instances for Window
    local Confirmation = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStrokeMainFrame = Instance.new("UIStroke")
    local TopBar = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local UIStrokeTopBar = Instance.new("UIStroke")
    local CloseButton = Instance.new("TextButton")
    local UICorner_3 = Instance.new("UICorner")
    local UIStrokeCloseButton = Instance.new("UIStroke")
    local MinimizeButton = Instance.new("TextButton")
    local UICorner_4 = Instance.new("UICorner")
    local UIStrokeMinimizeButton = Instance.new("UIStroke")
    local Title = Instance.new("TextLabel")
    local TabHolder = Instance.new("ScrollingFrame")
    local ContentHolder = Instance.new("Frame")
    local UICorner_5 = Instance.new("UICorner")
    local UIStrokeContentHolder = Instance.new("UIStroke")
    local UIListLayoutTabs = Instance.new("UIListLayout")
    local UIPaddingTabs = Instance.new("UIPadding")

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

    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    UIStrokeMainFrame.Parent = MainFrame
    UIStrokeMainFrame.Color = Color3.fromRGB(0, 0, 0)
    UIStrokeMainFrame.Thickness = 2

    print("Setting properties for TopBar")
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(45, 45, 48)
    TopBar.Size = UDim2.new(1, 0, 0, 50)

    UICorner_2.CornerRadius = UDim.new(0, 10)
    UICorner_2.Parent = TopBar

    UIStrokeTopBar.Parent = TopBar
    UIStrokeTopBar.Color = Color3.fromRGB(0, 0, 0)
    UIStrokeTopBar.Thickness = 2

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

    UICorner_3.CornerRadius = UDim.new(0, 10)
    UICorner_3.Parent = CloseButton

    UIStrokeCloseButton.Parent = CloseButton
    UIStrokeCloseButton.Color = Color3.fromRGB(0, 0, 0)
    UIStrokeCloseButton.Thickness = 2

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

    UICorner_4.CornerRadius = UDim.new(0, 10)
    UICorner_4.Parent = MinimizeButton

    UIStrokeMinimizeButton.Parent = MinimizeButton
    UIStrokeMinimizeButton.Color = Color3.fromRGB(0, 0, 0)
    UIStrokeMinimizeButton.Thickness = 2

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
    TabHolder.BackgroundTransparency = 1.000
    TabHolder.Position = UDim2.new(0.025, 0, 0.0933333337, 0)
    TabHolder.Size = UDim2.new(0.95, 0, 0.0616666675, 0)
    TabHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabHolder.ScrollBarThickness = 0
    TabHolder.AutomaticCanvasSize = Enum.AutomaticSize.X

    UIListLayoutTabs.Parent = TabHolder
    UIListLayoutTabs.FillDirection = Enum.FillDirection.Horizontal
    UIListLayoutTabs.HorizontalAlignment = Enum.HorizontalAlignment.Left
    UIListLayoutTabs.Padding = UDim.new(0, 5)

    UIPaddingTabs.Parent = TabHolder
    UIPaddingTabs.PaddingTop = UDim.new(0, 10)
    UIPaddingTabs.PaddingBottom = UDim.new(0, 10)
    UIPaddingTabs.PaddingLeft = UDim.new(0, 10)
    UIPaddingTabs.PaddingRight = UDim.new(0, 10)

    print("Setting properties for ContentHolder")
    ContentHolder.Name = "ContentHolder"
    ContentHolder.Parent = MainFrame
    ContentHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ContentHolder.BackgroundTransparency = 1.000
    ContentHolder.Position = UDim2.new(0.0250000004, 0, 0.200000003, 0)
    ContentHolder.Size = UDim2.new(0.935000002, 0, 0.800000012, 0)

    UICorner_5.CornerRadius = UDim.new(0, 10)
    UICorner_5.Parent = ContentHolder

    UIStrokeContentHolder.Parent = ContentHolder
    UIStrokeContentHolder.Color = Color3.fromRGB(0, 0, 0)
    UIStrokeContentHolder.Thickness = 2

    -- Functions to Add Tabs and UI Elements
    function windowInstance:AddTab(tabName)
        local tab = {}
        local TabButton = Instance.new("TextButton")
        local TabContent = Instance.new("Frame")
        local UICorner_Tab = Instance.new("UICorner")
        local UIStroke_Tab = Instance.new("UIStroke")
        local UIListLayout_TabContent = Instance.new("UIListLayout")
        local UIPadding_TabContent = Instance.new("UIPadding")

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
        TabButton.AutomaticSize = Enum.AutomaticSize.X

        UICorner_Tab.CornerRadius = UDim.new(0, 10)
        UICorner_Tab.Parent = TabButton

        UIStroke_Tab.Parent = TabButton
        UIStroke_Tab.Color = Color3.fromRGB(0, 0, 0)
        UIStroke_Tab.Thickness = 2

        -- Properties for Tab Content
        print("Creating Tab Content for tab:", tabName)
        TabContent.Name = tabName .. "_Content"
        TabContent.Parent = ContentHolder
        TabContent.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.Visible = false

        -- Adding UIPadding and UIListLayout for Tab Content
        UIPadding_TabContent.Parent = TabContent
        UIPadding_TabContent.PaddingTop = UDim.new(0, 10)
        UIPadding_TabContent.PaddingBottom = UDim.new(0, 10)
        UIPadding_TabContent.PaddingLeft = UDim.new(0, 10)
        UIPadding_TabContent.PaddingRight = UDim.new(0, 10)

        UIListLayout_TabContent.Parent = TabContent
        UIListLayout_TabContent.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_TabContent.Padding = UDim.new(0, 5)

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

        -- Functions to Add UI Elements
        function tab:CreateButton(text, callback)
            print("Creating Button with text:", text)
            local ButtonHolder = Instance.new("Frame")
            local Button = Instance.new("TextButton")
            local UICorner_Button = Instance.new("UICorner")
            local UIStroke_Button = Instance.new("UIStroke")

            -- Properties for Button Holder
            ButtonHolder.Name = "ButtonHolder"
            ButtonHolder.Parent = TabContent
            ButtonHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            ButtonHolder.Size = UDim2.new(1, 0, 0, 40)

            UICorner_Button.CornerRadius = UDim.new(0, 10)
            UICorner_Button.Parent = ButtonHolder

            UIStroke_Button.Parent = ButtonHolder
            UIStroke_Button.Color = Color3.fromRGB(0, 0, 0)
            UIStroke_Button.Thickness = 2

            -- Properties for Button
            Button.Name = "Button"
            Button.Parent = ButtonHolder
            Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Button.BackgroundTransparency = 1.000
            Button.Size = UDim2.new(1, 0, 1, 0)
            Button.Font = Enum.Font.FredokaOne
            Button.Text = text
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 24.000
            Button.TextXAlignment = Enum.TextXAlignment.Left

            UICorner_Button.CornerRadius = UDim.new(0, 10)
            UICorner_Button.Parent = Button

            UIStroke_Button.Parent = Button
            UIStroke_Button.Color = Color3.fromRGB(0, 0, 0)
            UIStroke_Button.Thickness = 2

            Button.MouseButton1Click:Connect(callback)
        end

        function tab:CreateSlider(text, min, max, callback)
            print("Creating Slider with text:", text)
            local SliderHolder = Instance.new("Frame")
            local SliderBar = Instance.new("Frame")
            local Slider = Instance.new("Frame")
            local SliderValue = Instance.new("TextLabel")
            local UICorner_SliderHolder = Instance.new("UICorner")
            local UIStroke_SliderHolder = Instance.new("UIStroke")
            local UICorner_SliderBar = Instance.new("UICorner")
            local UIStroke_SliderBar = Instance.new("UIStroke")
            local UICorner_Slider = Instance.new("UICorner")
            local UIStroke_Slider = Instance.new("UIStroke")

            -- Properties for Slider Holder
            SliderHolder.Name = "SliderHolder"
            SliderHolder.Parent = TabContent
            SliderHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            SliderHolder.Size = UDim2.new(1, 0, 0, 60)

            UICorner_SliderHolder.CornerRadius = UDim.new(0, 10)
            UICorner_SliderHolder.Parent = SliderHolder

            UIStroke_SliderHolder.Parent = SliderHolder
            UIStroke_SliderHolder.Color = Color3.fromRGB(0, 0, 0)
            UIStroke_SliderHolder.Thickness = 2

            -- Properties for Slider Bar
            SliderBar.Name = "SliderBar"
            SliderBar.Parent = SliderHolder
            SliderBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            SliderBar.Position = UDim2.new(0.1, 0, 0.5, -10)
            SliderBar.Size = UDim2.new(0.8, 0, 0.2, 0)

            UICorner_SliderBar.CornerRadius = UDim.new(0, 99)
            UICorner_SliderBar.Parent = SliderBar

            UIStroke_SliderBar.Parent = SliderBar
            UIStroke_SliderBar.Color = Color3.fromRGB(0, 0, 0)
            UIStroke_SliderBar.Thickness = 2

            -- Properties for Slider
            Slider.Name = "Slider"
            Slider.Parent = SliderBar
            Slider.BackgroundColor3 = Color3.fromRGB(0, 71, 255)
            Slider.Position = UDim2.new(0, 0, 0.5, -10)
            Slider.Size = UDim2.new(0, 20, 0, 20)

            UICorner_Slider.CornerRadius = UDim.new(1, 0)
            UICorner_Slider.Parent = Slider

            UIStroke_Slider.Parent = Slider
            UIStroke_Slider.Color = Color3.fromRGB(0, 0, 0)
            UIStroke_Slider.Thickness = 2

            -- Properties for Slider Value
            SliderValue.Name = "SliderValue"
            SliderValue.Parent = SliderHolder
            SliderValue.AnchorPoint = Vector2.new(0.5, 0.5)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.Position = UDim2.new(0.85, 0, 0.5, 0)
            SliderValue.Size = UDim2.new(0.1, 0, 0.5, 0)
            SliderValue.Font = Enum.Font.GothamBold
            SliderValue.Text = tostring(min)
            SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.TextSize = 24.000

            local UserInputService = game:GetService("UserInputService")

            local function moveSlider(input)
                local posX = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                local offset = Slider.AbsoluteSize.X / 2
                Slider.Position = UDim2.new(posX, -offset, 0.5, -10)
                local sliderValue = math.floor(min + (max - min) * posX)
                SliderValue.Text = tostring(sliderValue)
                callback(sliderValue)
            end

            Slider.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    moveSlider(input)
                    Slider.BackgroundColor3 = Color3.fromRGB(0, 71, 255)
                    local moveConnection, releaseConnection
                    moveConnection = UserInputService.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            moveSlider(input)
                        end
                    end)
                    releaseConnection = UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            moveConnection:Disconnect()
                            releaseConnection:Disconnect()
                        end
                    end)
                end
            end)

            SliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    moveSlider(input)
                    Slider.BackgroundColor3 = Color3.fromRGB(0, 71, 255)
                end
            end)
        end

        function tab:CreateToggle(text, initialState, callback)
            print("Creating Toggle with text:", text)
            local ToggleHolder = Instance.new("Frame")
            local ToggleBar = Instance.new("Frame")
            local Toggle = Instance.new("Frame")
            local ToggleLabel = Instance.new("TextLabel")
            local UICorner_ToggleHolder = Instance.new("UICorner")
            local UIStroke_ToggleHolder = Instance.new("UIStroke")
            local UICorner_ToggleBar = Instance.new("UICorner")
            local UIStroke_ToggleBar = Instance.new("UIStroke")
            local UICorner_Toggle = Instance.new("UICorner")
            local UIStroke_Toggle = Instance.new("UIStroke")

            -- Properties for Toggle Holder
            ToggleHolder.Name = "ToggleHolder"
            ToggleHolder.Parent = TabContent
            ToggleHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            ToggleHolder.Size = UDim2.new(1, 0, 0, 40)

            UICorner_ToggleHolder.CornerRadius = UDim.new(0, 10)
            UICorner_ToggleHolder.Parent = ToggleHolder

            UIStroke_ToggleHolder.Parent = ToggleHolder
            UIStroke_ToggleHolder.Color = Color3.fromRGB(0, 0, 0)
            UIStroke_ToggleHolder.Thickness = 2

            -- Properties for Toggle Bar
            ToggleBar.Name = "ToggleBar"
            ToggleBar.Parent = ToggleHolder
            ToggleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            ToggleBar.Position = UDim2.new(0.75, 0, 0.5, -15)
            ToggleBar.Size = UDim2.new(0.2, 0, 0.5, 0)

            UICorner_ToggleBar.CornerRadius = UDim.new(0, 99)
            UICorner_ToggleBar.Parent = ToggleBar

            UIStroke_ToggleBar.Parent = ToggleBar
            UIStroke_ToggleBar.Color = Color3.fromRGB(0, 0, 0)
            UIStroke_ToggleBar.Thickness = 2

            -- Properties for Toggle
            Toggle.Name = "Toggle"
            Toggle.Parent = ToggleBar
            Toggle.BackgroundColor3 = initialState and Color3.fromRGB(0, 71, 255) or Color3.fromRGB(35, 35, 35)
            Toggle.Position = initialState and UDim2.new(1, -37, 0.5, -18.5) or UDim2.new(0, 0, 0.5, -18.5)
            Toggle.Size = UDim2.new(0, 37, 0, 37)

            UICorner_Toggle.CornerRadius = UDim.new(1, 0)
            UICorner_Toggle.Parent = Toggle

            UIStroke_Toggle.Parent = Toggle
            UIStroke_Toggle.Color = Color3.fromRGB(0, 0, 0)
            UIStroke_Toggle.Thickness = 2

            -- Properties for Toggle Label
            ToggleLabel.Name = "ToggleLabel"
            ToggleLabel.Parent = ToggleHolder
            ToggleLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            ToggleLabel.BackgroundTransparency = 1.000
            ToggleLabel.Position = UDim2.new(0.3, 0, 0.5, 0)
            ToggleLabel.Size = UDim2.new(0.6, -20, 0.8, -20)
            ToggleLabel.Font = Enum.Font.FredokaOne
            ToggleLabel.Text = text
            ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleLabel.TextSize = 24.000
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

            -- Toggle Functionality
            local toggleState = initialState

            local function setToggleState(state)
                toggleState = state
                Toggle.BackgroundColor3 = state and Color3.fromRGB(0, 71, 255) or Color3.fromRGB(35, 35, 35)
                Toggle:TweenPosition(state and UDim2.new(1, -37, 0.5, -18.5) or UDim2.new(0, 0, 0.5, -18.5), "Out", "Sine", 0.2, true)
                callback(state)
            end

            ToggleBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    setToggleState(not toggleState)
                end
            end)

            return setToggleState
        end

        function tab:CreateDropdown(text, items, multiSelect, callback)
            print("Creating Dropdown with text:", text)
            local DropdownHolder = Instance.new("Frame")
            local DropdownButton = Instance.new("TextButton")
            local DropdownList = Instance.new("Frame")
            local SearchBar = Instance.new("TextBox")
            local UICorner_DropdownHolder = Instance.new("UICorner")
            local UIStroke_DropdownHolder = Instance.new("UIStroke")
            local UICorner_DropdownButton = Instance.new("UICorner")
            local UIStroke_DropdownButton = Instance.new("UIStroke")
            local UICorner_DropdownList = Instance.new("UICorner")
            local UIStroke_DropdownList = Instance.new("UIStroke")
            local UICorner_SearchBar = Instance.new("UICorner")
            local UIStroke_SearchBar = Instance.new("UIStroke")

            -- Properties for Dropdown Holder
            DropdownHolder.Name = "DropdownHolder"
            DropdownHolder.Parent = TabContent
            DropdownHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            DropdownHolder.Size = UDim2.new(1, 0, 0, 40)

            UICorner_DropdownHolder.CornerRadius = UDim.new(0, 10)
            UICorner_DropdownHolder.Parent = DropdownHolder

            UIStroke_DropdownHolder.Parent = DropdownHolder
            UIStroke_DropdownHolder.Color = Color3.fromRGB(0, 0, 0)
            UIStroke_DropdownHolder.Thickness = 2

            -- Properties for Dropdown Button
            DropdownButton.Name = "DropdownButton"
            DropdownButton.Parent = DropdownHolder
            DropdownButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            DropdownButton.BackgroundTransparency = 1.000
            DropdownButton.BorderSizePixel = 0
            DropdownButton.Position = UDim2.new(0.0199999996, 0, 0.100000001, 0)
            DropdownButton.Size = UDim2.new(0.980000019, 0, 0, 40)
            DropdownButton.Font = Enum.Font.FredokaOne
            DropdownButton.Text = text
            DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownButton.TextSize = 24.000
            DropdownButton.TextXAlignment = Enum.TextXAlignment.Left

            UICorner_DropdownButton.CornerRadius = UDim.new(0, 10)
            UICorner_DropdownButton.Parent = DropdownButton

            UIStroke_DropdownButton.Parent = DropdownButton
            UIStroke_DropdownButton.Color = Color3.fromRGB(0, 0, 0)
            UIStroke_DropdownButton.Thickness = 2

            -- Properties for Dropdown List
            DropdownList.Name = "DropdownList"
            DropdownList.Parent = DropdownHolder
            DropdownList.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            DropdownList.ClipsDescendants = true
            DropdownList.Position = UDim2.new(0.0199999996, 0, 0.800000012, 0)
            DropdownList.Size = UDim2.new(0.959999979, 0, 0, 150)
            DropdownList.Visible = false

            UICorner_DropdownList.CornerRadius = UDim.new(0, 10)
            UICorner_DropdownList.Parent = DropdownList

            UIStroke_DropdownList.Parent = DropdownList
            UIStroke_DropdownList.Color = Color3.fromRGB(0, 0, 0)
            UIStroke_DropdownList.Thickness = 2

            -- Properties for Search Bar
            SearchBar.Name = "SearchBar"
            SearchBar.Parent = DropdownList
            SearchBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            SearchBar.Position = UDim2.new(0, 5, 0, 5)
            SearchBar.Size = UDim2.new(1, -10, 0, 30)
            SearchBar.Font = Enum.Font.FredokaOne
            SearchBar.PlaceholderText = "Search..."
            SearchBar.Text = ""
            SearchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
            SearchBar.TextSize = 24.000

            UICorner_SearchBar.CornerRadius = UDim.new(0, 10)
            UICorner_SearchBar.Parent = SearchBar

            UIStroke_SearchBar.Parent = SearchBar
            UIStroke_SearchBar.Color = Color3.fromRGB(0, 0, 0)
            UIStroke_SearchBar.Thickness = 2

            -- Dropdown Items
            local SelectedItems = {}
            local itemFrames = {}

            local function updateDropdown()
                local selectedText = ""
                for item, _ in pairs(SelectedItems) do
                    if selectedText == "" then
                        selectedText = item
                    else
                        selectedText = selectedText .. ", " .. item
                    end
                end
                DropdownButton.Text = selectedText == "" and text or selectedText
                callback(SelectedItems)
            end

            local function createDropdownItem(itemText)
                local DropdownItem = Instance.new("TextButton")
                local UICorner_DropdownItem = Instance.new("UICorner")
                local UIStroke_DropdownItem = Instance.new("UIStroke")

                DropdownItem.Name = itemText
                DropdownItem.Parent = DropdownList
                DropdownItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                DropdownItem.Size = UDim2.new(1, -10, 0, 30)
                DropdownItem.Font = Enum.Font.FredokaOne
                DropdownItem.Text = itemText
                DropdownItem.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownItem.TextSize = 24.000
                DropdownItem.TextXAlignment = Enum.TextXAlignment.Left

                UICorner_DropdownItem.CornerRadius = UDim.new(0, 10)
                UICorner_DropdownItem.Parent = DropdownItem

                UIStroke_DropdownItem.Parent = DropdownItem
                UIStroke_DropdownItem.Color = Color3.fromRGB(0, 0, 0)
                UIStroke_DropdownItem.Thickness = 2

                DropdownItem.MouseEnter:Connect(function()
                    DropdownItem.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                end)
                DropdownItem.MouseLeave:Connect(function()
                    DropdownItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                end)
                DropdownItem.MouseButton1Click:Connect(function()
                    if multiSelect then
                        if SelectedItems[DropdownItem.Text] then
                            SelectedItems[DropdownItem.Text] = nil
                            DropdownItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                        else
                            SelectedItems[DropdownItem.Text] = true
                            DropdownItem.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                        end
                    else
                        for _, item in pairs(DropdownList:GetChildren()) do
                            if item:IsA("TextButton") then
                                item.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                                SelectedItems[item.Text] = nil
                            end
                        end
                        SelectedItems[DropdownItem.Text] = true
                        DropdownItem.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                    end
                    updateDropdown()
                end)

                return DropdownItem
            end

            -- Populate Dropdown Items
            for _, item in ipairs(items) do
                local itemFrame = createDropdownItem(item)
                table.insert(itemFrames, itemFrame)
            end

            local function filterItems(searchText)
                local yPos = 40  -- Starting Y position for items
                for _, itemFrame in ipairs(itemFrames) do
                    if string.find(string.lower(itemFrame.Text), string.lower(searchText)) then
                        itemFrame.Position = UDim2.new(0, 5, 0, yPos)
                        itemFrame.Visible = true
                        yPos = yPos + 35
                    else
                        itemFrame.Visible = false
                    end
                end
                DropdownList.Size = UDim2.new(0.959999979, 0, 0, yPos + 5)
            end

            SearchBar.Changed:Connect(function()
                filterItems(SearchBar.Text)
            end)

            DropdownButton.MouseButton1Click:Connect(function()
                DropdownList.Visible = not DropdownList.Visible
            end)
        end

        return tab
    end

    -- Close and Minimize Functionality
    CloseButton.MouseButton1Click:Connect(function()
        Confirmation:Destroy()
    end)

    MinimizeButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    return windowInstance
end

return UILibrary
