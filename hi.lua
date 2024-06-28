local UILibrary = {}

function UILibrary:Create(instanceType, properties)
    local instance = Instance.new(instanceType)
    for property, value in pairs(properties) do
        instance[property] = value
    end
    return instance
end

function UILibrary:CreateWindow(name)
    local screenGui = self:Create("ScreenGui", {
        Name = name,
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

    local titleLabel = self:Create("TextLabel", {
        Name = "TitleLabel",
        Parent = topBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -60, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 24
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

    local tabHolder = self:Create("Frame", {
        Name = "TabHolder",
        Parent = mainFrame,
        BackgroundColor3 = Color3.fromRGB(45, 45, 48),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.0933333337, 0),
        Size = UDim2.new(1, 0, 0.0616666675, 0)
    })

    return {
        screenGui = screenGui,
        mainFrame = mainFrame,
        topBar = topBar,
        tabHolder = tabHolder,
        tabs = {}
    }
end

function UILibrary:CreateTab(window, name)
    local tabButton = self:Create("TextButton", {
        Name = name .. "Button",
        Parent = window.tabHolder,
        BackgroundColor3 = Color3.fromRGB(48, 48, 53),
        Position = UDim2.new(#window.tabHolder:GetChildren() * 0.15, 0, 0.1, 0),
        Size = UDim2.new(0.15, 0, 0.8, 0),
        Font = Enum.Font.FredokaOne,
        Text = name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 24,
        AutomaticSize = Enum.AutomaticSize.X
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
        Parent = window.mainFrame,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.025, 0, 0.2, 0),
        Size = UDim2.new(0.935, 0, 0.8, 0),
        CanvasSize = UDim2.new(0, 0, 1.2, 0),
        ScrollBarThickness = 0,
        ScrollingEnabled = false,
        Visible = false
    })

    tabButton.MouseButton1Click:Connect(function()
        for _, sibling in pairs(window.mainFrame:GetChildren()) do
            if sibling:IsA("ScrollingFrame") then
                sibling.Visible = false
            end
        end
        tabContent.Visible = true
    end)

    table.insert(window.tabs, tabContent)

    function tabContent:CreateButton(name, callback)
        local button = UILibrary:Create("TextButton", {
            Name = name,
            Parent = self,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            BorderSizePixel = 0,
            Size = UDim2.new(0.98, 0, 0, 40),
            Font = Enum.Font.FredokaOne,
            Text = name,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 24,
            TextXAlignment = Enum.TextXAlignment.Left
        })

        UILibrary:Create("UICorner", {
            CornerRadius = UDim.new(0, 10),
            Parent = button
        })

        UILibrary:Create("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = button
        })

        button.MouseButton1Click:Connect(callback)
    end

    function tabContent:CreateSlider(name, callback)
        local sliderHolder = UILibrary:Create("Frame", {
            Name = name .. "Holder",
            Parent = self,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            Size = UDim2.new(0.98, 0, 0, 70)
        })

        UILibrary:Create("UICorner", {
            CornerRadius = UDim.new(0, 10),
            Parent = sliderHolder
        })

        UILibrary:Create("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = sliderHolder
        })

        local sliderBar = UILibrary:Create("Frame", {
            Name = name .. "Bar",
            Parent = sliderHolder,
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            Position = UDim2.new(0.0222514309, 0, 0.530658782, -5),
            Size = UDim2.new(0.97, 0, 0.4, 0)
        })

        UILibrary:Create("UICorner", {
            CornerRadius = UDim.new(0, 99),
            Parent = sliderBar
        })

        UILibrary:Create("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = sliderBar
        })

        local slider = UILibrary:Create("Frame", {
            Name = name,
            Parent = sliderBar,
            BackgroundColor3 = Color3.fromRGB(0, 71, 255),
            Position = UDim2.new(0, 0, 0.5, -20),
            Size = UDim2.new(0, 44, 0, 40)
        })

        UILibrary:Create("UICorner", {
            CornerRadius = UDim.new(1, 0),
            Parent = slider
        })

        UILibrary:Create("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = slider
        })

        local sliderValue = UILibrary:Create("TextLabel", {
            Name = name .. "Value",
            Parent = sliderHolder,
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1.000,
            Position = UDim2.new(0.906082153, 0, 0.247234434, 0),
            Size = UDim2.new(0.184561253, 0, 0.440564632, 0),
            Font = Enum.Font.GothamBold,
            Text = "50",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 24.000
        })

        local UserInputService = game:GetService("UserInputService")

        local function moveSlider(input)
            local posX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
            local offset = 22 -- Half the width of the slider to ensure it doesn't go off the frame
            slider.Position = UDim2.new(posX, -offset, 0.5, -20)
            sliderValue.Text = tostring(math.floor(posX * 100))
            callback(math.floor(posX * 100))
        end

        slider.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                moveSlider(input)
                slider.BackgroundColor3 = Color3.fromRGB(0, 71, 255) -- Change color to blue after dragging
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
                slider.BackgroundColor3 = Color3.fromRGB(0, 71, 255) -- Change color to blue after dragging
            end
        end)
    end

    function tabContent:CreateToggle(name, callback)
        local toggleHolder = UILibrary:Create("Frame", {
            Name = name .. "Holder",
            Parent = self,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            Size = UDim2.new(0.98, 0, 0, 70)
        })

        UILibrary:Create("UICorner", {
            CornerRadius = UDim.new(0, 10),
            Parent = toggleHolder
        })

        UILibrary:Create("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = toggleHolder
        })

        local toggleBar = UILibrary:Create("Frame", {
            Name = name .. "Bar",
            Parent = toggleHolder,
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            Position = UDim2.new(0.75, 0, 0.5, -15),
            Size = UDim2.new(0.2, 0, 0.5, 0)
        })

        UILibrary:Create("UICorner", {
            CornerRadius = UDim.new(0, 99),
            Parent = toggleBar
        })

        UILibrary:Create("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = toggleBar
        })

        local toggle = UILibrary:Create("Frame", {
            Name = name,
            Parent = toggleBar,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            Position = UDim2.new(0, 0, 0.5, -18.5),
            Size = UDim2.new(0, 37, 0, 37)
        })

        UILibrary:Create("UICorner", {
            CornerRadius = UDim.new(1, 0),
            Parent = toggle
        })

        UILibrary:Create("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = toggle
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
                callback(toggleState)
            end
        end)
    end

    function tabContent:CreateDropdown(name, items, multiSelect, callback)
        local dropdownHolder = UILibrary:Create("Frame", {
            Name = name .. "Holder",
            Parent = self,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            Size = UDim2.new(0.98, 0, 0, 70)
        })

        UILibrary:Create("UICorner", {
            CornerRadius = UDim.new(0, 10),
            Parent = dropdownHolder
        })

        UILibrary:Create("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = dropdownHolder
        })

        local dropdownButton = UILibrary:Create("TextButton", {
            Name = name .. "Button",
            Parent = dropdownHolder,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            BackgroundTransparency = 1.000,
            BorderSizePixel = 0,
            Position = UDim2.new(0.0199999996, 0, 0.100000001, 0),
            Size = UDim2.new(0.980000019, 0, 0, 70),
            Font = Enum.Font.FredokaOne,
            Text = name,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 30.000,
            TextXAlignment = Enum.TextXAlignment.Left
        })

        UILibrary:Create("UICorner", {
            CornerRadius = UDim.new(0, 10),
            Parent = dropdownButton
        })

        UILibrary:Create("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = dropdownButton
        })

        local dropdownList = UILibrary:Create("Frame", {
            Name = name .. "List",
            Parent = dropdownHolder,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            ClipsDescendants = true,
            Position = UDim2.new(0.0199999996, 0, 0.800000012, 0),
            Size = UDim2.new(0.959999979, 0, 0, #items * 35),
            Visible = false
        })

        UILibrary:Create("UICorner", {
            CornerRadius = UDim.new(0, 10),
            Parent = dropdownList
        })

        UILibrary:Create("UIStroke", {
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
            Parent = dropdownList
        })

        local selectedItems = {}

        for i, item in ipairs(items) do
            local dropdownItem = UILibrary:Create("TextButton", {
                Name = item .. "Item",
                Parent = dropdownList,
                BackgroundColor3 = Color3.fromRGB(45, 45, 45),
                Position = UDim2.new(0, 5, 0, (i - 1) * 35),
                Size = UDim2.new(1, -10, 0, 30),
                Font = Enum.Font.FredokaOne,
                Text = item,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 24.000,
                TextXAlignment = Enum.TextXAlignment.Left
            })

            UILibrary:Create("UICorner", {
                CornerRadius = UDim.new(0, 10),
                Parent = dropdownItem
            })

            UILibrary:Create("UIStroke", {
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
                    for _, sibling in pairs(dropdownList:GetChildren()) do
                        if sibling:IsA("TextButton") then
                            sibling.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                            selectedItems[sibling.Text] = nil
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
                callback(selectedItems)
            end)
        end

        dropdownButton.MouseButton1Click:Connect(function()
            dropdownList.Visible = not dropdownList.Visible
        end)
    end

    return tabContent
end

return UILibrary
