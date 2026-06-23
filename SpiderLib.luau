--[[
spiderlib
tuff name btw
subscribe @ActusisGames
this was really fun to make
took me a bit tho 💀💤
]]

local SpiderLib = {}

local ts = cloneref(game:GetService("TweenService"))
local cg = cloneref(game:GetService("CoreGui"))
local ui = cloneref(game:GetService("UserInputService"))

-->>: ICON RESOLVER (rbxassetid / lucide name / emoji)
local LucideGlyphs = {
    home = "🏡", settings = "⚙️", user = "🙂", users = "🙂🙂",
    play = "▶", pause = "❚❚", stop = "■", trash = "🗑️", search = "🔍",
    star = "⭐", heart = "❤️", bell = "🔔", lock = "🔒", unlock = "🔓",
    eye = "👁️", zap = "⚡", flame = "🔥", skull = "💀", shield = "🛡️",
    gamepad = "🎮", sword = "⚔️", map = "🗺️", check = "✓", x = "✕",
    info = "ℹ️", warning = "⚠️", clock = "🕐", folder = "📁", file = "📄",
    key = "🔑", gear = "⚙️", rocket = "🚀", bug = "🐛", code = "💻",
    download = "⬇️", upload = "⬆️", refresh = "🔄", link = "🔗",
    wrench = "🔧", hammer = "🔨", sparkles = "✨", crown = "♛",
}

local function resolveIcon(icon)
    if not icon or icon == "" then return nil, nil end
    if typeof(icon) == "number" then
        return "rbxassetid://" .. tostring(icon), nil
    end
    if typeof(icon) == "string" then
        if icon:match("^rbxassetid://") or icon:match("^rbxasset://") or icon:match("^http") then
            return icon, nil
        end
        if icon:match("^%d+$") then
            return "rbxassetid://" .. icon, nil
        end
        local glyph = LucideGlyphs[icon:lower():gsub("[%-%s_]", "")]
        if glyph then return nil, glyph end
        return nil, icon
    end
    return nil, nil
end

local function applyIcon(imgLabel, glyphLabel, icon)
    local imageId, glyph = resolveIcon(icon)
    if imageId then
        imgLabel.Image = imageId
        imgLabel.Visible = true
        if glyphLabel then glyphLabel.Visible = false end
    elseif glyph then
        if glyphLabel then
            glyphLabel.Text = glyph
            glyphLabel.Visible = true
        end
        imgLabel.Visible = false
    else
        imgLabel.Visible = false
        if glyphLabel then glyphLabel.Visible = false end
    end
end

local function create(class, props)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do
        if k ~= "Parent" then inst[k] = v end
    end
    if props and props.Parent then inst.Parent = props.Parent end
    return inst
end

local function round(inst, radius)
    create("UICorner", {CornerRadius = UDim.new(0, radius or 8), Parent = inst})
end

