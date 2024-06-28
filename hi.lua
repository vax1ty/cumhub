local UILibrary = {}

function UILibrary:Create(instanceType, properties)
    local instance = Instance.new(instanceType)
    for property, value in pairs(properties) do
        instance[property] = value
    end
    return instance
end

function UILibrary:CreateWindow(title)
    local screenGui = self:Create("ScreenGui", {
        Name = "Confirmation",
        Parent = game:GetService("CoreGui")
    })

    local mainFrame = self:Create("Frame", {
        Name = "MainFrame",
        Parent = screenGui,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 602, 0, 673)
    })

    self:Create("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = mainFrame
    })

    self:Create("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = mainFrame
    })

    local topBar = self:Create("Frame", {
        Name = "TopBar",
        Parent = mainFrame,
        BackgroundColor3 = Color3.fromRGB(45, 45, 48),
        Size = UDim2.new(1, 0, 0, 50)
    })

    self:Create("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = topBar
    })

    self:Create("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = topBar
    })

    local closeButton = self:Create("TextButton", {
        Name = "CloseButton",
        Parent = topBar,
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        BorderSizePixel = 0,
        Position = UDim2.new(1, -45, 0, 5),
        Size = UDim2.new(0, 40, 0, 40),
        Font = Enum.Font.GothamBold,
        Text = "X",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 24
    })

    self:Create("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = closeButton
    })

    self:Create("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = closeButton
    })

    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    local minimizeButton = self:Create("TextButton", {
        Name = "MinimizeButton",
        Parent = topBar,
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        BorderSizePixel = 0,
        Position = UDim2.new(1, -90, 0, 5),
        Size = UDim2.new(0, 40, 0, 40),
        Font = Enum.Font.GothamBold,
        Text = "-",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 24
    })

    self:Create("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = minimizeButton
    })

    self:Create("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = minimizeButton
    })

    minimizeButton.MouseButton1Click:Connect(function()
        if mainFrame.Visible then
            mainFrame.Visible = false
            minimizeButton.Text = "+"
        else
            mainFrame.Visible = true
            minimizeButton.Text = "-"
        end
    end)

    local windowTitle = self:Create("TextLabel", {
        Name = "WindowTitle",
        Parent = topBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -100, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 24
    })

    local tabHolder = self:Create("Frame", {
        Name = "TabHolder",
        Parent = mainFrame,
        BackgroundColor3 = Color3.fromRGB(45, 45, 48),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.0933333337, 0),
        Size = UDim2.new(1, 0, 0.0616666675, 0)
    })

    local contentHolder = self:Create("ScrollingFrame", {
        Name = "ContentHolder",
        Parent = mainFrame,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.0250000004, 0, 0.200000003, 0),
        Size = UDim2.new(0.935000002, 0, 0.800000012, 0),
        CanvasSize = UDim2.new(0, 0, 1.2, 0),
        ScrollBarThickness = 0,
        ScrollingEnabled = false
    })

    local window = {
        screenGui = screenGui,
        mainFrame = mainFrame,
        topBar = topBar,
        closeButton = closeButton,
        minimizeButton = minimizeButton,
        windowTitle = windowTitle,
        tabHolder = tabHolder,
        contentHolder = contentHolder,
        tabs = {}
    }

    setmetatable(window, { __index = UILibrary })

    return window
end

function UILibrary:CreateTab(name)
    local tabButton = self:Create("TextButton", {
        Name = name .. "Button",
        Parent = self.tabHolder,
        BackgroundColor3 = Color3.fromRGB(48, 48, 53),
        Size = UDim2.new(0, 100, 0.8, 0),
        Font = Enum.Font.FredokaOne,
        Text = name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 24
    })

    self:Create("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = tabButton
    })

    self:Create("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = tabButton
    })

    local tabContent = self:Create("ScrollingFrame", {
        Name = name .. "Content",
        Parent = self.contentHolder,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(0, 0, 1, 0),
        ScrollBarThickness = 6,
        Visible = false
    })

    self.tabs[#self.tabs + 1] = {
        button = tabButton,
        content = tabContent
    }

    tabButton.MouseButton1Click:Connect(function()
        for _, tab in pairs(self.tabs) do
            tab.content.Visible = false
        end
        tabContent.Visible = true
    end)

    return tabContent
end

