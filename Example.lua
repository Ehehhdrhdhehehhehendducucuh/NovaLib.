-- example!
local NovaLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ehehhdrhdhehehhehendducucuh/NovaLib./refs/heads/main/NovaLib.lua"))()

local ui = NovaLib:CreateWindow("My Window")
local window = NovaLib:CreateFrame(ui)
local tabHolder, tabs = NovaLib:CreateTabs(window, {"Tab1", "Tab2"})

NovaLib:CreateButton(window, "Click Me", function()
    print("Button was clicked!")
end)

NovaLib:CreateToggle(window, "Enable Feature", function(isToggled)
    print("Toggle State: ", isToggled)
end)

NovaLib:CreateSlider(window, "Volume", 0, 100, function(value)
    print("Slider Value: ", value)
end)
