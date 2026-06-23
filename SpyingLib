--[[
SpyingLib!!!
doesnt actually spy dw lol
free of malware!!! 😄
]]

local SpyingLib = {}

-->>: SERVICES
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-->>: ICON RESOLVER
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
    -- returns: imageId (string or nil), glyph (string or nil)
    if not icon or icon == "" then
        return nil, nil
    end
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
        if glyph then
            return nil, glyph
        end
        -- assume it's already an emoji / raw glyph string
        return nil, icon
    end
    return nil, nil
end

-- applies an icon to an ImageLabel + an optional TextLabel fallback slot
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

function SpyingLib:Window(winName)
    local sliderInUse = false

    local function dragify(Frame)
        local dragToggle = nil
        local dragInput = nil
        local dragStart = nil
        local startPos = nil

        local function updateInput(input)
            local Delta = input.Position - dragStart
            local Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + Delta.X,
                startPos.Y.Scale, startPos.Y.Offset + Delta.Y
            )
            TweenService:Create(Frame, TweenInfo.new(0.15), {Position = Position}):Play()
        end

        Frame.InputBegan:Connect(function(input)
            if sliderInUse then return end
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch)
            and UIS:GetFocusedTextBox() == nil then
                dragToggle = true
                dragStart = input.Position
                startPos = Frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragToggle = false
                    end
                end)
            end
        end)

        Frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if input == dragInput and dragToggle then
                updateInput(input)
            end
        end)
    end

    local MainGUI = Instance.new("ScreenGui")
    MainGUI.IgnoreGuiInset = true
    MainGUI.Name = "SpyingLib_" .. winName:gsub("%s", "")
    MainGUI.Parent = (gethui and gethui()) or CoreGui

    local MainBG = Instance.new("Frame")
    MainBG.Name = "MainBG"
    MainBG.Position = UDim2.new(0.18555417656898499, 0, 0.2684144675731659, 0)
    MainBG.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MainBG.Size = UDim2.new(0, 360, 0, 280)
    MainBG.BorderSizePixel = 0
    MainBG.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
    MainBG.Parent = MainGUI

    local UIGradient = Instance.new("UIGradient")
    UIGradient.Rotation = -90
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 88, 88)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    }
    UIGradient.Parent = MainBG

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainBG

    -- icon next to title
    local TitleIcon = Instance.new("ImageLabel")
    TitleIcon.Name = "TitleIcon"
    TitleIcon.AnchorPoint = Vector2.new(0, 0.5)
    TitleIcon.Position = UDim2.new(0.03, 0, 0.0729, 0)
    TitleIcon.Size = UDim2.new(0, 16, 0, 16)
    TitleIcon.BackgroundTransparency = 1
    TitleIcon.Visible = false
    TitleIcon.Parent = MainBG

    local TitleGlyph = Instance.new("TextLabel")
    TitleGlyph.Name = "TitleGlyph"
    TitleGlyph.AnchorPoint = Vector2.new(0, 0.5)
    TitleGlyph.Position = UDim2.new(0.03, 0, 0.0729, 0)
    TitleGlyph.Size = UDim2.new(0, 16, 0, 16)
    TitleGlyph.BackgroundTransparency = 1
    TitleGlyph.TextScaled = true
    TitleGlyph.Font = Enum.Font.SourceSans
    TitleGlyph.Visible = false
    TitleGlyph.Parent = MainBG

    local SectionContainer = Instance.new("Frame")
    SectionContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SectionContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    SectionContainer.BackgroundTransparency = 0.5
    SectionContainer.Position = UDim2.new(0.5, 0, 0.5518152713775635, 0)
    SectionContainer.Name = "SectionContainer"
    SectionContainer.Size = UDim2.new(0, 342, 0, 230)
    SectionContainer.BorderSizePixel = 0
    SectionContainer.BackgroundColor3 = Color3.fromRGB(71, 78, 91)
    SectionContainer.Parent = MainBG

    local SCCorner = Instance.new("UICorner")
    SCCorner.CornerRadius = UDim.new(0, 12)
    SCCorner.Parent = SectionContainer

    local TabsContainer = Instance.new("Frame")
    TabsContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabsContainer.AnchorPoint = Vector2.new(0.5, 0)
    TabsContainer.BackgroundTransparency = 1
    TabsContainer.Position = UDim2.new(0.5, 0, 0, 0)
    TabsContainer.Name = "TabsContainer"
    TabsContainer.Size = UDim2.new(0, 342, 0, 26)
    TabsContainer.BorderSizePixel = 0
    TabsContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabsContainer.Parent = SectionContainer

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = TabsContainer

    local Divider = Instance.new("Frame")
    Divider.AnchorPoint = Vector2.new(0.5, 1)
    Divider.Name = "Divider"
    Divider.Position = UDim2.new(0.5, 0, 0.15763546526432037, 0)
    Divider.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Divider.Size = UDim2.new(0, 342, 0, 6)
    Divider.BorderSizePixel = 0
    Divider.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
    Divider.Parent = SectionContainer

    local Header = Instance.new("TextLabel")
    Header.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    Header.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    Header.AnchorPoint = Vector2.new(0.5, 0.5)
    Header.TextSize = 14
    Header.Size = UDim2.new(0, 220, 0, 20)
    Header.TextColor3 = Color3.fromRGB(255, 255, 255)
    Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Header.Text = winName
    Header.Name = "Header"
    Header.TextWrapped = true
    Header.BackgroundTransparency = 1
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Position = UDim2.new(0.13, 0, 0.0729, 0)
    Header.BorderSizePixel = 0
    Header.TextScaled = true
    Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Header.Parent = MainBG

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Parent = MainBG

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    CloseBtn.Active = false
    CloseBtn.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.AnchorPoint = Vector2.new(0.5, 0.5)
    CloseBtn.TextSize = 14
    CloseBtn.Size = UDim2.new(0, 15, 0, 20)
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    CloseBtn.Text = "X"
    CloseBtn.Name = "CloseBtn"
    CloseBtn.Selectable = false
    CloseBtn.TextWrapped = true
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.TextXAlignment = Enum.TextXAlignment.Left
    CloseBtn.Position = UDim2.new(0.9588334655761719, 0, 0.07287449389696121, 0)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.TextScaled = true
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.Parent = MainBG

    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    MinimizeBtn.Active = false
    MinimizeBtn.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.AnchorPoint = Vector2.new(0.5, 0.5)
    MinimizeBtn.TextSize = 14
    MinimizeBtn.Size = UDim2.new(0, 15, 0, 20)
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MinimizeBtn.Text = "-"
    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Selectable = false
    MinimizeBtn.TextWrapped = true
    MinimizeBtn.BackgroundTransparency = 1
    MinimizeBtn.TextXAlignment = Enum.TextXAlignment.Left
    MinimizeBtn.Position = UDim2.new(0.9131151032447815, 0, 0.07287449389696121, 0)
    MinimizeBtn.BorderSizePixel = 0
    MinimizeBtn.TextScaled = true
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.Parent = MainBG

    local HeaderBtn = Instance.new("TextButton")
    HeaderBtn.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    HeaderBtn.Active = false
    HeaderBtn.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    HeaderBtn.AnchorPoint = Vector2.new(0.5, 0.5)
    HeaderBtn.TextSize = 14
    HeaderBtn.Size = UDim2.new(0, 206, 0, 20)
    HeaderBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    HeaderBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    HeaderBtn.Text = winName
    HeaderBtn.Name = "Header"
    HeaderBtn.TextWrapped = true
    HeaderBtn.BackgroundTransparency = 1
    HeaderBtn.Position = UDim2.new(0.5, 0, 0.8718757629394531, 0)
    HeaderBtn.Selectable = false
    HeaderBtn.BorderSizePixel = 0
    HeaderBtn.TextScaled = true
    HeaderBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HeaderBtn.Parent = MainGUI
    HeaderBtn.Visible = false

    CloseBtn.MouseButton1Click:Connect(function()
        MainGUI:Destroy()
    end)

    MinimizeBtn.MouseButton1Click:Connect(function()
        MainBG.Visible = false
        HeaderBtn.Visible = true
    end)

    HeaderBtn.MouseButton1Click:Connect(function()
        HeaderBtn.Visible = false
        MainBG.Visible = true
    end)

    dragify(MainBG)

    local Tabs = {}
    local LoadedSections = {}

    function Tabs:AddSection(SectionName, icon)
        -- Tab Button
        local Tab1 = Instance.new("ImageButton")
        Tab1.Name = SectionName
        Tab1.Size = UDim2.new(0, 86, 0, 26)
        Tab1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Tab1.BackgroundColor3 = Color3.fromRGB(53, 58, 67)
        Tab1.BorderSizePixel = 0
        Tab1.AutoButtonColor = false
        Tab1.Parent = TabsContainer

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 12)
        TabCorner.Parent = Tab1

        local TabIcon = Instance.new("ImageLabel")
        TabIcon.Name = "TabIcon"
        TabIcon.AnchorPoint = Vector2.new(0, 0.5)
        TabIcon.Position = UDim2.new(0.08, 0, 0.5, 0)
        TabIcon.Size = UDim2.new(0, 13, 0, 13)
        TabIcon.BackgroundTransparency = 1
        TabIcon.ZIndex = 2
        TabIcon.Visible = false
        TabIcon.Parent = Tab1

        local TabGlyph = Instance.new("TextLabel")
        TabGlyph.Name = "TabGlyph"
        TabGlyph.AnchorPoint = Vector2.new(0, 0.5)
        TabGlyph.Position = UDim2.new(0.08, 0, 0.5, 0)
        TabGlyph.Size = UDim2.new(0, 13, 0, 13)
        TabGlyph.BackgroundTransparency = 1
        TabGlyph.TextScaled = true
        TabGlyph.ZIndex = 2
        TabGlyph.Visible = false
        TabGlyph.Parent = Tab1

        applyIcon(TabIcon, TabGlyph, icon)
        local hasIcon = TabIcon.Visible or TabGlyph.Visible

        local TabName = Instance.new("TextLabel")
        TabName.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        TabName.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
        TabName.AnchorPoint = Vector2.new(0.5, 0.5)
        TabName.ZIndex = 2
        TabName.TextSize = 14
        TabName.Size = hasIcon and UDim2.new(0, 56, 0, 12) or UDim2.new(0, 70, 0, 12)
        TabName.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabName.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabName.Text = SectionName
        TabName.Name = "TabName"
        TabName.BackgroundTransparency = 1
        TabName.Position = hasIcon and UDim2.new(0.58, 0, 0.5, 0) or UDim2.new(0.5, 0, 0.5, 0)
        TabName.TextWrapped = true
        TabName.BorderSizePixel = 0
        TabName.TextScaled = true
        TabName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabName.Parent = Tab1

        local Filler = Instance.new("Frame")
        Filler.Active = true
        Filler.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Filler.AnchorPoint = Vector2.new(0.5, 1)
        Filler.Name = "Filler"
        Filler.Position = UDim2.new(0.5, 0, 1, 0)
        Filler.Size = UDim2.new(0, 86, 0, 13)
        Filler.Selectable = true
        Filler.BorderSizePixel = 0
        Filler.BackgroundColor3 = Color3.fromRGB(53, 58, 67)
        Filler.Parent = Tab1

        -- =====================
        -- Section content area sits ABOVE the bottom tab bar.
        -- TabsContainer stays anchored to the bottom of SectionContainer.
        -- =====================
        local Section = Instance.new("ScrollingFrame")
        Section.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Section.AnchorPoint = Vector2.new(0.5, 0)
        Section.BorderSizePixel = 0
        Section.CanvasSize = UDim2.new(0, 0, 0, 0)
        Section.ScrollBarImageColor3 = Color3.fromRGB(38, 42, 49)
        Section.MidImage = "rbxassetid://3062506202"
        Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Section.ScrollBarThickness = 6
        Section.Name = SectionName
        Section.Size = UDim2.new(0, 330, 0, 196)
        Section.Selectable = false
        Section.TopImage = "rbxassetid://3062506445"
        Section.Position = UDim2.new(0.5, 0, 0, 30)
        Section.BottomImage = "rbxassetid://3062505976"
        Section.BackgroundTransparency = 1
        Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Section.Parent = SectionContainer
        Section.Visible = false

        local UIListLayout2 = Instance.new("UIListLayout")
        UIListLayout2.Padding = UDim.new(0, 2)
        UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout2.Parent = Section

        table.insert(LoadedSections, Section)

        Tab1.MouseButton1Click:Connect(function()
            for i, v in pairs(LoadedSections) do
                v.Visible = false
                local btn = TabsContainer:FindFirstChild(v.Name)
                if btn then
                    btn.BackgroundColor3 = Color3.fromRGB(53, 58, 67)
                    btn.Filler.BackgroundColor3 = Color3.fromRGB(53, 58, 67)
                end
            end

            Section.Visible = true
            Tab1.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
            Filler.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
        end)

        -- auto select first tab
        if #LoadedSections == 1 then
            Section.Visible = true
            Tab1.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
            Filler.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
        end

        local Contents = {}

        local function baseElement(height, posY)
            local Inst = Instance.new("ImageButton")
            Inst.Size = UDim2.new(0, 318, 0, height)
            Inst.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Inst.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
            Inst.BorderSizePixel = 0
            Inst.AutoButtonColor = false
            Inst.Parent = Section

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 12)
            Corner.Parent = Inst

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Color3.fromRGB(85, 85, 85)
            Stroke.BorderStrokePosition = Enum.BorderStrokePosition.Inner
            Stroke.Parent = Inst

            Inst.MouseEnter:Connect(function()
                Inst.BackgroundColor3 = Color3.fromRGB(47, 52, 61)
                Stroke.Color = Color3.fromRGB(255, 255, 255)
            end)
            Inst.MouseLeave:Connect(function()
                Inst.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
                Stroke.Color = Color3.fromRGB(85, 85, 85)
            end)

            return Inst, Stroke
        end

        local function nameLabel(parent, lbltxt, icon, yPos)
            local NameLabel = Instance.new("TextLabel")
            NameLabel.TextWrapped = true
            NameLabel.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
            NameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            NameLabel.ZIndex = 2
            NameLabel.TextSize = 14
            NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            NameLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            NameLabel.Text = lbltxt
            NameLabel.Name = "NameLabel"
            NameLabel.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            NameLabel.BackgroundTransparency = 1
            NameLabel.TextXAlignment = Enum.TextXAlignment.Left
            NameLabel.BorderSizePixel = 0
            NameLabel.TextScaled = true
            NameLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            NameLabel.Parent = parent

            local Ico = Instance.new("ImageLabel")
            Ico.Name = "Ico"
            Ico.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Ico.Size = UDim2.new(0, 16, 0, 16)
            Ico.Position = UDim2.new(0.0555, 0, yPos or 0.5, 0)
            Ico.AnchorPoint = Vector2.new(0.5, 0.5)
            Ico.BackgroundTransparency = 1
            Ico.ZIndex = 2
            Ico.BorderSizePixel = 0
            Ico.Visible = false
            Ico.Parent = parent

            local Glyph = Instance.new("TextLabel")
            Glyph.Name = "Glyph"
            Glyph.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Glyph.Size = UDim2.new(0, 16, 0, 16)
            Glyph.Position = UDim2.new(0.0555, 0, yPos or 0.5, 0)
            Glyph.AnchorPoint = Vector2.new(0.5, 0.5)
            Glyph.BackgroundTransparency = 1
            Glyph.TextScaled = true
            Glyph.ZIndex = 2
            Glyph.Visible = false
            Glyph.Parent = parent

            applyIcon(Ico, Glyph, icon)
            local hasIco = Ico.Visible or Glyph.Visible

            NameLabel.Size = hasIco and UDim2.new(0, 245, 0, 14) or UDim2.new(0, 270, 0, 14)
            NameLabel.Position = hasIco and UDim2.new(0.55, 0, yPos or 0.5, 0) or UDim2.new(0.5, 0, yPos or 0.5, 0)

            return NameLabel
        end

        function Contents:Button(lbltxt, icon, cb)
            -- supports (lbltxt, cb) OR (lbltxt, icon, cb)
            if typeof(icon) == "function" then
                cb = icon
                icon = nil
            end

            local BtnInstance, BtnStroke = baseElement(28)
            nameLabel(BtnInstance, lbltxt, icon or "check")

            BtnInstance.MouseButton1Click:Connect(function()
                pcall(cb)
            end)

            return BtnInstance
        end

        function Contents:Label(lbltxt, icon)
            local LabelInstance = baseElement(28)
            local lbl = nameLabel(LabelInstance, lbltxt, icon or "info")

            local upd = {}
            function upd:Update(newtxt)
                lbl.Text = newtxt
            end
            return upd
        end

        function Contents:Toggle(lbltxt, val, icon, cb)
            if typeof(icon) == "function" then
                cb = icon
                icon = nil
            end

            local ToggleInstance, ToggleStroke = baseElement(28)
            nameLabel(ToggleInstance, lbltxt, icon or "toggleon")

            local SwitchBG = Instance.new("Frame")
            SwitchBG.AnchorPoint = Vector2.new(1, 0.5)
            SwitchBG.Position = UDim2.new(0.965, 0, 0.5, 0)
            SwitchBG.Size = UDim2.new(0, 38, 0, 18)
            SwitchBG.BackgroundColor3 = val and Color3.fromRGB(80, 200, 130) or Color3.fromRGB(70, 70, 80)
            SwitchBG.BorderSizePixel = 0
            SwitchBG.ZIndex = 2
            SwitchBG.Parent = ToggleInstance
            local SwitchCorner = Instance.new("UICorner")
            SwitchCorner.CornerRadius = UDim.new(1, 0)
            SwitchCorner.Parent = SwitchBG

            local Knob = Instance.new("Frame")
            Knob.AnchorPoint = Vector2.new(0, 0.5)
            Knob.Position = val and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
            Knob.Size = UDim2.new(0, 14, 0, 14)
            Knob.BackgroundColor3 = Color3.new(1, 1, 1)
            Knob.BorderSizePixel = 0
            Knob.ZIndex = 3
            Knob.Parent = SwitchBG
            local KnobCorner = Instance.new("UICorner")
            KnobCorner.CornerRadius = UDim.new(1, 0)
            KnobCorner.Parent = Knob

            local toggled = val
            if toggled then
                pcall(cb, toggled)
            end

            ToggleInstance.MouseButton1Click:Connect(function()
                toggled = not toggled
                TweenService:Create(SwitchBG, TweenInfo.new(0.2), {
                    BackgroundColor3 = toggled and Color3.fromRGB(80, 200, 130) or Color3.fromRGB(70, 70, 80)
                }):Play()
                TweenService:Create(Knob, TweenInfo.new(0.2), {
                    Position = toggled and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                }):Play()
                pcall(cb, toggled)
            end)

            local api = {}
            function api:Set(v)
                if v ~= toggled then
                    toggled = v
                    TweenService:Create(SwitchBG, TweenInfo.new(0.2), {
                        BackgroundColor3 = toggled and Color3.fromRGB(80, 200, 130) or Color3.fromRGB(70, 70, 80)
                    }):Play()
                    TweenService:Create(Knob, TweenInfo.new(0.2), {
                        Position = toggled and UDim2.new(1, -16, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                    }):Play()
                    pcall(cb, toggled)
                end
            end
            return api
        end

        function Contents:TextBox(lbltxt, sort, icon, cb)
            if typeof(icon) == "function" then
                cb = icon
                icon = nil
            elseif typeof(icon) == "number" and cb == nil then
                cb = icon
                icon = nil
            end

            local TextBoxInstance = baseElement(44)
            nameLabel(TextBoxInstance, lbltxt, icon or "edit", 0.32)

            local Frame2 = Instance.new("Frame")
            Frame2.AnchorPoint = Vector2.new(0.5, 0.5)
            Frame2.BackgroundTransparency = 1
            Frame2.Position = UDim2.new(0.52, 0, 0.73, 0)
            Frame2.Size = UDim2.new(0, 270, 0, 13)
            Frame2.ZIndex = 2
            Frame2.BorderSizePixel = 0
            Frame2.Parent = TextBoxInstance

            local TBFCorner = Instance.new("UICorner")
            TBFCorner.CornerRadius = UDim.new(1, 0)
            TBFCorner.Parent = Frame2
            Frame2.BackgroundTransparency = 0
            Frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame2.BackgroundTransparency = 1

            local TBStroke = Instance.new("UIStroke")
            TBStroke.Color = Color3.fromRGB(85, 85, 85)
            TBStroke.Parent = Frame2

            local TextBoxInput = Instance.new("TextBox")
            TextBoxInput.Active = false
            TextBoxInput.AnchorPoint = Vector2.new(0.5, 0.5)
            TextBoxInput.PlaceholderText = "Type Here.."
            TextBoxInput.Size = UDim2.new(0, 250, 0, 10)
            TextBoxInput.Name = "TextBoxInput"
            TextBoxInput.ZIndex = 2
            TextBoxInput.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBoxInput.Text = ""
            TextBoxInput.Position = UDim2.new(0.5, 0, 0.5, 0)
            TextBoxInput.BorderSizePixel = 0
            TextBoxInput.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
            TextBoxInput.BackgroundTransparency = 1
            TextBoxInput.TextXAlignment = Enum.TextXAlignment.Left
            TextBoxInput.TextWrapped = true
            TextBoxInput.ClearTextOnFocus = false
            TextBoxInput.TextScaled = true
            TextBoxInput.Parent = Frame2

            if sort == 1 then
                TextBoxInput:GetPropertyChangedSignal("Text"):Connect(function()
                    pcall(cb, TextBoxInput.Text)
                end)
            elseif sort == 2 then
                TextBoxInput.FocusLost:Connect(function()
                    pcall(cb, TextBoxInput.Text)
                end)
            elseif sort == 3 then
                TextBoxInput.FocusLost:Connect(function(ep)
                    if ep then pcall(cb, TextBoxInput.Text) end
                end)
            else
                warn("[SpyingLib]: TextBox requires a valid sort mode: 1=TextChanged, 2=FocusLost, 3=EnterPressed")
            end

            return TextBoxInput
        end

        function Contents:Slider(lbltxt, min, max, norm, icon, cb)
            if typeof(icon) == "function" then
                cb = icon
                icon = nil
            end

            local SliderInstance = baseElement(44)
            nameLabel(SliderInstance, lbltxt, icon or "sliders", 0.32)

            local SliderBG = Instance.new("Frame")
            SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
            SliderBG.BackgroundTransparency = 1
            SliderBG.Position = UDim2.new(0.52, 0, 0.73, 0)
            SliderBG.Size = UDim2.new(0, 270, 0, 13)
            SliderBG.ZIndex = 2
            SliderBG.BorderSizePixel = 0
            SliderBG.Parent = SliderInstance

            local SFCorner = Instance.new("UICorner")
            SFCorner.CornerRadius = UDim.new(1, 0)
            SFCorner.Parent = SliderBG
            SliderBG.BackgroundTransparency = 0
            SliderBG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderBG.BackgroundTransparency = 1

            local SFStroke = Instance.new("UIStroke")
            SFStroke.Color = Color3.fromRGB(85, 85, 85)
            SFStroke.Parent = SliderBG

            local SliderInput = Instance.new("Frame")
            SliderInput.AnchorPoint = Vector2.new(0, 0.5)
            SliderInput.Position = UDim2.new(0, 0, 0.5, 0)
            SliderInput.Size = UDim2.new(0, 0, 1, 0)
            SliderInput.ZIndex = 2
            SliderInput.BorderSizePixel = 0
            SliderInput.BackgroundColor3 = Color3.fromRGB(120, 170, 255)
            SliderInput.Parent = SliderBG

            local SICorner = Instance.new("UICorner")
            SICorner.CornerRadius = UDim.new(1, 0)
            SICorner.Parent = SliderInput

            local dragging = false
            local lastValue = 0

            local function setFromAlpha(alpha)
                alpha = math.clamp(alpha, 0, 1)
                local value = math.floor(min + (max - min) * alpha + 0.5)
                SliderInput.Size = UDim2.new(alpha, 0, 1, 0)
                lastValue = value
            end

            local function updateFromInput(x)
                local rel = (x - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X
                setFromAlpha(rel)
            end

            setFromAlpha((norm - min) / (max - min))

            SliderBG.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    sliderInUse = true
                    updateFromInput(input.Position.X)
                end
            end)

            UIS.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateFromInput(input.Position.X)
                end
            end)

            UIS.InputEnded:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                    dragging = false
                    sliderInUse = false
                    if cb then pcall(cb, lastValue) end
                end
            end)

            return {Set = function(_, v)
                setFromAlpha((v - min) / (max - min))
                if cb then pcall(cb, lastValue) end
            end}
        end

        function Contents:Dropdown(lbltxt, options, default, icon, cb)
            if typeof(icon) == "function" then
                cb = icon
                icon = nil
            end

            local DropInstance = baseElement(28)
            nameLabel(DropInstance, lbltxt, icon or "chevrondown")

            local ValueBtn = Instance.new("TextButton")
            ValueBtn.AnchorPoint = Vector2.new(1, 0.5)
            ValueBtn.Position = UDim2.new(0.97, 0, 0.5, 0)
            ValueBtn.Size = UDim2.new(0, 110, 0, 20)
            ValueBtn.BackgroundColor3 = Color3.fromRGB(28, 32, 39)
            ValueBtn.Text = tostring(default or options[1]) .. "  v"
            ValueBtn.TextColor3 = Color3.fromRGB(150, 190, 255)
            ValueBtn.Font = Enum.Font.GothamBold
            ValueBtn.TextSize = 12
            ValueBtn.AutoButtonColor = false
            ValueBtn.BorderSizePixel = 0
            ValueBtn.ZIndex = 2
            ValueBtn.Parent = DropInstance
            local VCorner = Instance.new("UICorner")
            VCorner.CornerRadius = UDim.new(0, 6)
            VCorner.Parent = ValueBtn

            local ListPanel = Instance.new("Frame")
            ListPanel.BackgroundColor3 = Color3.fromRGB(28, 32, 39)
            ListPanel.BorderSizePixel = 0
            ListPanel.Visible = false
            ListPanel.ZIndex = 50
            ListPanel.Size = UDim2.new(0, 130, 0, math.min(#options * 26, 150))
            ListPanel.Parent = MainGUI
            local LPCorner = Instance.new("UICorner")
            LPCorner.CornerRadius = UDim.new(0, 8)
            LPCorner.Parent = ListPanel

            local ListLayout = Instance.new("UIListLayout")
            ListLayout.Parent = ListPanel

            local current = default or options[1]

            for _, opt in ipairs(options) do
                local OptBtn = Instance.new("TextButton")
                OptBtn.Size = UDim2.new(1, 0, 0, 26)
                OptBtn.BackgroundColor3 = opt == current and Color3.fromRGB(60, 90, 140) or Color3.fromRGB(28, 32, 39)
                OptBtn.Text = "  " .. tostring(opt)
                OptBtn.TextColor3 = Color3.new(1, 1, 1)
                OptBtn.Font = Enum.Font.Gotham
                OptBtn.TextSize = 12
                OptBtn.TextXAlignment = Enum.TextXAlignment.Left
                OptBtn.AutoButtonColor = false
                OptBtn.BorderSizePixel = 0
                OptBtn.ZIndex = 51
                OptBtn.Parent = ListPanel

                OptBtn.MouseButton1Click:Connect(function()
                    current = opt
                    ValueBtn.Text = tostring(opt) .. "  v"
                    ListPanel.Visible = false
                    for _, c in ipairs(ListPanel:GetChildren()) do
                        if c:IsA("TextButton") then
                            c.BackgroundColor3 = Color3.fromRGB(28, 32, 39)
                        end
                    end
                    OptBtn.BackgroundColor3 = Color3.fromRGB(60, 90, 140)
                    pcall(cb, opt)
                end)
            end

            ValueBtn.MouseButton1Click:Connect(function()
                ListPanel.Visible = not ListPanel.Visible
                if ListPanel.Visible then
                    local abs = ValueBtn.AbsolutePosition
                    local sz = ValueBtn.AbsoluteSize
                    ListPanel.Position = UDim2.new(0, abs.X - 60, 0, abs.Y + sz.Y + 4)
                end
            end)

            return {Get = function() return current end}
        end

        function Contents:Keybind(lbltxt, default, icon, cb)
            if typeof(icon) == "function" then
                cb = icon
                icon = nil
            end

            local KeyInstance = baseElement(28)
            nameLabel(KeyInstance, lbltxt, icon or "key")

            local KeyBtn = Instance.new("TextButton")
            KeyBtn.AnchorPoint = Vector2.new(1, 0.5)
            KeyBtn.Position = UDim2.new(0.97, 0, 0.5, 0)
            KeyBtn.Size = UDim2.new(0, 70, 0, 20)
            KeyBtn.BackgroundColor3 = Color3.fromRGB(28, 32, 39)
            KeyBtn.Text = default or "None"
            KeyBtn.TextColor3 = Color3.fromRGB(150, 190, 255)
            KeyBtn.Font = Enum.Font.GothamBold
            KeyBtn.TextSize = 12
            KeyBtn.AutoButtonColor = false
            KeyBtn.BorderSizePixel = 0
            KeyBtn.ZIndex = 2
            KeyBtn.Parent = KeyInstance
            local KBCorner = Instance.new("UICorner")
            KBCorner.CornerRadius = UDim.new(0, 6)
            KBCorner.Parent = KeyBtn

            local currentKey = default or "None"
            local listening = false

            KeyBtn.MouseButton1Click:Connect(function()
                listening = true
                KeyBtn.Text = "..."
            end)

            UIS.InputBegan:Connect(function(input, gpe)
                if listening and input.KeyCode ~= Enum.KeyCode.Unknown then
                    listening = false
                    currentKey = tostring(input.KeyCode):gsub("Enum.KeyCode.", "")
                    KeyBtn.Text = currentKey
                elseif not listening and not gpe then
                    if Enum.KeyCode[currentKey] and input.KeyCode == Enum.KeyCode[currentKey] then
                        pcall(cb, true)
                    end
                end
            end)

            return {Get = function() return currentKey end}
        end

        return Contents
    end

    return Tabs
end

return SpyingLib
