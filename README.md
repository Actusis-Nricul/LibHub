# LibHub


## **Spying Lib**

```luau
local SpyingLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/Actusis-Nricul/LibHub/refs/heads/main/SpyingLib.luau'))()

local Tabs = SpyingLib:Window("My Hub")

local MainTab = Tabs:AddSection("Main", "home")

MainTab:Button("Click Me", "star", function() print("clicked") end)

MainTab:Toggle("Fly", false, "rocket", function(v) print(v) end)

MainTab:Slider("Speed", 16, 200, 16, "zap", function(v) print(v) end)

MainTab:TextBox("Name", 3, "edit", function(t) print(t) end)

MainTab:Dropdown("Mode", {"A", "B"}, "A", "settings", function(v) print(v) end)

MainTab:Keybind("Toggle UI", "K", "key", function() print("pressed") end)
```

## **Spider Lib**

```luau
local SpiderLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/Actusis-Nricul/LibHub/refs/heads/main/SpiderLib.luau'))()

local Sections = SpiderLib:win("My Hub", "home")

local MainTab = Sections:tab("Main", "home")

MainTab:button("Click Me", "star", function() print("clicked") end)

MainTab:toggle("Fly", false, "rocket", function(v) print(v) end)

MainTab:slider("Speed", 16, 200, 16, "zap", function(v) print(v) end)

MainTab:textbox("Name", "", "edit", function(t) print(t) end)

MainTab:dropdown("Mode", {"A", "B"}, "A", "settings", function(v) print(v) end)

MainTab:keybind("Toggle UI", "K", "key", function() print("pressed") end)
```

## **Syber Lib**

```luau
local SyberLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/Actusis-Nricul/LibHub/refs/heads/main/SyberLib.luau'))()

local Window = SyberLib:MakeWindow({
    Name = "SyberLib Demo",
    Icon = "rbxassetid://8834748103",
    IntroEnabled = true,
    IntroText = "SyberLib",
    SaveConfig = true,
    ConfigFolder = "SyberLibDemo",
    Theme = "Default", -- default, midnight, 
})

local Tab = Window:MakeTab({ Name = "Main", Icon = "settings" })

Tab:AddButton({ Name = "Click Me", Callback = function() print("clicked") end })

Tab:AddToggle({ Name = "Fly", Default = false, Flag = "FlyToggle1", Callback = function(v) print(v) end })
```

## **OctillWare Lib**

```luau
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/you/repo/main/OctillWareLib.lua'))()

local Window = Library:CreateWindow({ Title = "OctillWare", Center = true })
local Tab = Window:AddTab("Main")
local Box = Tab:AddLeftGroupbox("Player")

Box:AddToggle("FlyToggle", {
    Text = "Fly",
    Default = false,
    Callback = function(Value) print("Fly:", Value) end,
})

Box:AddSlider("SpeedSlider", {
    Text = "WalkSpeed",
    Default = 16, Min = 16, Max = 200, Rounding = 0,
    Callback = function(Value) print("Speed:", Value) end,
})

Box:AddButton("Reset", function() print("clicked") end)

Library:SetTheme("Crimson")
```

## **Vrillix Lib**

```luau
local lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/you/repo/main/VrillixLib.lua'))()

local window = lib:Load({ name = "Vrillix", theme = "Dark" })
local tab = window:Tab("Main")
local section = tab:Section({ name = "Player", column = 1 })

section:Toggle({ name = "Fly", flag = "fly", callback = function(v) print("Fly:", v) end })
section:Slider({ name = "Speed", min = 16, max = 200, default = 16, callback = function(v) print(v) end })
section:Button({ name = "Click Me", callback = function() print("clicked") end })

lib:Notify("Loaded", "VrillixLib loaded successfully", 4)
```
