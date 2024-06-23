-- Main Library Table
local CumhubLib = {}

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
	local Config = {}
	local ConfigF = "CumhubConfig"
	local FileName = "default"

	-- Default Colors
	local defaultColors = {
		backgroundColor = Color3.fromRGB(35, 35, 35),
		buttonColor = Color3.fromRGB(60, 60, 60),
		textColor = Color3.fromRGB(255, 255, 255),
		accentColor = Color3.fromRGB(0, 170, 255),
		hoverColor = Color3.fromRGB(80, 80, 80),
	}

	-- Instances
	local ScreenGui = Instance.new("ScreenGui")
	local MainFrame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local TitleLabel = Instance.new("TextLabel")
	local Sidebar = Instance.new("ScrollingFrame")
	local UIListLayoutSidebar = Instance.new("UIListLayout")
	local ContentFrame = Instance.new("Frame")
	local UIPadding = Instance.new("UIPadding")
	local UIListLayout = Instance.new("UIListLayout")
	local TopBar = Instance.new("Frame")

	-- Properties
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

	-- Method to add a tab button to the sidebar
	function window:AddTab(text)
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

		-- Method to add a button to the tab
		function tab:AddButton(text, callback)
			local Button = Instance.new("TextButton")
			local UICorner_3 = Instance.new("UICorner")

			Button.Parent = TabContentFrame
			Button.BackgroundColor3 = defaultColors.buttonColor
			Button.Size = UDim2.new(1, -20, 0, 40)
			Button.Font = Enum.Font.GothamBold
			Button.Text = text
			Button.TextColor3 = defaultColors.textColor
			Button.TextSize = 18.000
			Button.LayoutOrder = #TabContentFrame:GetChildren()

			UICorner_3.CornerRadius = UDim.new(0, 10)
			UICorner_3.Parent = Button

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

		-- Method to add a toggle to the tab
		function tab:AddToggle(text, default, callback)
			local ToggleFrame = Instance.new("Frame")
			local ToggleButton = Instance.new("TextButton")
			local ToggleText = Instance.new("TextLabel")
			local UICorner_4 = Instance.new("UICorner")
			local UICorner_5 = Instance.new("UICorner")

			ToggleFrame.Parent = TabContentFrame
			ToggleFrame.BackgroundColor3 = defaultColors.buttonColor
			ToggleFrame.Size = UDim2.new(1, -20, 0, 50)
			ToggleFrame.LayoutOrder = #TabContentFrame:GetChildren()

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

		-- Method to add a slider to the tab
		function tab:AddSlider(text, min, max, default, callback)
			local SliderFrame = Instance.new("Frame")
			local SliderText = Instance.new("TextLabel")
			local SliderBar = Instance.new("Frame")
			local SliderFill = Instance.new("Frame")
			local SliderHandle = Instance.new("Frame")
			local UICorner_6 = Instance.new("UICorner")
			local UICorner_7 = Instance.new("UICorner")
			local UICorner_8 = Instance.new("UICorner")
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
		end

		-- Method to add a dropdown to the tab
		function tab:AddDropdown(text, items, callback)
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

			UIPadding_2.Parent = DropdownItems
			UIPadding_2.PaddingBottom = UDim.new(0, 5)
			UIPadding_2.PaddingLeft = UDim.new(0, 5)
			UIPadding_2.PaddingRight = UDim.new(0, 5)
			UIPadding_2.PaddingTop = U

			Dim.new(0, 5)

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
		end

		-- Method to add a color picker to the tab
		function tab:AddColorPicker(text, defaultColor, callback)
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
				local RLabel = Instance.new("TextLabel")
				local RSlider = Instance.new("Frame")
				local RFill = Instance.new("Frame")
				local RHandle = Instance.new("Frame")
				local GLabel = Instance.new("TextLabel")
				local GSlider = Instance.new("Frame")
				local GFill = Instance.new("Frame")
				local GHandle = Instance.new("Frame")
				local BLabel = Instance.new("TextLabel")
				local BSlider = Instance.new("Frame")
				local BFill = Instance.new("Frame")
				local BHandle = Instance.new("Frame")
				local UICornerCP = Instance.new("UICorner")

				ColorPickerUI.Parent = ScreenGui
				ColorPickerUI.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				ColorPickerUI.Position = UDim2.new(0.5, -150, 0.5, -100)
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
		end

		-- Method to add a text input to the tab
		function tab:AddTextInput(text, default, callback)
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
		end

		-- Method to add a checkbox to the tab
		function tab:AddCheckbox(text, default, callback)
			local CheckboxFrame = Instance.new("Frame")
			local Checkbox = Instance.new("TextButton")
			local CheckboxLabel = Instance.new("TextLabel")
			local UICorner_4 = Instance.new("UICorner")
			local UICorner_5 = Instance.new("UICorner")

			CheckboxFrame.Parent = TabContentFrame
			CheckboxFrame.BackgroundColor3 = defaultColors.buttonColor
			CheckboxFrame.Size = UDim2.new(1, -20, 0, 50)
			CheckboxFrame.LayoutOrder = #TabContentFrame:GetChildren()

			UICorner_4.CornerRadius = UDim.new(0, 10)
			UICorner_4.Parent = CheckboxFrame

			CheckboxLabel.Parent = CheckboxFrame
			CheckboxLabel.BackgroundTransparency = 1.000
			CheckboxLabel.Position = UDim2.new(0, 10, 0, 0)
			CheckboxLabel.Size = UDim2.new(0.8, -10, 1, 0)
			CheckboxLabel.Font = Enum.Font.GothamBold
			CheckboxLabel.Text = text
			CheckboxLabel.TextColor3 = defaultColors.textColor
			CheckboxLabel.TextSize = 18.000
			CheckboxLabel.TextXAlignment = Enum.TextXAlignment.Left

			Checkbox.Parent = CheckboxFrame
			Checkbox.BackgroundColor3 = default and defaultColors.accentColor or Color3.fromRGB(45, 45, 45)
			Checkbox.Size = UDim2.new(0.2, -10, 0.8, 0)
			Checkbox.Position = UDim2.new(0.8, 0, 0.1, 0)
			Checkbox.Font = Enum.Font.GothamBold
			Checkbox.Text = ""
			Checkbox.TextColor3 = defaultColors.textColor
			Checkbox.TextSize = 18.000

			UICorner_5.CornerRadius = UDim.new(0, 10)
			UICorner_5.Parent = Checkbox

			local checked = default

			local function handleClick()
				checked = not checked
				Checkbox.BackgroundColor3 = checked and defaultColors.accentColor or Color3.fromRGB(45, 45, 45)
				if callback then
					callback(checked)
				end
			end

			Checkbox.MouseButton1Click:Connect(handleClick)
		end

		return tab
	end

	-- Method to add a notification
	function window:AddNotification(text, duration)
		local NotificationFrame = Instance.new("TextButton")
		local UICorner_11 = Instance.new("UICorner")

		NotificationFrame.Parent = ScreenGui
		NotificationFrame.BackgroundColor3 = defaultColors.accentColor
		NotificationFrame.Size = UDim2.new(0, 250, 0, 40)
		NotificationFrame.Position = UDim2.new(1, -260, 1, -50)
		NotificationFrame.AnchorPoint = Vector2.new(1, 1)
		NotificationFrame.Font = Enum.Font.GothamBold
		NotificationFrame.Text = text
		NotificationFrame.TextColor3 = defaultColors.textColor
		NotificationFrame.TextSize = 18.000

		UICorner_11.CornerRadius = UDim.new(0, 10)
		UICorner_11.Parent = NotificationFrame

		NotificationFrame.MouseButton1Click:Connect(function()
			NotificationFrame:Destroy()
		end)

		delay(duration or 2, function()
			if NotificationFrame and NotificationFrame.Parent then
				NotificationFrame:Destroy()
			end
		end)
	end

	-- Method to save the configuration
	function window:SaveConfig(name)
		local config = {
			backgroundColor = defaultColors.backgroundColor:ToHex(),
			buttonColor = defaultColors.buttonColor:ToHex(),
			textColor = defaultColors.textColor:ToHex(),
			accentColor = defaultColors.accentColor:ToHex()
		}
		local json = HttpService:JSONEncode(config)
		writefile(ConfigF.."/"..name..".json", json)
		window:AddNotification("Config Saved: " .. name, 2)
	end

	-- Method to load the configuration
	function window:LoadConfig(name)
		local configFile = ConfigF.."/"..name..".json"
		if isfile(configFile) then
			local config = HttpService:JSONDecode(readfile(configFile))
			defaultColors.backgroundColor = Color3.fromHex(config.backgroundColor)
			defaultColors.buttonColor = Color3.fromHex(config.buttonColor)
			defaultColors.textColor = Color3.fromHex(config.textColor)
			defaultColors.accentColor = Color3.fromHex(config.accentColor)
			MainFrame.BackgroundColor3 = defaultColors.backgroundColor
			for _, button in pairs(Sidebar:GetChildren()) do
				if button:IsA("TextButton") then
					button.BackgroundColor3 = defaultColors.buttonColor
					button.TextColor3 = defaultColors.textColor
				end
			end
			for _, element in pairs(ContentFrame:GetChildren()) do
				if element:IsA("TextButton") then
					element.BackgroundColor3 = defaultColors.buttonColor
					element.TextColor3 = defaultColors.textColor
				elseif element:IsA("TextLabel") then
					element.TextColor3 = defaultColors.textColor
				end
			end
			TitleLabel.TextColor3 = defaultColors.textColor
			window:AddNotification("Config Loaded: " .. name, 2)
		else
			window:AddNotification("Config Not Found: " .. name, 2)
		end
	return window
end
end 
-- Example Usage
return CumhubLib