function SpiderLib:win(title, icon)
    -- =====================
    -- ROOT WINDOW (built at runtime, no external asset needed)
    -- =====================
    local screenGui = create("ScreenGui", {
        Name = "SpiderLib_" .. title:gsub("%s", ""),
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
    })
    screenGui.Parent = (gethui and gethui()) or cg

    local frame = create("Frame", {
        Size = UDim2.new(0.37, 0, 0.51, 0),
        Position = UDim2.new(0.315, 0, 0.245, 0),
        BackgroundColor3 = Color3.fromRGB(20, 20, 28),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = screenGui,
    })
    round(frame, 12)
    create("UIStroke", {Color = Color3.fromRGB(50, 50, 65), Parent = frame})

    -- topbar
    local topbar = create("Frame", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Color3.fromRGB(16, 16, 24),
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Parent = frame,
    })
    round(topbar, 12)

    local topbarFix = create("Frame", {
        Size = UDim2.new(1, 0, 0.5, 0),
        Position = UDim2.new(0, 0, 0.5, 0),
        BackgroundColor3 = topbar.BackgroundColor3,
        BackgroundTransparency = topbar.BackgroundTransparency,
        BorderSizePixel = 0,
        Parent = topbar,
    })

    local titleIcon = create("ImageLabel", {
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(0, 10, 0.5, -9),
        BackgroundTransparency = 1,
        Visible = false,
        ZIndex = 5,
        Parent = topbar,
    })
    local titleGlyph = create("TextLabel", {
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(0, 10, 0.5, -9),
        BackgroundTransparency = 1,
        TextScaled = true,
        Visible = false,
        ZIndex = 5,
        Parent = topbar,
    })
    applyIcon(titleIcon, titleGlyph, icon)
    local hasTitleIcon = titleIcon.Visible or titleGlyph.Visible

    local titleLabel = create("TextLabel", {
        Size = UDim2.new(1, -90, 1, 0),
        Position = UDim2.new(0, hasTitleIcon and 34 or 12, 0, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Color3.fromRGB(235, 235, 245),
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 5,
        Parent = topbar,
    })

    local closeBtn = create("TextButton", {
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(1, -32, 0.5, -12),
        BackgroundTransparency = 1,
        Text = "X",
        TextColor3 = Color3.fromRGB(220, 220, 230),
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        AutoButtonColor = false,
        ZIndex = 5,
        Parent = topbar,
    })
    round(closeBtn, 12)

    local miniBtn = create("TextButton", {
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(1, -60, 0.5, -12),
        BackgroundTransparency = 1,
        Text = "—",
        TextColor3 = Color3.fromRGB(220, 220, 230),
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        AutoButtonColor = false,
        ZIndex = 5,
        Parent = topbar,
    })
    round(miniBtn, 12)

    local function fadebtn(btn, isIn)
        ts:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = isIn and 0.8 or 1}):Play()
    end

    closeBtn.MouseEnter:Connect(function() fadebtn(closeBtn, true) end)
    miniBtn.MouseEnter:Connect(function() fadebtn(miniBtn, true) end)
    closeBtn.MouseLeave:Connect(function() fadebtn(closeBtn, false) end)
    miniBtn.MouseLeave:Connect(function() fadebtn(miniBtn, false) end)

    local origSize = frame.Size
    local minimized = false

    local function togglewin(isOpen)
        minimized = not isOpen
        ts:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
            Size = isOpen and origSize or UDim2.new(origSize.X.Scale, origSize.X.Offset, 0, 40)
        }):Play()
    end

    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    miniBtn.MouseButton1Click:Connect(function()
        togglewin(minimized)
    end)

    ui.InputBegan:Connect(function(keyc, gamep)
        if not gamep and keyc.KeyCode == Enum.KeyCode.K then
            togglewin(minimized)
        end
    end)

    -- dragging
    local dragging, dragInput, mousePos, framePos
    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    ui.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(
                framePos.X.Scale, framePos.X.Offset + delta.X,
                framePos.Y.Scale, framePos.Y.Offset + delta.Y
            )
        end
    end)

    -- =====================
    -- CONTENT AREA (above tab bar) + TAB BAR (pinned to bottom)
    -- =====================
    local TAB_BAR_HEIGHT = 38

    local contentArea = create("Frame", {
        Size = UDim2.new(1, -16, 1, -40 - TAB_BAR_HEIGHT - 8),
        Position = UDim2.new(0, 8, 0, 44),
        BackgroundTransparency = 1,
        Parent = frame,
    })

    local tabBar = create("Frame", {
        Size = UDim2.new(1, -16, 0, TAB_BAR_HEIGHT),
        Position = UDim2.new(0, 8, 1, -TAB_BAR_HEIGHT - 6),
        BackgroundColor3 = Color3.fromRGB(14, 14, 22),
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        Parent = frame,
    })
    round(tabBar, 10)

    local tabBarLayout = create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 4),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = tabBar,
    })

    local sections = {}
    local curSelected = nil
    local allSectionFrames = {}
    local allTabButtons = {}

    local function selectSection(targetSection, targetBtn)
        for _, s in ipairs(allSectionFrames) do
            s.Visible = false
        end
        for _, b in ipairs(allTabButtons) do
            ts:Create(b, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
            local lbl = b:FindFirstChild("TabLabel")
            if lbl then ts:Create(lbl, TweenInfo.new(0.15), {TextTransparency = 0.4}):Play() end
        end
        targetSection.Visible = true
        ts:Create(targetBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.3}):Play()
        local lbl = targetBtn:FindFirstChild("TabLabel")
        if lbl then ts:Create(lbl, TweenInfo.new(0.15), {TextTransparency = 0}):Play() end
        curSelected = targetSection
    end

    function sections:tab(tabTitle, tabIcon)
        local tabBtn = create("TextButton", {
            Size = UDim2.new(0, 80, 1, -6),
            BackgroundColor3 = Color3.fromRGB(60, 90, 160),
            BackgroundTransparency = 1,
            Text = "",
            AutoButtonColor = false,
            BorderSizePixel = 0,
            LayoutOrder = #allTabButtons + 1,
            Parent = tabBar,
        })
        round(tabBtn, 8)

        local tIcon = create("ImageLabel", {
            Size = UDim2.new(0, 14, 0, 14),
            Position = UDim2.new(0, 8, 0.5, -7),
            BackgroundTransparency = 1,
            Visible = false,
            Parent = tabBtn,
        })
        local tGlyph = create("TextLabel", {
            Size = UDim2.new(0, 14, 0, 14),
            Position = UDim2.new(0, 8, 0.5, -7),
            BackgroundTransparency = 1,
            TextScaled = true,
            Visible = false,
            Parent = tabBtn,
        })
        applyIcon(tIcon, tGlyph, tabIcon)
        local hasIcon = tIcon.Visible or tGlyph.Visible

        local tabLabel = create("TextLabel", {
            Name = "TabLabel",
            Size = hasIcon and UDim2.new(1, -28, 1, 0) or UDim2.new(1, -8, 1, 0),
            Position = hasIcon and UDim2.new(0, 26, 0, 0) or UDim2.new(0, 4, 0, 0),
            BackgroundTransparency = 1,
            Text = tabTitle,
            TextColor3 = Color3.fromRGB(220, 220, 230),
            TextTransparency = 0.4,
            Font = Enum.Font.Gotham,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextScaled = false,
            Parent = tabBtn,
        })

        table.insert(allTabButtons, tabBtn)

        local sectionFrame = create("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Color3.fromRGB(100, 130, 220),
            BorderSizePixel = 0,
            Visible = false,
            Parent = contentArea,
        })
        local sectionLayout = create("UIListLayout", {
            Padding = UDim.new(0, 6),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = sectionFrame,
        })
        sectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            sectionFrame.CanvasSize = UDim2.new(0, 0, 0, sectionLayout.AbsoluteContentSize.Y + 12)
        end)

        table.insert(allSectionFrames, sectionFrame)

        local orderCounter = 0
        local function nextOrder()
            orderCounter = orderCounter + 1
            return orderCounter
        end

        tabBtn.MouseButton1Click:Connect(function()
            selectSection(sectionFrame, tabBtn)
        end)

        if #allTabButtons == 1 then
            selectSection(sectionFrame, tabBtn)
        end

        local contents = {}

        local function baseElement(height)
            local el = create("Frame", {
                Size = UDim2.new(1, 0, 0, height),
                BackgroundColor3 = Color3.fromRGB(28, 28, 38),
                BorderSizePixel = 0,
                LayoutOrder = nextOrder(),
                Parent = sectionFrame,
            })
            round(el, 8)
            create("UIStroke", {Color = Color3.fromRGB(45, 45, 60), Parent = el})
            return el
        end

        local function elementLabel(parent, text, icon, yPos)
            local ic = create("ImageLabel", {
                Size = UDim2.new(0, 16, 0, 16),
                Position = UDim2.new(0, 10, yPos or 0.5, -8),
                BackgroundTransparency = 1,
                Visible = false,
                Parent = parent,
            })
            local gl = create("TextLabel", {
                Size = UDim2.new(0, 16, 0, 16),
                Position = UDim2.new(0, 10, yPos or 0.5, -8),
                BackgroundTransparency = 1,
                TextScaled = true,
                Visible = false,
                Parent = parent,
            })
            applyIcon(ic, gl, icon)
            local has = ic.Visible or gl.Visible

            local lbl = create("TextLabel", {
                Size = has and UDim2.new(1, -36, 0, 18) or UDim2.new(1, -20, 0, 18),
                Position = has and UDim2.new(0, 32, yPos or 0.5, -9) or UDim2.new(0, 10, yPos or 0.5, -9),
                BackgroundTransparency = 1,
                Text = text,
                TextColor3 = Color3.fromRGB(230, 230, 240),
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = parent,
            })
            return lbl
        end

        function contents:label(text, icon)
            local el = baseElement(30)
            local lbl = elementLabel(el, text, icon)
            return {Set = function(_, t) lbl.Text = t end}
        end

        function contents:button(text, icon, cb)
            if typeof(icon) == "function" then cb = icon; icon = nil end

            local el = baseElement(34)
            elementLabel(el, text, icon or "check")

            local btn = create("TextButton", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                Parent = el,
            })
            btn.MouseEnter:Connect(function()
                ts:Create(el, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(36, 36, 48)}):Play()
            end)
            btn.MouseLeave:Connect(function()
                ts:Create(el, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(28, 28, 38)}):Play()
            end)
            btn.MouseButton1Click:Connect(function() pcall(cb) end)
        end

        function contents:toggle(text, default, icon, cb)
            if typeof(icon) == "function" then cb = icon; icon = nil end

            local el = baseElement(34)
            elementLabel(el, text, icon or "check")

            local switchBg = create("Frame", {
                Size = UDim2.new(0, 36, 0, 18),
                Position = UDim2.new(1, -46, 0.5, -9),
                BackgroundColor3 = default and Color3.fromRGB(74, 200, 110) or Color3.fromRGB(80, 80, 90),
                BorderSizePixel = 0,
                Parent = el,
            })
            round(switchBg, 9)
            local knob = create("Frame", {
                Size = UDim2.new(0, 14, 0, 14),
                Position = default and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
                BackgroundColor3 = Color3.new(1, 1, 1),
                BorderSizePixel = 0,
                Parent = switchBg,
            })
            round(knob, 7)

            local btn = create("TextButton", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                Parent = el,
            })

            local toggled = default
            if toggled then task.defer(cb, toggled) end

            btn.MouseButton1Click:Connect(function()
                toggled = not toggled
                ts:Create(switchBg, TweenInfo.new(0.15), {
                    BackgroundColor3 = toggled and Color3.fromRGB(74, 200, 110) or Color3.fromRGB(80, 80, 90)
                }):Play()
                ts:Create(knob, TweenInfo.new(0.15), {
                    Position = toggled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
                }):Play()
                cb(toggled)
            end)
        end

        function contents:textbox(text, default, icon, cb)
            if typeof(icon) == "function" then cb = icon; icon = nil end

            local el = baseElement(46)
            elementLabel(el, text, icon or "edit", 0.32)

            local inputFrame = create("Frame", {
                Size = UDim2.new(1, -20, 0, 22),
                Position = UDim2.new(0, 10, 1, -28),
                BackgroundColor3 = Color3.fromRGB(20, 20, 30),
                BorderSizePixel = 0,
                Parent = el,
            })
            round(inputFrame, 6)

            local box = create("TextBox", {
                Size = UDim2.new(1, -16, 1, 0),
                Position = UDim2.new(0, 8, 0, 0),
                BackgroundTransparency = 1,
                Text = default or "",
                PlaceholderText = "Type Here..",
                TextColor3 = Color3.fromRGB(230, 230, 240),
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                ClearTextOnFocus = false,
                Parent = inputFrame,
            })

            if default and default ~= "" then
                task.defer(cb, default)
            end

            box.FocusLost:Connect(function(ep)
                if ep then pcall(cb, box.Text) end
            end)
        end

        function contents:slider(text, min, max, default, icon, cb)
            if typeof(icon) == "function" then cb = icon; icon = nil end

            local el = baseElement(46)
            local lbl = elementLabel(el, text .. " : " .. tostring(default), icon or "sliders", 0.32)

            local track = create("Frame", {
                Size = UDim2.new(1, -20, 0, 8),
                Position = UDim2.new(0, 10, 1, -22),
                BackgroundColor3 = Color3.fromRGB(20, 20, 30),
                BorderSizePixel = 0,
                Parent = el,
            })
            round(track, 4)

            local fill = create("Frame", {
                Size = UDim2.new(0, 0, 1, 0),
                BackgroundColor3 = Color3.fromRGB(100, 150, 230),
                BorderSizePixel = 0,
                Parent = track,
            })
            round(fill, 4)

            local dragging2 = false
            local lastval = default

            local function setFromAlpha(alpha)
                alpha = math.clamp(alpha, 0, 1)
                local value = math.floor(min + (max - min) * alpha + 0.5)
                fill.Size = UDim2.new(alpha, 0, 1, 0)
                lastval = value
                lbl.Text = text .. " : " .. tostring(value)
            end

            local function updateFromInput(x)
                local rel = (x - track.AbsolutePosition.X) / track.AbsoluteSize.X
                setFromAlpha(rel)
            end

            setFromAlpha((default - min) / (max - min))

            track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging2 = true
                    updateFromInput(input.Position.X)
                end
            end)
            ui.InputChanged:Connect(function(input)
                if dragging2 and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateFromInput(input.Position.X)
                end
            end)
            ui.InputEnded:Connect(function(input)
                if dragging2 and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                    dragging2 = false
                    if cb then pcall(cb, lastval) end
                end
            end)
        end

        function contents:dropdown(text, options, default, icon, cb)
            if typeof(icon) == "function" then cb = icon; icon = nil end

            local el = baseElement(34)
            elementLabel(el, text, icon or "chevrondown")

            local valBtn = create("TextButton", {
                Size = UDim2.new(0, 110, 0, 22),
                Position = UDim2.new(1, -120, 0.5, -11),
                BackgroundColor3 = Color3.fromRGB(20, 20, 30),
                Text = tostring(default or options[1]) .. "  v",
                TextColor3 = Color3.fromRGB(150, 190, 255),
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                AutoButtonColor = false,
                BorderSizePixel = 0,
                Parent = el,
            })
            round(valBtn, 6)

            local listPanel = create("Frame", {
                Size = UDim2.new(0, 130, 0, math.min(#options * 26, 150)),
                BackgroundColor3 = Color3.fromRGB(24, 24, 34),
                BorderSizePixel = 0,
                Visible = false,
                ZIndex = 100,
                Parent = screenGui,
            })
            round(listPanel, 8)
            local listLayout = create("UIListLayout", {Parent = listPanel})

            local current = default or options[1]

            for _, opt in ipairs(options) do
                local optBtn = create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 26),
                    BackgroundColor3 = opt == current and Color3.fromRGB(60, 90, 160) or Color3.fromRGB(24, 24, 34),
                    Text = "  " .. tostring(opt),
                    TextColor3 = Color3.new(1, 1, 1),
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    AutoButtonColor = false,
                    BorderSizePixel = 0,
                    ZIndex = 101,
                    Parent = listPanel,
                })
                optBtn.MouseButton1Click:Connect(function()
                    current = opt
                    valBtn.Text = tostring(opt) .. "  v"
                    listPanel.Visible = false
                    for _, c in ipairs(listPanel:GetChildren()) do
                        if c:IsA("TextButton") then c.BackgroundColor3 = Color3.fromRGB(24, 24, 34) end
                    end
                    optBtn.BackgroundColor3 = Color3.fromRGB(60, 90, 160)
                    pcall(cb, opt)
                end)
            end

            valBtn.MouseButton1Click:Connect(function()
                listPanel.Visible = not listPanel.Visible
                if listPanel.Visible then
                    local abs = valBtn.AbsolutePosition
                    local sz = valBtn.AbsoluteSize
                    listPanel.Position = UDim2.new(0, abs.X - 20, 0, abs.Y + sz.Y + 4)
                end
            end)
        end

        function contents:keybind(text, default, icon, cb)
            if typeof(icon) == "function" then cb = icon; icon = nil end

            local el = baseElement(34)
            elementLabel(el, text, icon or "key")

            local keyBtn = create("TextButton", {
                Size = UDim2.new(0, 70, 0, 22),
                Position = UDim2.new(1, -80, 0.5, -11),
                BackgroundColor3 = Color3.fromRGB(20, 20, 30),
                Text = default or "None",
                TextColor3 = Color3.fromRGB(150, 190, 255),
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                AutoButtonColor = false,
                BorderSizePixel = 0,
                Parent = el,
            })
            round(keyBtn, 6)

            local currentKey = default or "None"
            local listening = false

            keyBtn.MouseButton1Click:Connect(function()
                listening = true
                keyBtn.Text = "..."
            end)

            ui.InputBegan:Connect(function(input, gpe)
                if listening and input.KeyCode ~= Enum.KeyCode.Unknown then
                    listening = false
                    currentKey = tostring(input.KeyCode):gsub("Enum.KeyCode.", "")
                    keyBtn.Text = currentKey
                elseif not listening and not gpe then
                    if Enum.KeyCode[currentKey] and input.KeyCode == Enum.KeyCode[currentKey] then
                        pcall(cb, true)
                    end
                end
            end)
        end

        return contents
    end

    return sections
end

return SpiderLib
