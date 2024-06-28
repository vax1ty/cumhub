local UILibrary = {}

-- Helper function to create instances
local function Create(instanceType, properties)
    local instance = Instance.new(instanceType)
    for property, value in pairs(properties) do
        instance[property] = value
    end
    return instance
end

-- Create the main window
function UILibrary:CreateWindow(title)
    local ScreenGui = Create("ScreenGui", {
        Name = title,
        Parent = game:GetService("CoreGui"),
    })

    local MainFrame = Create("Frame", {
        Parent = ScreenGui,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 602, 0, 673)
    })

    Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = MainFrame})
    Create("UIStroke", {Parent = MainFrame, Color = Color3.fromRGB(0, 0, 0), Thickness = 2})

    local TopBar = Create("Frame", {
        Parent = MainFrame,
        BackgroundColor3 = Color3.fromRGB(45, 45, 48),
        Size = UDim2.new(1, 0, 0, 50)
    })

    Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = TopBar})
    Create("UIStroke", {Parent = TopBar, Color = Color3.fromRGB(0, 0, 0), Thickness = 2})

    local Title = Create("TextLabel", {
        Parent = TopBar,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.8, 0, 1, 0),
        Font = Enum.Font.FredokaOne,
        Text = title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 24,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local CloseButton = Create("TextButton", {
        Parent = TopBar,
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        BorderSizePixel = 0,
        Position = UDim2.new(1, -45, 0, 5),
        Size = UDim2.new(0, 40, 0, 40),
        Font = Enum.Font.GothamBold,
        Text = "X",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 24
    })

    Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = CloseButton})
    Create("UIStroke", {Parent = CloseButton, Color = Color3.fromRGB(0, 0, 0), Thickness = 2})

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local MinimizeButton = Create("TextButton", {
        Parent = TopBar,
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        BorderSizePixel = 0,
        Position = UDim2.new(1, -90, 0, 5),
        Size = UDim2.new(0, 40, 0, 40),
        Font = Enum.Font.GothamBold,
        Text = "-",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 24
    })

    Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = MinimizeButton})
    Create("UIStroke", {Parent = MinimizeButton, Color = Color3.fromRGB(0, 0, 0), Thickness = 2})

    MinimizeButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
        MinimizeButton.Text = MainFrame.Visible and "-" or "+"
    end)

    local TabHolder = Create("Frame", {
        Parent = MainFrame,
        BackgroundColor3 = Color3.fromRGB(45, 45, 48),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.093, 0),
        Size = UDim2.new(1, 0, 0.062, 0)
    })

    local ContentHolder = Create("ScrollingFrame", {
        Parent = MainFrame,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.025, 0, 0.2, 0),
        Size = UDim2.new(0.935, 0, 0.8, 0),
        CanvasSize = UDim2.new(0, 0, 1.2, 0),
        ScrollBarThickness = 0,
        ScrollingEnabled = false
    })

    local tabs = {}
    
    local function CreateTab(tabName)
        local TabButton = Create("TextButton", {
            Parent = TabHolder,
            BackgroundColor3 = Color3.fromRGB(48, 48, 53),
            Position = UDim2.new(#tabs * 0.15 + 0.025, 0, 0.1, 0),
            Size = UDim2.new(0.15, 0, 0.8, 0),
            Font = Enum.Font.FredokaOne,
            Text = tabName,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 24,
            AutomaticSize = Enum.AutomaticSize.X
        })

        Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = TabButton})
        Create("UIStroke", {Parent = TabButton, Color = Color3.fromRGB(0, 0, 0), Thickness = 2})

        local TabFrame = Create("Frame", {
            Parent = ContentHolder,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = #tabs == 0
        })

        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(tabs) do
                tab.Frame.Visible = false
                tab.Button.BackgroundColor3 = Color3.fromRGB(48, 48, 53)
            end
            TabFrame.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        end)

        table.insert(tabs, {Button = TabButton, Frame = TabFrame})
        return TabFrame
    end

    local Window = {
        MainFrame = MainFrame,
        TabHolder = TabHolder,
        ContentHolder = ContentHolder,
        CreateTab = CreateTab
    }

    function Window:CreateButton(parent, position, size, text)
        local ButtonHolder = UILibrary:CreateFrame(parent, position, size, Color3.fromRGB(35, 35, 35))

        local Button = UILibrary:CreateButton(ButtonHolder, UDim2.new(0.02, 0, 0.1, 0), UDim2.new(0.96, 0, 0.8, 0), text)
        
        return ButtonHolder
    end

    function Window:CreateSlider(parent, position, size, initialValue)
        local SliderHolder = UILibrary:CreateFrame(parent, position, size, Color3.fromRGB(35, 35, 35))

        local SliderBar = UILibrary:CreateFrame(SliderHolder, UDim2.new(0.015, 0, 0.6, -5), UDim2.new(0.97, 0, 0.4, 0))
        Create("UICorner", {CornerRadius = UDim.new(0, 99), Parent = SliderBar})
        Create("UIStroke", {Parent = SliderBar, Color = Color3.fromRGB(0, 0, 0), Thickness = 2})

        local Slider = UILibrary:CreateFrame(SliderBar, UDim2.new(0, 0, 0.5, -20), UDim2.new(0, 44, 0, 40), Color3.fromRGB(0, 71, 255))
        Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Slider})
        Create("UIStroke", {Parent = Slider, Color = Color3.fromRGB(0, 0, 0), Thickness = 2})

        local SliderValue = Create("TextLabel", {
            Parent = SliderHolder,
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.906, 0, 0.247, 0),
            Size = UDim2.new(0.185, 0, 0.441, 0),
            Font = Enum.Font.GothamBold,
            Text = tostring(initialValue or 50),
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 24
        })

        local function moveSlider(input)
            local posX = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
            local offset = 22  -- Half the width of the slider to ensure it doesn't go off the frame
            Slider.Position = UDim2.new(posX, -offset, 0.5, -20)
            SliderValue.Text = tostring(math.floor(posX * 100))
            Slider.BackgroundColor3 = Color3.fromRGB(0, 71, 255)
        end

        local UserInputService = game:GetService("UserInputService")

        Slider.InputBegan:Connect(function(input)
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

        SliderBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                moveSlider(input)
            end
        end)

        return SliderHolder
    end

    function Window:CreateToggle(parent, position, size, initialState)
        local ToggleHolder = UILibrary:CreateFrame(parent, position, size, Color3.fromRGB(35, 35, 35))

        local ToggleBar = UILibrary:CreateFrame(ToggleHolder, UDim2.new(0.75, 0, 0.5, -15), UDim2.new(0.2, 0, 0.5, 0), Color3.fromRGB(30, 30, 30))
        Create("UICorner", {CornerRadius = UDim.new(0, 99), Parent = ToggleBar})
        Create("UIStroke", {Parent = ToggleBar, Color = Color3.fromRGB(0, 0, 0), Thickness = 2})

        local Toggle = UILibrary:CreateFrame(ToggleBar, UDim2.new(initialState and 1 or 0, -37, 0.5, -18.5), UDim2.new(0, 37, 0, 37), initialState and Color3.fromRGB(0, 71, 255) or Color3.fromRGB(35, 35, 35))
        Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Toggle})
        Create("UIStroke", {Parent = Toggle, Color = Color3.fromRGB(0, 0, 0), Thickness = 2})

        local toggleState = initialState

        local function setToggleState(state)
            if state then
                Toggle:TweenPosition(UDim2.new(1, -37, 0.5, -18.5), "Out", "Sine", 0.2, true)
                Toggle.BackgroundColor3 = Color3.fromRGB(0, 71, 255)
            else
                Toggle:TweenPosition(UDim2.new(0, 0, 0.5, -18.5), "Out", "Sine", 0.2, true)
                Toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            end
        end

        ToggleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                toggleState = not toggleState
                setToggleState(toggleState)
            end
        end)

        return ToggleHolder
    end

    function Window:CreateDropdown(parent, position, size, items, multiSelect)
        local DropdownHolder = UILibrary:CreateFrame(parent, position, size, Color3.fromRGB(35, 35, 35))

        local DropdownButton = UILibrary:CreateButton(DropdownHolder, UDim2.new(0.02, 0, 0.1, 0), UDim2.new(0.96, 0, 0.8, 0), "Dropdown")
        DropdownButton.TextXAlignment = Enum.TextXAlignment.Left

        local DropdownList = Create("Frame", {
            Parent = DropdownHolder,
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            ClipsDescendants = true,
            Position = UDim2.new(0.02, 0, 0.8, 0),
            Size = UDim2.new(0.96, 0, 0, 150),
            Visible = false
        })

        Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = DropdownList})
        Create("UIStroke", {Parent = DropdownList, Color = Color3.fromRGB(0, 0, 0), Thickness = 2})

        local SelectedItems = {}
        multiSelect = multiSelect == nil and true or multiSelect

        local function updateDropdownSize()
            local itemCount = #items
            DropdownList.Size = UDim2.new(0.96, 0, 0, itemCount * 35)
        end

        local function createDropdownItem(itemText, index)
            local DropdownItem = Create("TextButton", {
                Parent = DropdownList,
                BackgroundColor3 = Color3.fromRGB(45, 45, 45),
                Position = UDim2.new(0, 5, 0, (index - 1) * 35),
                Size = UDim2.new(1, -10, 0, 30),
                Font = Enum.Font.FredokaOne,
                Text = itemText,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 24,
                TextXAlignment = Enum.TextXAlignment.Left
            })

            Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = DropdownItem})
            Create("UIStroke", {Parent = DropdownItem, Color = Color3.fromRGB(0, 0, 0), Thickness = 2})

            DropdownItem.MouseEnter:Connect(function()
                DropdownItem.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            end)
            DropdownItem.MouseLeave:Connect(function()
                DropdownItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            end)

            DropdownItem.MouseButton1Click:Connect(function()
                if multiSelect then
                    if SelectedItems[itemText] then
                        SelectedItems[itemText] = nil
                        DropdownItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                    else
                        SelectedItems[itemText] = true
                        DropdownItem.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                    end
                else
                    for _, item in pairs(DropdownList:GetChildren()) do
                        if item:IsA("TextButton") then
                            item.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                            SelectedItems[item.Text] = nil
                        end
                    end
                    SelectedItems[itemText] = true
                    DropdownItem.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                end

                local selectedText = ""
                for item, _ in pairs(SelectedItems) do
                    if selectedText == "" then
                        selectedText = item
                    else
                        selectedText = selectedText .. ", " .. item
                    end
                end
                DropdownButton.Text = selectedText == "" and "Dropdown" or selectedText
            end)
        end

        for i, item in ipairs(items) do
            createDropdownItem(item, i)
        end

        updateDropdownSize()

        DropdownButton.MouseButton1Click:Connect(function()
            DropdownList.Visible = not DropdownList.Visible
        end)

        return DropdownHolder
    end

    return Window
end

-- Helper functions for creating common elements
function UILibrary:CreateFrame(parent, position, size, color)
    local Frame = Create("Frame", {
        Parent = parent,
        BackgroundColor3 = color,
        Position = position,
        Size = size
    })

    Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = Frame})
    Create("UIStroke", {Parent = Frame, Color = Color3.fromRGB(0, 0, 0), Thickness = 2})

    return Frame
end

function UILibrary:CreateButton(parent, position, size, text)
    local Button = Create("TextButton", {
        Parent = parent,
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = position,
        Size = size,
        Font = Enum.Font.FredokaOne,
        Text = text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 30,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = Button})
    Create("UIStroke", {Parent = Button, Color = Color3.fromRGB(0, 0, 0), Thickness = 2})

    return Button
end

return UILibrary
