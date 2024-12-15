-- Example
local NovaLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ehehhdrhdhehehhehendducucuh/NovaLib./refs/heads/main/NovaLib.lua"))()

local ui = NovaLib:CreateGui()
local window = NovaLib:CreateFrame(ui)
local tabHolder, tabs = NovaLib:CreateTabs(window, {"Tab1", "Tab2", "Tab3"})