function UILibrary:CreateSlider(tabContent, name, callback)
    local sliderHolder = self:Create("Frame", {
        Name = name .. "Holder",
        Parent = tabContent,
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        Size = UDim2.new(0.98, 0, 0, 70),
        Position = UDim2.new(0.01, 0, tabContent.CanvasSize.Y.Scale, 0)
    })

    self:Create("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = sliderHolder
    })

    self:Create("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = sliderHolder
    })

    local sliderBar = self:Create("Frame", {
        Name = name .. "Bar",
        Parent = sliderHolder,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        Position = UDim2.new(0.0222514309, 0, 0.530658782, -5),
        Size = UDim2.new(0.97, 0, 0.4, 0)
    })

    self:Create("UICorner", {
        CornerRadius = UDim.new(0, 99),
        Parent = sliderBar
    })

    self:Create("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = sliderBar
    })

    local slider = self:Create("Frame", {
        Name = name,
        Parent = sliderBar,
        BackgroundColor3 = Color3.fromRGB(0, 71, 255),
        Position = UDim2.new(0, 0, 0.5, -20),
        Size = UDim2.new(0, 44, 0, 40)
    })

    self:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = slider
    })

    self:Create("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = slider
    })

    local sliderValue = self:Create("TextLabel", {
        Name = name .. "Value",
        Parent = sliderHolder,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.906082153, 0, 0.247234434, 0),
        Size = UDim2.new(0.184561253, 0, 0.440564632, 0),
        Font = Enum.Font.GothamBold,
        Text = "50",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 24
    })

    local function moveSlider(input)
        local posX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        local offset = 22
        slider.Position = UDim2.new(posX, -offset, 0.5, -20)
        sliderValue.Text = tostring(math.floor(posX * 100))
        if callback then callback(math.floor(posX * 100)) end
    end

    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            moveSlider(input)
            slider.BackgroundColor3 = Color3.fromRGB(0, 71, 255)
            local moveConnection, releaseConnection
            moveConnection = game:GetService("UserInputService").InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    moveSlider(input)
                end
            end)
            releaseConnection = game:GetService("UserInputService").InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    moveConnection:Disconnect()
                    releaseConnection:Disconnect()
                end
            end)
        end
    end)

    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            moveSlider(input)
            slider.BackgroundColor3 = Color3.fromRGB(0, 71, 255)
        end
    end)

    tabContent.CanvasSize = UDim2.new(0, 0, tabContent.CanvasSize.Y.Scale + 0.14, 0)
end

function UILibrary:CreateToggle(tabContent, name, callback)
    local toggleHolder = self:Create("Frame", {
        Name = name .. "Holder",
        Parent = tabContent,
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        Size = UDim2.new(0.98, 0, 0, 70),
        Position = UDim2.new(0.01, 0, tabContent.CanvasSize.Y.Scale, 0)
    })

    self:Create("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = toggleHolder
    })

    self:Create("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = toggleHolder
    })

    local toggleBar = self:Create("Frame", {
        Name = name .. "Bar",
        Parent = toggleHolder,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        Position = UDim2.new(0.75, 0, 0.5, -15),
        Size = UDim2.new(0.2, 0, 0.5, 0)
    })

    self:Create("UICorner", {
        CornerRadius = UDim.new(0, 99),
        Parent = toggleBar
    })

    self:Create("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = toggleBar
    })

    local toggle = self:Create("Frame", {
        Name = name,
        Parent = toggleBar,
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        Position = UDim2.new(0, 0, 0.5, -18.5),
        Size = UDim2.new(0, 37, 0, 37)
    })

    self:Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = toggle
    })

    self:Create("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = toggle
    })

    local toggleLabel = self:Create("TextLabel", {
        Name = name .. "Label",
        Parent = toggleHolder,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.301812887, 0, 0.5, 0),
        Size = UDim2.new(0.6, -20, 0.8, -20),
        Font = Enum.Font.FredokaOne,
        Text = name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 30,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local toggleState = false

    local function setToggleState(state)
        if state then
            toggle:TweenPosition(UDim2.new(1, -37, 0.5, -18.5), "Out", "Sine", 0.2, true)
            toggle.BackgroundColor3 = Color3.fromRGB(0, 71, 255)
        else
            toggle:TweenPosition(UDim2.new(0, 0, 0.5, -18.5), "Out", "Sine", 0.2, true)
            toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        end
        if callback then callback(state) end
    end

    toggleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggleState = not toggleState
            setToggleState(toggleState)
        end
    end)

    tabContent.CanvasSize = UDim2.new(0, 0, tabContent.CanvasSize.Y.Scale + 0.14, 0)
end

