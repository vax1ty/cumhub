-- UILibrary
local UILibrary = {}
UILibrary.__index = UILibrary

function UILibrary:CreateWindow(title)
    local window = {}
    setmetatable(window, UILibrary)
    
    -- Main window setup
    window.Gui = Instance.new("ScreenGui")
    window.Gui.Name = "UILibrary"
    window.Gui.Parent = game:GetService("CoreGui")

    window.MainFrame = Instance.new("Frame", window.Gui)
    window.MainFrame.Size = UDim2.new(0, 400, 0, 600)
    window.MainFrame.Position = UDim2.new(0.5, -200, 0.5, -300)
    window.MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    
    window.UICorner = Instance.new("UICorner", window.MainFrame)
    window.UICorner.CornerRadius = UDim.new(0, 10)
    
    window.UIStroke = Instance.new("UIStroke", window.MainFrame)
    window.UIStroke.Color = Color3.fromRGB(0, 0, 0)
    window.UIStroke.Thickness = 2
    
    window.TopBar = Instance.new("Frame", window.MainFrame)
    window.TopBar.Size = UDim2.new(1, 0, 0, 50)
    window.TopBar.BackgroundColor3 = Color3.fromRGB(45, 45, 48)
    
    window.UICorner2 = Instance.new("UICorner", window.TopBar)
    window.UICorner2.CornerRadius = UDim.new(0, 10)
    
    window.UIStroke2 = Instance.new("UIStroke", window.TopBar)
    window.UIStroke2.Color = Color3.fromRGB(0, 0, 0)
    window.UIStroke2.Thickness = 2
    
    window.Title = Instance.new("TextLabel", window.TopBar)
    window.Title.Size = UDim2.new(1, 0, 1, 0)
    window.Title.BackgroundTransparency = 1
    window.Title.Text = title
    window.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    window.Title.Font = Enum.Font.GothamBold
    window.Title.TextSize = 24
    
    window.CloseButton = Instance.new("TextButton", window.TopBar)
    window.CloseButton.Size = UDim2.new(0, 50, 1, 0)
    window.CloseButton.Position = UDim2.new(1, -50, 0, 0)
    window.CloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    window.CloseButton.Text = "X"
    window.CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    window.CloseButton.Font = Enum.Font.GothamBold
    window.CloseButton.TextSize = 24
    
    window.UICorner3 = Instance.new("UICorner", window.CloseButton)
    window.UICorner3.CornerRadius = UDim.new(0, 10)
    
    window.UIStroke3 = Instance.new("UIStroke", window.CloseButton)
    window.UIStroke3.Color = Color3.fromRGB(0, 0, 0)
    window.UIStroke3.Thickness = 2
    
    window.CloseButton.MouseButton1Click:Connect(function()
        window.Gui:Destroy()
    end)
    
    window.ContentHolder = Instance.new("ScrollingFrame", window.MainFrame)
    window.ContentHolder.Size = UDim2.new(1, -20, 1, -70)
    window.ContentHolder.Position = UDim2.new(0, 10, 0, 60)
    window.ContentHolder.CanvasSize = UDim2.new(0, 0, 1, 0)
    window.ContentHolder.BackgroundTransparency = 1
    window.ContentHolder.ScrollBarThickness = 0
    window.ContentHolder.ScrollingEnabled = false
    
    window.Tabs = {}
    window.CurrentTab = nil
    
    return window
end

function UILibrary:CreateTab(title)
    local tab = {}
    tab.Title = title
    tab.Holder = Instance.new("Frame", self.ContentHolder)
    tab.Holder.Size = UDim2.new(1, 0, 1, 0)
    tab.Holder.Visible = false
    tab.Holder.BackgroundTransparency = 1
    
    if not self.CurrentTab then
        self.CurrentTab = tab
        tab.Holder.Visible = true
    end
    
    table.insert(self.Tabs, tab)
    self:UpdateTabs()
    
    return tab
end

