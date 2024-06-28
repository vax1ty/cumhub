local UILibrary = require(path.to.UILibrary)

local window = UILibrary:CreateWindow("My UI Library")

local tab1 = window:CreateTab("Tab 1")
local tab2 = window:CreateTab("Tab 2")

window:CreateButton(tab1, "Button 1", function()
    print("Button 1 clicked")
end)

window:CreateSlider(tab1, 0, 100, 50, function(value)
    print("Slider value:", value)
end)

window:CreateToggle(tab1, "Toggle 1", false, function(state)
    print("Toggle state:", state)
end)

window:CreateDropdown(tab1, "Dropdown 1", {"Option 1", "Option 2", "Option 3"}, true, function(selectedItems)
    for item, _ in pairs(selectedItems) do
        print("Selected item:", item)
    end
end)

window:CreateButton(tab2, "Button 2", function()
    print("Button 2 clicked")
end)

window:CreateSlider(tab2, 0, 100, 25, function(value)
    print("Slider value:", value)
end)

window:CreateToggle(tab2, "Toggle 2", true, function(state)
    print("Toggle state:", state)
end)

window:CreateDropdown(tab2, "Dropdown 2", {"Choice 1", "Choice 2", "Choice 3", "Choice 4"}, false, function(selectedItems)
    for item, _ in pairs(selectedItems) do
        print("Selected item:", item)
    end
end)
