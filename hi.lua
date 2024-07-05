local UILibrary = {}

-- Utility function to create a UI Stroke
local function createUIStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Parent = parent
    stroke.Color = color
    stroke.Thickness = thickness
    return stroke
end

-- Utility function to create a UI Corner
local function createUICorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
    return corner
end

-- Function to create a button
local function createButton(parent, text, size, position, callback)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.BorderSizePixel = 0
    button.Position = position
    button.Size = size
    button.Font = Enum.Font.GothamBold
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 24
    button.MouseButton1Click:Connect(callback)
    createUICorner(button, 10)
    createUIStroke(button, Color3.fromRGB(0, 0, 0), 2)
    return button
end

-- Function to create the main window
function UILibrary:CreateWindow(title)
    local windowInstance = {}

    local gui = Instance.new("ScreenGui")
    gui.Name = "Confirmation"
    gui.Parent = game.CoreGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Parent = gui
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.Size = UDim2.new(0, 602, 0, 673)
    mainFrame.Active = true
    mainFrame.Draggable = true
    createUICorner(mainFrame, 10)
    createUIStroke(mainFrame, Color3.fromRGB(0, 0, 0), 2)

    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Parent = mainFrame
    topBar.BackgroundColor3 = Color3.fromRGB(45, 45, 48)
    topBar.Size = UDim2.new(1, 0, 0, 50)
    createUICorner(topBar, 10)
    createUIStroke(topBar, Color3.fromRGB(0, 0, 0), 2)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Parent = topBar
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 24
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Position = UDim2.new(0.05, 0, 0, 0)

    local closeButton = createButton(topBar, "X", UDim2.new(0, 40, 0, 40), UDim2.new(1, -45, 0, 5), function()
        gui:Destroy()
    end)

    local minimizeButton = createButton(topBar, "-", UDim2.new(0, 40, 0, 40), UDim2.new(1, -90, 0, 5), function()
        mainFrame.Visible = not mainFrame.Visible
    end)

    local tabHolder = Instance.new("ScrollingFrame")
    tabHolder.Name = "TabHolder"
    tabHolder.Parent = mainFrame
    tabHolder.BackgroundTransparency = 1
    tabHolder.Position = UDim2.new(0.025, 0, 0.093, 0)
    tabHolder.Size = UDim2.new(0.95, 0, 0.0617, 0)
    tabHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabHolder.ScrollBarThickness = 0
    tabHolder.AutomaticCanvasSize = Enum.AutomaticSize.X

    local uiListLayoutTabs = Instance.new("UIListLayout")
    uiListLayoutTabs.Parent = tabHolder
    uiListLayoutTabs.FillDirection = Enum.FillDirection.Horizontal
    uiListLayoutTabs.HorizontalAlignment = Enum.HorizontalAlignment.Left
    uiListLayoutTabs.Padding = UDim.new(0, 5)

    local uiPaddingTabs = Instance.new("UIPadding")
    uiPaddingTabs.Parent = tabHolder
    uiPaddingTabs.PaddingTop = UDim.new(0, 10)
    uiPaddingTabs.PaddingBottom = UDim.new(0, 10)
    uiPaddingTabs.PaddingLeft = UDim.new(0, 10)
    uiPaddingTabs.PaddingRight = UDim.new(0, 10)

    local contentHolder = Instance.new("Frame")
    contentHolder.Name = "ContentHolder"
    contentHolder.Parent = mainFrame
    contentHolder.BackgroundTransparency = 1
    contentHolder.Position = UDim2.new(0.025, 0, 0.2, 0)
    contentHolder.Size = UDim2.new(0.935, 0, 0.8, 0)
    createUICorner(contentHolder, 10)
    createUIStroke(contentHolder, Color3.fromRGB(0, 0, 0), 2)

    -- Function to add tabs
    function windowInstance:AddTab(tabName)
        local tab = {}

        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName
        tabButton.Parent = tabHolder
        tabButton.BackgroundColor3 = Color3.fromRGB(48, 48, 53)
        tabButton.Size = UDim2.new(0, 100, 0, 30)
        tabButton.Font = Enum.Font.FredokaOne
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.TextSize = 24
        tabButton.AutomaticSize = Enum.AutomaticSize.X
        createUICorner(tabButton, 10)
        createUIStroke(tabButton, Color3.fromRGB(0, 0, 0), 2)

        local tabContent = Instance.new("Frame")
        tabContent.Name = tabName .. "_Content"
        tabContent.Parent = contentHolder
        tabContent.BackgroundTransparency = 1
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.Visible = false

        local uiPaddingTabContent = Instance.new("UIPadding")
        uiPaddingTabContent.Parent = tabContent
        uiPaddingTabContent.PaddingTop = UDim.new(0, 10)
        uiPaddingTabContent.PaddingBottom = UDim.new(0, 10)
        uiPaddingTabContent.PaddingLeft = UDim.new(0, 10)
        uiPaddingTabContent.PaddingRight = UDim.new(0, 10)

        local uiListLayoutTabContent = Instance.new("UIListLayout")
        uiListLayoutTabContent.Parent = tabContent
        uiListLayoutTabContent.SortOrder = Enum.SortOrder.LayoutOrder
        uiListLayoutTabContent.Padding = UDim.new(0, 10)

        tabButton.MouseButton1Click:Connect(function()
            for _, child in ipairs(contentHolder:GetChildren()) do
                if child:IsA("Frame") then
                    child.Visible = false
                end
            end
            tabContent.Visible = true
        end)

        if #contentHolder:GetChildren() == 1 then
            tabContent.Visible = true
        end

        -- Functions to create UI elements within a tab
        function tab:CreateButton(text, callback)
            local buttonHolder = Instance.new("Frame")
            buttonHolder.Name = "ButtonHolder"
            buttonHolder.Parent = tabContent
            buttonHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            buttonHolder.Size = UDim2.new(1, 0, 0, 60)
            createUICorner(buttonHolder, 10)
            createUIStroke(buttonHolder, Color3.fromRGB(0, 0, 0), 2)

            local button = Instance.new("TextButton")
            button.Name = "Button"
            button.Parent = buttonHolder
            button.BackgroundTransparency = 1
            button.Size = UDim2.new(1, 0, 1, 0)
            button.Font = Enum.Font.FredokaOne
            button.Text = text
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.TextSize = 24
            button.TextXAlignment = Enum.TextXAlignment.Left
            button.MouseButton1Click:Connect(callback)
        end

        function tab:CreateSlider(text, min, max, callback)
            local sliderHolder = Instance.new("Frame")
           

 sliderHolder.Name = "SliderHolder"
            sliderHolder.Parent = tabContent
            sliderHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            sliderHolder.Size = UDim2.new(1, 0, 0, 80)
            createUICorner(sliderHolder, 10)
            createUIStroke(sliderHolder, Color3.fromRGB(0, 0, 0), 2)

            local sliderLabel = Instance.new("TextLabel")
            sliderLabel.Name = "SliderLabel"
            sliderLabel.Parent = sliderHolder
            sliderLabel.BackgroundTransparency = 1
            sliderLabel.Position = UDim2.new(0.05, 0, 0, 0)
            sliderLabel.Size = UDim2.new(0.9, 0, 0.4, 0)
            sliderLabel.Font = Enum.Font.FredokaOne
            sliderLabel.Text = text
            sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            sliderLabel.TextSize = 24
            sliderLabel.TextXAlignment = Enum.TextXAlignment.Left

            local sliderBar = Instance.new("Frame")
            sliderBar.Name = "SliderBar"
            sliderBar.Parent = sliderHolder
            sliderBar.BackgroundColor3 = Color3.fromRGB(48, 48, 53)
            sliderBar.Position = UDim2.new(0.05, 0, 0.5, -10)
            sliderBar.Size = UDim2.new(0.9, 0, 0.2, 0)
            createUICorner(sliderBar, 99)
            createUIStroke(sliderBar, Color3.fromRGB(0, 0, 0), 2)

            local sliderFill = Instance.new("Frame")
            sliderFill.Name = "SliderFill"
            sliderFill.Parent = sliderBar
            sliderFill.BackgroundColor3 = Color3.fromRGB(0, 71, 255)
            sliderFill.Size = UDim2.new(0, 0, 1, 0)
            createUICorner(sliderFill, 99)

            local slider = Instance.new("Frame")
            slider.Name = "Slider"
            slider.Parent = sliderBar
            slider.BackgroundColor3 = Color3.fromRGB(0, 71, 255)
            slider.Position = UDim2.new(0, 0, 0.5, -10)
            slider.Size = UDim2.new(0, 20, 0, 20)
            createUICorner(slider, 1)
            createUIStroke(slider, Color3.fromRGB(0, 0, 0), 2)

            local sliderValue = Instance.new("TextBox")
            sliderValue.Name = "SliderValue"
            sliderValue.Parent = sliderHolder
            sliderValue.AnchorPoint = Vector2.new(1, 0)
            sliderValue.BackgroundTransparency = 1
            sliderValue.Position = UDim2.new(1, -5, 0, 0)
            sliderValue.Size = UDim2.new(0, 50, 0.4, 0)
            sliderValue.Font = Enum.Font.FredokaOne
            sliderValue.Text = tostring(min)
            sliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
            sliderValue.TextSize = 24
            sliderValue.TextXAlignment = Enum.TextXAlignment.Right
            sliderValue.ClearTextOnFocus = false

            local UserInputService = game:GetService("UserInputService")
            local dragging = false

            local function moveSlider(input)
                local posX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
                local offset = slider.AbsoluteSize.X / 2
                slider.Position = UDim2.new(posX, -offset, 0.5, -10)
                sliderFill.Size = UDim2.new(posX, 0, 1, 0)
                local sliderValue = math.floor(min + (max - min) * posX)
                sliderValue.Text = tostring(sliderValue)
                callback(sliderValue)
            end

            slider.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
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
                            dragging = false
                            moveConnection:Disconnect()
                            releaseConnection:Disconnect()
                        end
                    end)
                end
            end)

            sliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
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
                            dragging = false
                            moveConnection:Disconnect()
                            releaseConnection:Disconnect()
                        end
                    end)
                end
            end)

            sliderValue.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    local value = tonumber(sliderValue.Text)
                    if value and value >= min and value <= max then
                        local posX = (value - min) / (max - min)
                        slider.Position = UDim2.new(posX, -slider.AbsoluteSize.X / 2, 0.5, -10)
                        sliderFill.Size = UDim2.new(posX, 0, 1, 0)
                        callback(value)
                    else
                        sliderValue.Text = tostring(min)
                    end
                end
            end)
        end

        function tab:CreateToggle(text, initialState, callback)
            local toggleHolder = Instance.new("Frame")
            toggleHolder.Name = "ToggleHolder"
            toggleHolder.Parent = tabContent
            toggleHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            toggleHolder.Size = UDim2.new(1, 0, 0, 50)
            createUICorner(toggleHolder, 10)
            createUIStroke(toggleHolder, Color3.fromRGB(0, 0, 0), 2)

            local toggleBar = Instance.new("Frame")
            toggleBar.Name = "ToggleBar"
            toggleBar.Parent = toggleHolder
            toggleBar.BackgroundColor3 = Color3.fromRGB(48, 48, 53)
            toggleBar.Position = UDim2.new(0.75, 0, 0.5, -15)
            toggleBar.Size = UDim2.new(0.2, 0, 0.5, 0)
            createUICorner(toggleBar, 99)
            createUIStroke(toggleBar, Color3.fromRGB(0, 0, 0), 2)

            local toggle = Instance.new("Frame")
            toggle.Name = "Toggle"
            toggle.Parent = toggleBar
            toggle.BackgroundColor3 = initialState and Color3.fromRGB(0, 71, 255) or Color3.fromRGB(35, 35, 35)
            toggle.Position = initialState and UDim2.new(1, -37, 0.5, -18.5) or UDim2.new(0, 0, 0.5, -18.5)
            toggle.Size = UDim2.new(0, 37, 0, 37)
            createUICorner(toggle, 1)
            createUIStroke(toggle, Color3.fromRGB(0, 0, 0), 2)

            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Name = "ToggleLabel"
            toggleLabel.Parent = toggleHolder
            toggleLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            toggleLabel.BackgroundTransparency = 1
            toggleLabel.Position = UDim2.new(0.3, 0, 0.5, 0)
            toggleLabel.Size = UDim2.new(0.6, -20, 0.8, -20)
            toggleLabel.Font = Enum.Font.FredokaOne
            toggleLabel.Text = text
            toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggleLabel.TextSize = 24
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local toggleState = initialState

            local function setToggleState(state)
                toggleState = state
                toggle.BackgroundColor3 = state and Color3.fromRGB(0, 71, 255) or Color3.fromRGB(35, 35, 35)
                toggle:TweenPosition(state and UDim2.new(1, -37, 0.5, -18.5) or UDim2.new(0, 0, 0.5, -18.5), "Out", "Sine", 0.2, true)
                callback(state)
            end

            toggleBar.InputBegan:Connect(function(input

)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    setToggleState(not toggleState)
                end
            end)

            return setToggleState
        end

        function tab:CreateDropdown(text, items, multiSelect, callback)
            local dropdownHolder = Instance.new("Frame")
            dropdownHolder.Name = "DropdownHolder"
            dropdownHolder.Parent = tabContent
            dropdownHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            dropdownHolder.Size = UDim2.new(1, 0, 0, 60)
            createUICorner(dropdownHolder, 10)
            createUIStroke(dropdownHolder, Color3.fromRGB(0, 0, 0), 2)

            local dropdownButton = Instance.new("TextButton")
            dropdownButton.Name = "DropdownButton"
            dropdownButton.Parent = dropdownHolder
            dropdownButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            dropdownButton.BackgroundTransparency = 1
            dropdownButton.BorderSizePixel = 0
            dropdownButton.Position = UDim2.new(0.02, 0, 0.1, 0)
            dropdownButton.Size = UDim2.new(0.98, 0, 0, 50)
            dropdownButton.Font = Enum.Font.FredokaOne
            dropdownButton.Text = text
            dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            dropdownButton.TextSize = 24
            dropdownButton.TextXAlignment = Enum.TextXAlignment.Left
            createUICorner(dropdownButton, 10)
            createUIStroke(dropdownButton, Color3.fromRGB(0, 0, 0), 2)

            local dropdownList = Instance.new("Frame")
            dropdownList.Name = "DropdownList"
            dropdownList.Parent = dropdownHolder
            dropdownList.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            dropdownList.ClipsDescendants = true
            dropdownList.Position = UDim2.new(0.02, 0, 0.8, 0)
            dropdownList.Size = UDim2.new(0.96, 0, 0, 150)
            dropdownList.Visible = false
            createUICorner(dropdownList, 10)
            createUIStroke(dropdownList, Color3.fromRGB(0, 0, 0), 2)

            local searchBar = Instance.new("TextBox")
            searchBar.Name = "SearchBar"
            searchBar.Parent = dropdownList
            searchBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            searchBar.Position = UDim2.new(0, 5, 0, 5)
            searchBar.Size = UDim2.new(1, -10, 0, 30)
            searchBar.Font = Enum.Font.FredokaOne
            searchBar.PlaceholderText = "Search..."
            searchBar.Text = ""
            searchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
            searchBar.TextSize = 24
            createUICorner(searchBar, 10)
            createUIStroke(searchBar, Color3.fromRGB(0, 0, 0), 2)

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
                dropdownButton.Text = selectedText == "" and text or selectedText
                callback(SelectedItems)
            end

            local function createDropdownItem(itemText)
                local dropdownItem = Instance.new("TextButton")
                dropdownItem.Name = itemText
                dropdownItem.Parent = dropdownList
                dropdownItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                dropdownItem.Size = UDim2.new(1, -10, 0, 30)
                dropdownItem.Font = Enum.Font.FredokaOne
                dropdownItem.Text = itemText
                dropdownItem.TextColor3 = Color3.fromRGB(255, 255, 255)
                dropdownItem.TextSize = 24
                dropdownItem.TextXAlignment = Enum.TextXAlignment.Left
                createUICorner(dropdownItem, 10)
                createUIStroke(dropdownItem, Color3.fromRGB(0, 0, 0), 2)

                dropdownItem.MouseEnter:Connect(function()
                    dropdownItem.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                end)
                dropdownItem.MouseLeave:Connect(function()
                    dropdownItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                end)
                dropdownItem.MouseButton1Click:Connect(function()
                    if multiSelect then
                        if SelectedItems[dropdownItem.Text] then
                            SelectedItems[dropdownItem.Text] = nil
                            dropdownItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                        else
                            SelectedItems[dropdownItem.Text] = true
                            dropdownItem.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                        end
                    else
                        for _, item in pairs(dropdownList:GetChildren()) do
                            if item:IsA("TextButton") then
                                item.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                                SelectedItems[item.Text] = nil
                            end
                        end
                        SelectedItems[dropdownItem.Text] = true
                        dropdownItem.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                    end
                    updateDropdown()
                end)

                return dropdownItem
            end

            for _, item in ipairs(items) do
                local itemFrame = createDropdownItem(item)
                table.insert(itemFrames, itemFrame)
            end

            local function filterItems(searchText)
                local yPos = 40
                for _, itemFrame in ipairs(itemFrames) do
                    if string.find(string.lower(itemFrame.Text), string.lower(searchText)) then
                        itemFrame.Position = UDim2.new(0, 5, 0, yPos)
                        itemFrame.Visible = true
                        yPos = yPos + 35
                    else
                        itemFrame.Visible = false
                    end
                end
                dropdownList.Size = UDim2.new(0.96, 0, 0, yPos + 5)
            end

            searchBar.Changed:Connect(function()
                filterItems(searchBar.Text)
            end)

            dropdownButton.MouseButton1Click:Connect(function()
                dropdownList.Visible = not dropdownList.Visible
            end)
        end

        return tab
    end

    return windowInstance
end

return UILibrary