function UILibrary:UpdateTabs()
    local tabHolder = Instance.new("Frame", self.MainFrame)
    tabHolder.Size = UDim2.new(1, 0, 0, 50)
    tabHolder.Position = UDim2.new(0, 0, 0, 50)
    tabHolder.BackgroundTransparency = 1
    
    for i, tab in ipairs(self.Tabs) do
        local tabButton = Instance.new("TextButton", tabHolder)
        tabButton.Size = UDim2.new(1/#self.Tabs, 0, 1, 0)
        tabButton.Position = UDim2.new((i-1)/#self.Tabs, 0, 0, 0)
        tabButton.Text = tab.Title
        tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 48)
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Font = Enum.Font.GothamBold
        tabButton.TextSize = 20
        
        tabButton.MouseButton1Click:Connect(function()
            if self.CurrentTab then
                self.CurrentTab.Holder.Visible = false
            end
            self.CurrentTab = tab
            self.CurrentTab.Holder.Visible = true
        end)
    end
end

function UILibrary:CreateButton(tab, title, callback)
    local button = Instance.new("TextButton", tab.Holder)
    button.Size = UDim2.new(0.9, 0, 0, 50)
    button.Position = UDim2.new(0.05, 0, 0, #tab.Holder:GetChildren() * 60)
    button.Text = title
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 20
    
    local uiCorner = Instance.new("UICorner", button)
    uiCorner.CornerRadius = UDim.new(0, 10)
    
    local uiStroke = Instance.new("UIStroke", button)
    uiStroke.Color = Color3.fromRGB(0, 0, 0)
    uiStroke.Thickness = 2
    
    button.MouseButton1Click:Connect(callback)
end

function UILibrary:CreateSlider(tab, min, max, initial, callback)
    local holder = Instance.new("Frame", tab.Holder)
    holder.Size = UDim2.new(0.9, 0, 0, 70)
    holder.Position = UDim2.new(0.05, 0, 0, #tab.Holder:GetChildren() * 80)
    holder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    
    local uiCorner = Instance.new("UICorner", holder)
    uiCorner.CornerRadius = UDim.new(0, 10)
    
    local uiStroke = Instance.new("UIStroke", holder)
    uiStroke.Color = Color3.fromRGB(0, 0, 0)
    uiStroke.Thickness = 2
    
    local sliderBar = Instance.new("Frame", holder)
    sliderBar.Size = UDim2.new(0.95, 0, 0.4, 0)
    sliderBar.Position = UDim2.new(0.025, 0, 0.6, -10)
    sliderBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    
    local sliderCorner = Instance.new("UICorner", sliderBar)
    sliderCorner.CornerRadius = UDim.new(0, 99)
    
    local sliderStroke = Instance.new("UIStroke", sliderBar)
    sliderStroke.Color = Color3.fromRGB(0, 0, 0)
    sliderStroke.Thickness = 2
    
    local slider = Instance.new("Frame", sliderBar)
    slider.Size = UDim2.new(0, 20, 1, 0)
    slider.Position = UDim2.new((initial-min)/(max-min), 0, 0, 0)
    slider.BackgroundColor3 = Color3.fromRGB(0, 71, 255)
    
    local sliderUIStroke = Instance.new("UIStroke", slider)
    sliderUIStroke.Color = Color3.fromRGB(0, 0, 0)
    sliderUIStroke.Thickness = 2
    
    local sliderCorner2 = Instance.new("UICorner", slider)
    sliderCorner2.CornerRadius = UDim.new(0, 99)
    
    local valueLabel = Instance.new("TextLabel", holder)
    valueLabel.Size = UDim2.new(0.2, 0, 0.4, 0)
    valueLabel.Position = UDim2.new(0.7, 0, 0.1, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(initial)
    valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 20
    
    local dragging = false
    local inputService = game:GetService("UserInputService")
    
    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        slider.Position = UDim2.new(pos, 0, 0, 0)
        local value = math.floor(pos * (max - min) + min)
        valueLabel.Text = tostring(value)
        callback(value)
    end
    
    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateSlider(input)
        end
    end)
    
    slider.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    inputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
end

function UILibrary:CreateToggle(tab, title, initial, callback)
    local holder = Instance.new("Frame", tab.Holder)
    holder.Size = UDim2.new(0.9, 0, 0, 70)
    holder.Position = UDim2.new(0.05, 0, 0, #tab.Holder:GetChildren() * 80)
    holder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    
    local uiCorner = Instance.new("UICorner", holder)
    uiCorner.CornerRadius = UDim.new(0, 10)
    
    local uiStroke = Instance.new("UIStroke", holder)
    uiStroke.Color = Color3.fromRGB(0, 0, 0)
    uiStroke.Thickness = 2
    
    local label = Instance.new("TextLabel", holder)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.FredokaOne
    label.TextSize = 24
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBar = Instance.new("Frame", holder)
    toggleBar.Size = UDim2.new(0.2, 0, 0.5, 0)
    toggleBar.Position = UDim2.new(0.75, 0, 0.25, 0)
    toggleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    
    local toggleCorner = Instance.new("UICorner", toggleBar)
    toggleCorner.CornerRadius = UDim.new(0, 99)
    
    local toggleStroke = Instance.new("UIStroke", toggleBar)
    toggleStroke.Color = Color3.fromRGB(0, 0, 0)
    toggleStroke.Thickness = 2
    
    local toggle = Instance.new("Frame", toggleBar)
    toggle.Size = UDim2.new(0.5, 0, 1, 0)
    toggle.BackgroundColor3 = initial and Color3.fromRGB(0, 71, 255) or Color3.fromRGB(35, 35, 35)
    toggle.Position = initial and UDim2.new(0.5, 0, 0, 0) or UDim2.new(0, 0, 0, 0)
    
    local toggleUIStroke = Instance.new("UIStroke", toggle)
    toggleUIStroke.Color = Color3.fromRGB(0, 0, 0)
    toggleUIStroke.Thickness = 2
    
    local toggleCorner2 = Instance.new("UICorner", toggle)
    toggleCorner2.CornerRadius = UDim.new(0, 99)
    
    local toggleState = initial
    
    local function setToggle(state)
        toggleState = state
        if state then
            toggle:TweenPosition(UDim2.new(0.5, 0, 0, 0), "Out", "Sine", 0.2, true)
            toggle.BackgroundColor3 = Color3.fromRGB(0, 71, 255)
        else
            toggle:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Sine", 0.2, true)
            toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        end
        callback(state)
    end
    
    toggleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            setToggle(not toggleState)
        end
    end)
end

function UILibrary:CreateDropdown(tab, title, items, multiSelect, callback)
    local holder = Instance.new("Frame", tab.Holder)
    holder.Size = UDim2.new(0.9, 0, 0, 70)
    holder.Position = UDim2.new(0.05, 0, 0, #tab.Holder:GetChildren() * 80)
    holder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    
    local uiCorner = Instance.new("UICorner", holder)
    uiCorner.CornerRadius = UDim.new(0, 10)
    
    local uiStroke = Instance.new("UIStroke", holder)
    uiStroke.Color = Color3.fromRGB(0, 0, 0)
    uiStroke.Thickness = 2
    
    local button = Instance.new("TextButton", holder)
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = title
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.FredokaOne
    button.TextSize = 24
    button.TextXAlignment = Enum.TextXAlignment.Left
    
    local listHolder = Instance.new("Frame", holder)
    listHolder.Size = UDim2.new(1, 0, 0, 0)
    listHolder.Position = UDim2.new(0, 0, 1, 0)
    listHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    listHolder.Visible = false
    listHolder.ClipsDescendants = true
    
    local listCorner = Instance.new("UICorner", listHolder)
    listCorner.CornerRadius = UDim.new(0, 10)
    
    local listStroke = Instance.new("UIStroke", listHolder)
    listStroke.Color = Color3.fromRGB(0, 0, 0)
    listStroke.Thickness = 2
    
    local selectedItems = {}
    
    button.MouseButton1Click:Connect(function()
        listHolder.Visible = not listHolder.Visible
        if listHolder.Visible then
            local totalHeight = #items * 30 + (#items - 1) * 5 + 10
            listHolder:TweenSize(UDim2.new(1, 0, 0, totalHeight), "Out", "Sine", 0.3, true)
        else
            listHolder:TweenSize(UDim2.new(1, 0, 0, 0), "Out", "Sine", 0.3, true)
        end
    end)
    
    for i, item in ipairs(items) do
        local listItem = Instance.new("TextButton", listHolder)
        listItem.Size = UDim2.new(1, -10, 0, 30)
        listItem.Position = UDim2.new(0, 5, 0, (i-1) * 35 + 5)
        listItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        listItem.Text = item
        listItem.TextColor3 = Color3.fromRGB(255, 255, 255)
        listItem.Font = Enum.Font.FredokaOne
        listItem.TextSize = 24
        listItem.TextXAlignment = Enum.TextXAlignment.Left
        
        local listItemCorner = Instance.new("UICorner", listItem)
        listItemCorner.CornerRadius = UDim.new(0, 10)
        
        local listItemStroke = Instance.new("UIStroke", listItem)
        listItemStroke.Color = Color3.fromRGB(0, 0, 0)
        listItemStroke.Thickness = 2
        
        listItem.MouseButton1Click:Connect(function()
            if multiSelect then
                if selectedItems[item] then
                    selectedItems[item] = nil
                    listItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                else
                    selectedItems[item] = true
                    listItem.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                end
            else
                for _, child in ipairs(listHolder:GetChildren()) do
                    if child:IsA("TextButton") then
                        child.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                        selectedItems[child.Text] = nil
                    end
                end
                selectedItems[item] = true
                listItem.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            end
            
            local selectedText = ""
            for key, _ in pairs(selectedItems) do
                if selectedText == "" then
                    selectedText = key
                else
                    selectedText = selectedText .. ", " .. key
                end
            end
            button.Text = selectedText == "" and title or selectedText
            callback(selectedItems)
        end)
    end
end

return UILibrary
