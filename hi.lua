local UILibrary = {}
UILibrary.__index = UILibrary

local function createUIElement(className, properties)
    local element = Instance.new(className)
    for property, value in pairs(properties) do
        element[property] = value
    end
    return element
end

function UILibrary:CreateWindow(title)
    local screenGui = createUIElement("ScreenGui", {
        Name = title,
        Parent = game:GetService("CoreGui"),
        ResetOnSpawn = false
    })

    local mainFrame = createUIElement("Frame", {
        Name = "MainFrame",
        Parent = screenGui,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 400, 0, 500)
    })

    createUIElement("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = mainFrame
    })

    createUIElement("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = mainFrame
    })

    local topBar = createUIElement("Frame", {
        Name = "TopBar",
        Parent = mainFrame,
        BackgroundColor3 = Color3.fromRGB(45, 45, 48),
        Size = UDim2.new(1, 0, 0, 50)
    })

    createUIElement("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = topBar
    })

    createUIElement("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = topBar
    })

    createUIElement("TextLabel", {
        Name = "Title",
        Parent = topBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -100, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Font = Enum.Font.GothamBold,
        Text = title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 24,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local closeButton = createUIElement("TextButton", {
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

    createUIElement("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = closeButton
    })

    createUIElement("UIStroke", {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Parent = closeButton
    })

    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    local tabHolder = createUIElement("Frame", {
        Name = "TabHolder",
        Parent = mainFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.1, 0),
        Size = UDim2.new(1, 0, 0, 50)
    })

    local contentHolder = createUIElement("Frame", {
        Name = "ContentHolder",
        Parent = mainFrame,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.2, 0),
        Size = UDim2.new(1, 0, 0.8, 0)
    })

    local tabContainer = {}
    tabContainer.Tabs = {}

    function tabContainer:CreateTab(tabName)
        local tabButton = createUIElement("TextButton", {
            Name = tabName .. "TabButton",
            Parent = tabHolder,
            BackgroundColor3 = Color3.fromRGB(48, 48, 53),
            Size = UDim2.new(0, 100, 0, 40),
            Font = Enum.Font.FredokaOne,
            Text = tabName,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 24,
            AutomaticSize = Enum.AutomaticSize.X
        })

        createUIElement("UICorner", {
            CornerRadius = UDim.new(0, 10),
            Parent = tabButton
        })

        createUIElement("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = tabButton
        })

        local tabContent = createUIElement("ScrollingFrame", {
            Name = tabName .. "Content",
            Parent = contentHolder,
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 0,
            ScrollingEnabled = true,
            Visible = false
        })

        table.insert(tabContainer.Tabs, {button = tabButton, content = tabContent})

        tabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(tabContainer.Tabs) do
                tab.content.Visible = false
            end
            tabContent.Visible = true
        end)

        if #tabContainer.Tabs == 1 then
            tabContent.Visible = true
        end

        return tabContent
    end

    function tabContainer:CreateSlider(tabContent, sliderName)
        local sliderHolder = createUIElement("Frame", {
            Name = sliderName .. "Holder",
            Parent = tabContent,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            Size = UDim2.new(0.98, 0, 0, 70)
        })

        createUIElement("UICorner", {
            CornerRadius = UDim.new(0, 10),
            Parent = sliderHolder
        })

        createUIElement("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = sliderHolder
        })

        local sliderBar = createUIElement("Frame", {
            Name = sliderName .. "Bar",
            Parent = sliderHolder,
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            Position = UDim2.new(0.022, 0, 0.531, -5),
            Size = UDim2.new(0.97, 0, 0.4, 0)
        })

        createUIElement("UICorner", {
            CornerRadius = UDim.new(0, 99),
            Parent = sliderBar
        })

        createUIElement("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = sliderBar
        })

        local slider = createUIElement("Frame", {
            Name = sliderName,
            Parent = sliderBar,
            BackgroundColor3 = Color3.fromRGB(0, 71, 255),
            Position = UDim2.new(0, 0, 0.5, -20),
            Size = UDim2.new(0, 44, 0, 40)
        })

        createUIElement("UICorner", {
            CornerRadius = UDim.new(1, 0),
            Parent = slider
        })

        createUIElement("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = slider
        })

        local sliderValue = createUIElement("TextLabel", {
            Name = sliderName .. "Value",
            Parent = sliderHolder,
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.906, 0, 0.247, 0),
            Size = UDim2.new(0.185, 0, 0.441, 0),
            Font = Enum.Font.GothamBold,
            Text = "50",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 24
        })

        local UserInputService = game:GetService("UserInputService")

        local function moveSlider(input)
            local posX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
            local offset = 22  -- Half the width of the slider to ensure it doesn't go off the frame
            slider.Position = UDim2.new(posX, -offset, 0.5, -20)
            sliderValue.Text = tostring(math.floor(posX * 100))
            slider.BackgroundColor3 = Color3.fromRGB(0, 71, 255)  -- Change color to blue after dragging
        end

        slider.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                moveSlider(input)
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

        sliderBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                moveSlider(input)
            end
        end)

        tabContent.CanvasSize = UDim2.new(0, 0, 0, tabContent.CanvasSize.Y.Offset + sliderHolder.Size.Y.Offset + 10)
    end

    function tabContainer:CreateToggle(tabContent, toggleName)
        local toggleHolder = createUIElement("Frame", {
            Name = toggleName .. "Holder",
            Parent = tabContent,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            Size = UDim2.new(0.98, 0, 0, 70)
        })

        createUIElement("UICorner", {
            CornerRadius = UDim.new(0, 10),
            Parent = toggleHolder
        })

        createUIElement("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = toggleHolder
        })

        local toggleBar = createUIElement("Frame", {
            Name = toggleName .. "Bar",
            Parent = toggleHolder,
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            Position = UDim2.new(0.75, 0, 0.5, -15),
            Size = UDim2.new(0.2, 0, 0.5, 0)
        })

        createUIElement("UICorner", {
            CornerRadius = UDim.new(0, 99),
            Parent = toggleBar
        })

        createUIElement("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = toggleBar
        })

        local toggle = createUIElement("Frame", {
            Name = toggleName,
            Parent = toggleBar,
            BackgroundColor3 = Color3.fromRGB(0, 71, 255),
            Position = UDim2.new(0, 0, 0.5, -18.5),
            Size = UDim2.new(0, 37, 0, 37)
        })

        createUIElement("UICorner", {
            CornerRadius = UDim.new(1, 0),
            Parent = toggle
        })

        createUIElement("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = toggle
        })

        local toggleLabel = createUIElement("TextLabel", {
            Name = toggleName .. "Label",
            Parent = toggleHolder,
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.301812887, 0, 0.5, 0),
            Size = UDim2.new(0.6, -20, 0.8, -20),
            Font = Enum.Font.FredokaOne,
            Text = "Toggle",
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
        end

        toggleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                toggleState = not toggleState
                setToggleState(toggleState)
            end
        end)

        tabContent.CanvasSize = UDim2.new(0, 0, 0, tabContent.CanvasSize.Y.Offset + toggleHolder.Size.Y.Offset + 10)
    end

    function tabContainer:CreateButton(tabContent, buttonName)
        local buttonHolder = createUIElement("Frame", {
            Name = buttonName .. "Holder",
            Parent = tabContent,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            Size = UDim2.new(0.98, 0, 0, 70)
        })

        createUIElement("UICorner", {
            CornerRadius = UDim.new(0, 10),
            Parent = buttonHolder
        })

        createUIElement("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = buttonHolder
        })

        local button = createUIElement("TextButton", {
            Name = buttonName,
            Parent = buttonHolder,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0.02, 0, 0.1, 0),
            Size = UDim2.new(0.96, 0, 0.8, 0),
            Font = Enum.Font.FredokaOne,
            Text = "Button",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 30,
            TextXAlignment = Enum.TextXAlignment.Left
        })

        createUIElement("UICorner", {
            CornerRadius = UDim.new(0, 10),
            Parent = button
        })

        createUIElement("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = button
        })

        tabContent.CanvasSize = UDim2.new(0, 0, 0, tabContent.CanvasSize.Y.Offset + buttonHolder.Size.Y.Offset + 10)
    end

    function tabContainer:CreateDropdown(tabContent, dropdownName, items)
        local dropdownHolder = createUIElement("Frame", {
            Name = dropdownName .. "Holder",
            Parent = tabContent,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            Size = UDim2.new(0.98, 0, 0, 70)
        })

        createUIElement("UICorner", {
            CornerRadius = UDim.new(0, 10),
            Parent = dropdownHolder
        })

        createUIElement("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = dropdownHolder
        })

        local dropdownButton = createUIElement("TextButton", {
            Name = dropdownName .. "Button",
            Parent = dropdownHolder,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0.02, 0, 0.1, 0),
            Size = UDim2.new(0.96, 0, 0.8, 0),
            Font = Enum.Font.FredokaOne,
            Text = "Dropdown",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 30,
            TextXAlignment = Enum.TextXAlignment.Left
        })

        createUIElement("UICorner", {
            CornerRadius = UDim.new(0, 10),
            Parent = dropdownButton
        })

        createUIElement("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = dropdownButton
        })

        local dropdownList = createUIElement("Frame", {
            Name = dropdownName .. "List",
            Parent = dropdownHolder,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            ClipsDescendants = true,
            Position = UDim2.new(0.02, 0, 1, 0),
            Size = UDim2.new(0.96, 0, 0, 0),
            Visible = false
        })

        createUIElement("UICorner", {
            CornerRadius = UDim.new(0, 10),
            Parent = dropdownList
        })

        createUIElement("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = dropdownList
        })

        local itemHeight = 30
        local dropdownHeight = 0

        for i, item in ipairs(items) do
            local dropdownItem = createUIElement("TextButton", {
                Name = "Item" .. i,
                Parent = dropdownList,
                BackgroundColor3 = Color3.fromRGB(45, 45, 45),
                Position = UDim2.new(0, 5, 0, dropdownHeight),
                Size = UDim2.new(1, -10, 0, itemHeight),
                Font = Enum.Font.FredokaOne,
                Text = item,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 24,
                TextXAlignment = Enum.TextXAlignment.Left
            })

            createUIElement("UICorner", {
                CornerRadius = UDim.new(0, 10),
                Parent = dropdownItem
            })

            createUIElement("UIStroke", {
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

            dropdownHeight = dropdownHeight + itemHeight + 5
        end

        dropdownList.Size = UDim2.new(0.96, 0, 0, dropdownHeight)

        dropdownButton.MouseButton1Click:Connect(function()
            dropdownList.Visible = not dropdownList.Visible
            if dropdownList.Visible then
                dropdownHolder.Size = UDim2.new(0.98, 0, 0, 70 + dropdownHeight + 5)
            else
                dropdownHolder.Size = UDim2.new(0.98, 0, 0, 70)
            end
        end)

        tabContent.CanvasSize = UDim2.new(0, 0, 0, tabContent.CanvasSize.Y.Offset + dropdownHolder.Size.Y.Offset + 10)
    end

    return tabContainer
end

return UILibrary