function UILibrary:CreateButton(tabContent, name, callback)
    local buttonHolder = self:Create("Frame", {
        Name = name .. "Holder",
        Parent = tabContent,
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        Size = UDim2.new(0.98, 0, 0, 70),
        Position = UDim2.new(0.01, 0, tabContent.CanvasSize.Y.Scale, 0)
    })

    self:Create("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = buttonHolder
    })

    self:Create("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = buttonHolder
    })

    local button = self:Create("TextButton", {
        Name = name,
        Parent = buttonHolder,
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0.0199999996, 0, 0.100000001, 0),
        Size = UDim2.new(0.980000019, 0, 0, 70),
        Font = Enum.Font.FredokaOne,
        Text = name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 30,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    self:Create("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = button
    })

    self:Create("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = button
    })

    button.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)

    tabContent.CanvasSize = UDim2.new(0, 0, tabContent.CanvasSize.Y.Scale + 0.14, 0)
end

function UILibrary:CreateDropdown(tabContent, name, items, multiSelect, callback)
    local dropdownHolder = self:Create("Frame", {
        Name = name .. "Holder",
        Parent = tabContent,
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        Size = UDim2.new(0.98, 0, 0, 70),
        Position = UDim2.new(0.01, 0, tabContent.CanvasSize.Y.Scale, 0)
    })

    self:Create("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = dropdownHolder
    })

    self:Create("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = dropdownHolder
    })

    local dropdownButton = self:Create("TextButton", {
        Name = name .. "Button",
        Parent = dropdownHolder,
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0.0199999996, 0, 0.100000001, 0),
        Size = UDim2.new(0.980000019, 0, 0, 70),
        Font = Enum.Font.FredokaOne,
        Text = name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 30,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    self:Create("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = dropdownButton
    })

    self:Create("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = dropdownButton
    })

    local dropdownList = self:Create("Frame", {
        Name = name .. "List",
        Parent = dropdownHolder,
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        ClipsDescendants = true,
        Position = UDim2.new(0.0199999996, 0, 0.800000012, 0),
        Size = UDim2.new(0.959999979, 0, 0, 0),
        Visible = false
    })

    self:Create("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = dropdownList
    })

    self:Create("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = dropdownList
    })

    local selectedItems = {}

    for i, item in pairs(items) do
        local dropdownItem = self:Create("TextButton", {
            Name = name .. "Item" .. i,
            Parent = dropdownList,
            BackgroundColor3 = Color3.fromRGB(45, 45, 45),
            Size = UDim2.new(1, -10, 0, 30),
            Position = UDim2.new(0, 5, 0, (i - 1) * 35),
            Font = Enum.Font.FredokaOne,
            Text = item,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 24,
            TextXAlignment = Enum.TextXAlignment.Left
        })

        self:Create("UICorner", {
            CornerRadius = UDim.new(0, 10),
            Parent = dropdownItem
        })

        self:Create("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = dropdownItem
        })

        dropdownItem.MouseEnter:Connect(function()
            dropdownItem.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        end)

        dropdownItem.MouseLeave:Connect(function()
            dropdownItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end)

        dropdownItem.MouseButton1Click:Connect(function()
            if multiSelect then
                if selectedItems[item] then
                    selectedItems[item] = nil
                    dropdownItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                else
                    selectedItems[item] = true
                    dropdownItem.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                end
            else
                for _, btn in pairs(dropdownList:GetChildren()) do
                    if btn:IsA("TextButton") then
                        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                        selectedItems[btn.Text] = nil
                    end
                end
                selectedItems[item] = true
                dropdownItem.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            end

            local selectedText = ""
            for selectedItem, _ in pairs(selectedItems) do
                if selectedText == "" then
                    selectedText = selectedItem
                else
                    selectedText = selectedText .. ", " .. selectedItem
                end
            end
            dropdownButton.Text = selectedText == "" and name or selectedText

            if callback then callback(selectedItems) end
        end)
    end

    dropdownButton.MouseButton1Click:Connect(function()
        dropdownList.Visible = not dropdownList.Visible
        if dropdownList.Visible then
            dropdownList:TweenSize(UDim2.new(0.959999979, 0, 0, #items * 35), "Out", "Sine", 0.2, true)
        else
            dropdownList:TweenSize(UDim2.new(0.959999979, 0, 0, 0), "Out", "Sine", 0.2, true)
        end
    end)

    tabContent.CanvasSize = UDim2.new(0, 0, tabContent.CanvasSize.Y.Scale + 0.14, 0)
end

return UILibrary
