local UILibrary = {}

-- Helper function to create UI elements
local function createUIElement(elementType, properties)
    local element = Instance.new(elementType)
    for property, value in pairs(properties) do
        element[property] = value
    end
    return element
end

function UILibrary:CreateWindow(windowTitle)
    local screenGui = createUIElement("ScreenGui", {
        Name = "UILibrary",
        Parent = game.CoreGui,
        ResetOnSpawn = false,
    })

    local mainFrame = createUIElement("Frame", {
        Name = "MainFrame",
        Parent = screenGui,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 600, 0, 400),
        Draggable = true,
    })

    createUIElement("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = mainFrame,
    })

    createUIElement("UIStroke", {
        Parent = mainFrame,
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
    })

    local topBar = createUIElement("Frame", {
        Name = "TopBar",
        Parent = mainFrame,
        BackgroundColor3 = Color3.fromRGB(45, 45, 48),
        Size = UDim2.new(1, 0, 0, 50),
    })

    createUIElement("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = topBar,
    })

    createUIElement("UIStroke", {
        Parent = topBar,
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
    })

    createUIElement("TextLabel", {
        Name = "Title",
        Parent = topBar,
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0.8, 0, 1, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Font = Enum.Font.GothamBold,
        Text = windowTitle,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 24,
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
        TextSize = 24,
    })

    createUIElement("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = closeButton,
    })

    createUIElement("UIStroke", {
        Parent = closeButton,
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
    })

    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    local minimizeButton = createUIElement("TextButton", {
        Name = "MinimizeButton",
        Parent = topBar,
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        BorderSizePixel = 0,
        Position = UDim2.new(1, -90, 0, 5),
        Size = UDim2.new(0, 40, 0, 40),
        Font = Enum.Font.GothamBold,
        Text = "-",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 24,
    })

    createUIElement("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = minimizeButton,
    })

    createUIElement("UIStroke", {
        Parent = minimizeButton,
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
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

    local tabHolder = createUIElement("Frame", {
        Name = "TabHolder",
        Parent = mainFrame,
        BackgroundColor3 = Color3.fromRGB(45, 45, 48),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.0933333337, 0),
        Size = UDim2.new(1, 0, 0.0616666675, 0),
    })

    local contentHolder = createUIElement("ScrollingFrame", {
        Name = "ContentHolder",
        Parent = mainFrame,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.0250000004, 0, 0.200000003, 0),
        Size = UDim2.new(0.935000002, 0, 0.800000012, 0),
        CanvasSize = UDim2.new(0, 0, 1.2, 0),
        ScrollBarThickness = 6,
    })

    createUIElement("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = contentHolder,
    })

    local tabs = {}

    function UILibrary:AddTab(tabName)
        local tab = createUIElement("TextButton", {
            Name = tabName .. "Tab",
            Parent = tabHolder,
            BackgroundColor3 = Color3.fromRGB(48, 48, 53),
            Size = UDim2.new(0.2, 0, 0.8, 0),
            Font = Enum.Font.FredokaOne,
            Text = tabName,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 24,
            AutomaticSize = Enum.AutomaticSize.X,
        })

        createUIElement("UICorner", {
            CornerRadius = UDim.new(0, 10),
            Parent = tab,
        })

        createUIElement("UIStroke", {
            Parent = tab,
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 2,
        })

        local tabContent = createUIElement("Frame", {
            Name = tabName .. "Content",
            Parent = contentHolder,
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = false,
        })

        tabs[tabName] = tabContent

        tab.MouseButton1Click:Connect(function()
            for _, content in pairs(tabs) do
                content.Visible = false
            end
            tabContent.Visible = true
        end)

        if #tabHolder:GetChildren() == 1 then
            tabContent.Visible = true
        end

        local function createUIElementWrapper(elementType, properties)
            local element = createUIElement(elementType, properties)
            element.Parent = tabContent
            return element
        end

        function tabContent:CreateButton(buttonName, callback)
            local buttonHolder = createUIElementWrapper("Frame", {
                Name = buttonName .. "Holder",
                BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                Size = UDim2.new(0.98, 0, 0, 70),
            })

            createUIElement("UICorner", {
                CornerRadius = UDim.new(0, 10),
                Parent = buttonHolder,
            })

            createUIElement("UIStroke", {
                Parent = buttonHolder,
                Color = Color3.fromRGB(0, 0, 0),
                Thickness = 2,
            })

            local button = createUIElementWrapper("TextButton", {
                Name = buttonName,
                Parent = buttonHolder,
                BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0.02, 0, 0.1, 0),
                Size = UDim2.new(0.96, 0, 0.8, 0),
                Font = Enum.Font.FredokaOne,
                Text = buttonName,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 30,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            createUIElement("UICorner", {
                CornerRadius = UDim.new(0, 10),
                Parent = button,
            })

            createUIElement("UIStroke", {
                Parent = button,
                Color = Color3.fromRGB(0, 0, 0),
                Thickness = 2,
            })

            button.MouseButton1Click:Connect(callback)
        end

        function tabContent:CreateSlider(sliderName, minValue, maxValue, callback)
            local sliderHolder = createUIElementWrapper("Frame", {
                Name = sliderName .. "Holder",
                BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                Size = UDim2.new(0.98, 0, 0, 70),
            })

            createUIElement("UICorner", {
                CornerRadius = UDim.new(0, 10),
                Parent = sliderHolder,
            })

            createUIElement("UIStroke", {
                Parent = sliderHolder,
                Color = Color3.fromRGB(0, 0, 0),
                Thickness = 2,
            })

            local sliderBar = createUIElementWrapper("Frame", {
                Name = sliderName .. "Bar",
                Parent = sliderHolder,
                BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                Position = UDim2.new(0.02, 0, 0.6, -5),
                Size = UDim2.new(0.96, 0, 0.4, 0),
            })

            createUIElement("UICorner", {
                CornerRadius = UDim.new(0, 99),
                Parent = sliderBar,
            })

            createUIElement("UIStroke", {
                Parent = sliderBar,
                Color = Color3.fromRGB(0, 0, 0),
                Thickness = 2,
            })

            local slider = createUIElementWrapper("Frame", {
                Name = sliderName,
                Parent = sliderBar,
                BackgroundColor3 = Color3.fromRGB(0, 71, 255),
                Position = UDim2.new(0, 0, 0.5, -20),
                Size = UDim2.new(0, 44, 0, 40),
            })

            createUIElement("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = slider,
            })

            createUIElement("UIStroke", {
                Parent = slider,
                Color = Color3.fromRGB(0, 0, 0),
                Thickness = 2,
            })

            local sliderValue = createUIElementWrapper("TextLabel", {
                Name = sliderName .. "Value",
                Parent = sliderHolder,
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.9, 0, 0.2, 0),
                Size = UDim2.new(0.2, 0, 0.5, 0),
                Font = Enum.Font.GothamBold,
                Text = tostring(minValue),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 24,
            })

            local UserInputService = game:GetService("UserInputService")

            local function moveSlider(input)
                local posX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
                slider.Position = UDim2.new(posX, -22, 0.5, -20)
                local value = math.floor(posX * (maxValue - minValue) + minValue)
                sliderValue.Text = tostring(value)
                callback(value)
            end

            slider.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    moveSlider(input)
                    slider.BackgroundColor3 = Color3.fromRGB(0, 71, 255)
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
                    slider.BackgroundColor3 = Color3.fromRGB(0, 71, 255)
                end
            end)
        end

        function tabContent:CreateToggle(toggleName, initialState, callback)
            local toggleHolder = createUIElementWrapper("Frame", {
                Name = toggleName .. "Holder",
                BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                Size = UDim2.new(0.98, 0, 0, 70),
            })

            createUIElement("UICorner", {
                CornerRadius = UDim.new(0, 10),
                Parent = toggleHolder,
            })

            createUIElement("UIStroke", {
                Parent = toggleHolder,
                Color = Color3.fromRGB(0, 0, 0),
                Thickness = 2,
            })

            local toggleBar = createUIElementWrapper("Frame", {
                Name = toggleName .. "Bar",
                Parent = toggleHolder,
                BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                Position = UDim2.new(0.75, 0, 0.5, -15),
                Size = UDim2.new(0.2, 0, 0.5, 0),
            })

            createUIElement("UICorner", {
                CornerRadius = UDim.new(0, 99),
                Parent = toggleBar,
            })

            createUIElement("UIStroke", {
                Parent = toggleBar,
                Color = Color3.fromRGB(0, 0, 0),
                Thickness = 2,
            })

            local toggle = createUIElementWrapper("Frame", {
                Name = toggleName,
                Parent = toggleBar,
                BackgroundColor3 = initialState and Color3.fromRGB(0, 71, 255) or Color3.fromRGB(35, 35, 35),
                Position = initialState and UDim2.new(1, -37, 0.5, -18.5) or UDim2.new(0, 0, 0.5, -18.5),
                Size = UDim2.new(0, 37, 0, 37),
            })

            createUIElement("UICorner", {
                CornerRadius = UDim.new(1, 0),
                Parent = toggle,
            })

            createUIElement("UIStroke", {
                Parent = toggle,
                Color = Color3.fromRGB(0, 0, 0),
                Thickness = 2,
            })

            local toggleLabel = createUIElementWrapper("TextLabel", {
                Name = toggleName .. "Label",
                Parent = toggleHolder,
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.3, 0, 0.5, 0),
                Size = UDim2.new(0.6, -20, 0.8, -20),
                Font = Enum.Font.FredokaOne,
                Text = toggleName,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 30,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            local function setToggleState(state)
                toggle:TweenPosition(state and UDim2.new(1, -37, 0.5, -18.5) or UDim2.new(0, 0, 0.5, -18.5), "Out", "Sine", 0.2, true)
                toggle.BackgroundColor3 = state and Color3.fromRGB(0, 71, 255) or Color3.fromRGB(35, 35, 35)
                callback(state)
            end

            local toggleState = initialState

            toggleBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    toggleState = not toggleState
                    setToggleState(toggleState)
                end
            end)
        end

        function tabContent:CreateDropdown(dropdownName, items, multiSelect, callback)
            local dropdownHolder = createUIElementWrapper("Frame", {
                Name = dropdownName .. "Holder",
                BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                Size = UDim2.new(0.98, 0, 0, 70),
            })

            createUIElement("UICorner", {
                CornerRadius = UDim.new(0, 10),
                Parent = dropdownHolder,
            })

            createUIElement("UIStroke", {
                Parent = dropdownHolder,
                Color = Color3.fromRGB(0, 0, 0),
                Thickness = 2,
            })

            local dropdownButton = createUIElementWrapper("TextButton", {
                Name = dropdownName .. "Button",
                Parent = dropdownHolder,
                BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0.02, 0, 0.1, 0),
                Size = UDim2.new(0.96, 0, 0.8, 0),
                Font = Enum.Font.FredokaOne,
                Text = dropdownName,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 30,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            createUIElement("UICorner", {
                CornerRadius = UDim.new(0, 10),
                Parent = dropdownButton,
            })

            createUIElement("UIStroke", {
                Parent = dropdownButton,
                Color = Color3.fromRGB(0, 0, 0),
                Thickness = 2,
            })

            local dropdownList = createUIElementWrapper("Frame", {
                Name = dropdownName .. "List",
                Parent = dropdownHolder,
                BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                ClipsDescendants = true,
                Position = UDim2.new(0.02, 0, 0.9, 0),
                Size = UDim2.new(0.96, 0, 0, 150),
                Visible = false,
            })

            createUIElement("UICorner", {
                CornerRadius = UDim.new(0, 10),
                Parent = dropdownList,
            })

            createUIElement("UIStroke", {
                Parent = dropdownList,
                Color = Color3.fromRGB(0, 0, 0),
                Thickness = 2,
            })

            local selectedItems = {}

            for i, itemText in ipairs(items) do
                local dropdownItem = createUIElementWrapper("TextButton", {
                    Name = dropdownName .. "Item" .. i,
                    Parent = dropdownList,
                    BackgroundColor3 = Color3.fromRGB(45, 45, 45),
                    Position = UDim2.new(0, 5, 0, (i - 1) * 35),
                    Size = UDim2.new(1, -10, 0, 30),
                    Font = Enum.Font.FredokaOne,
                    Text = itemText,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 24,
                    TextXAlignment = Enum.TextXAlignment.Left,
                })

                createUIElement("UICorner", {
                    CornerRadius = UDim.new(0, 10),
                    Parent = dropdownItem,
                })

                createUIElement("UIStroke", {
                    Parent = dropdownItem,
                    Color = Color3.fromRGB(0, 0, 0),
                    Thickness = 2,
                })

                dropdownItem.MouseEnter:Connect(function()
                    dropdownItem.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                end)

                dropdownItem.MouseLeave:Connect(function()
                    dropdownItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                end)

                dropdownItem.MouseButton1Click:Connect(function()
                    if multiSelect then
                        if selectedItems[dropdownItem.Text] then
                            selectedItems[dropdownItem.Text] = nil
                            dropdownItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                        else
                            selectedItems[dropdownItem.Text] = true
                            dropdownItem.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                        end
                    else
                        for _, item in pairs(dropdownList:GetChildren()) do
                            if item:IsA("TextButton") then
                                item.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                                selectedItems[item.Text] = nil
                            end
                        end
                        selectedItems[dropdownItem.Text] = true
                        dropdownItem.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                    end

                    local selectedText = ""
                    for item, _ in pairs(selectedItems) do
                        if selectedText == "" then
                            selectedText = item
                        else
                            selectedText = selectedText .. ", " .. item
                        end
                    end
                    dropdownButton.Text = selectedText == "" and dropdownName or selectedText
                    callback(selectedText)
                end)
            end

            dropdownButton.MouseButton1Click:Connect(function()
                dropdownList.Visible = not dropdownList.Visible
                dropdownList.Size = UDim2.new(0.96, 0, 0, #items * 35)
            end)
        end

        return tabContent
    end

    return UILibrary
end

return UILibrary
