-- SPOOKI HUB LIBRARY v1
local SpookiThemePresets = {
    Spooki = {
        Accent      = Color3.fromRGB(40, 110, 255),
        Gradient    = Color3.fromRGB(10, 40, 120),
        Background  = Color3.fromRGB(4, 6, 12),
        SectionBg   = Color3.fromRGB(8, 10, 18),
        Element     = Color3.fromRGB(12, 16, 28),
    },
    Dark = {
        Accent      = Color3.fromRGB(65, 150, 255),
        Gradient    = Color3.fromRGB(0, 80, 200),
        Background  = Color3.fromRGB(22, 22, 26),
        SectionBg   = Color3.fromRGB(16, 16, 20),
        Element     = Color3.fromRGB(28, 28, 34),
    },
    Darker = {
        Accent      = Color3.fromRGB(88, 101, 242),
        Gradient    = Color3.fromRGB(50, 60, 180),
        Background  = Color3.fromRGB(14, 14, 16),
        SectionBg   = Color3.fromRGB(10, 10, 12),
        Element     = Color3.fromRGB(16, 16, 18),
    },
    Purple = {
        Accent      = Color3.fromRGB(150, 0, 255),
        Gradient    = Color3.fromRGB(100, 0, 180),
        Background  = Color3.fromRGB(18, 15, 22),
        SectionBg   = Color3.fromRGB(14, 12, 18),
        Element     = Color3.fromRGB(22, 18, 28),
    },
}
local Library do 
    local Workspace = game:GetService("Workspace")
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local HttpService = game:GetService("HttpService")
    local RunService = game:GetService("RunService")
    local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local Lighting = game:GetService("Lighting")

    gethui = gethui or function()
        return CoreGui
    end
    
    local LocalPlayer = Players.LocalPlayer
    local Camera = Workspace.CurrentCamera
    local Mouse = LocalPlayer:GetMouse()

    local FromRGB = Color3.fromRGB
    local FromHSV = Color3.fromHSV
    local FromHex = Color3.fromHex

    local RGBSequence = ColorSequence.new
    local RGBSequenceKeypoint = ColorSequenceKeypoint.new
    local NumSequence = NumberSequence.new
    local NumSequenceKeypoint = NumberSequenceKeypoint.new

    local UDim2New = UDim2.new
    local UDimNew = UDim.new
    local UDim2FromOffset = UDim2.fromOffset
    local Vector2New = Vector2.new
    local Vector3New = Vector3.new

    local MathClamp = math.clamp
    local MathFloor = math.floor
    local MathAbs = math.abs
    local MathSin = math.sin

    local TableInsert = table.insert
    local TableFind = table.find
    local TableRemove = table.remove
    local TableConcat = table.concat
    local TableClone = table.clone
    local TableUnpack = table.unpack

    local StringFormat = string.format
    local StringFind = string.find
    local StringGSub = string.gsub
    local StringLower = string.lower
    local StringLen = string.len

    local InstanceNew = Instance.new

    local RectNew = Rect.new

    local function DetectDevice()
        if game and game.GetService then
            local UserInputService = game:GetService("UserInputService")
            local GuiService = game:GetService("GuiService")

            if GuiService:IsTenFootInterface() then
                return "Console"
            end

            if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
                return "Mobile"
            end

            if UserInputService.TouchEnabled and UserInputService.KeyboardEnabled then
                local camera = workspace.CurrentCamera
                if camera then
                    local viewportSize = camera.ViewportSize
                    if viewportSize.X < 1024 or viewportSize.Y < 768 then
                        return "Mobile"
                    end
                end
            end

            if UserInputService.KeyboardEnabled or UserInputService.MouseEnabled then
                return "PC"
            end

            if UserInputService.GamepadEnabled then
                return "Console"
            end

            return "Unknown"
        else

            return "PC"
        end
    end

    local IsMobile = (DetectDevice() == "Mobile")

    Library = {
        Theme =  { },
        ToClean = { },

        MenuKeybind = tostring(Enum.KeyCode.RightAlt), 

        Flags = { },
        FlagDefaults = { },

        EmergencyStopCallbacks = { },

        Tween = {
            Time = 0.3,
            Style = Enum.EasingStyle.Quad,
            Direction = Enum.EasingDirection.Out
        },

        FadeSpeed = 0.2,

        Pages = { },
        Sections = { },

        Connections = { },
        Threads = { },

        ThemeMap = { },
        ThemeItems = { },

        OpenFrames = { },

        SetFlags = { },

        UnnamedConnections = 0,
        UnnamedFlags = 0,

        Holder = nil,
        NotifHolder = nil,
        UnusedHolder = nil,

        Font = nil
    }

    Library.__index = Library
    Library.Sections.__index = Library.Sections
    Library.Pages.__index = Library.Pages

    local Keys = {
        ["Unknown"]           = "Unknown",
        ["Backspace"]         = "Back",
        ["Tab"]               = "Tab",
        ["Clear"]             = "Clear",
        ["Return"]            = "Return",
        ["Pause"]             = "Pause",
        ["Escape"]            = "Escape",
        ["Space"]             = "Space",
        ["QuotedDouble"]      = '"',
        ["Hash"]              = "#",
        ["Dollar"]            = "$",
        ["Percent"]           = "%",
        ["Ampersand"]         = "&",
        ["Quote"]             = "'",
        ["LeftParenthesis"]   = "(",
        ["RightParenthesis"]  = " )",
        ["Asterisk"]          = "*",
        ["Plus"]              = "+",
        ["Comma"]             = ",",
        ["Minus"]             = "-",
        ["Period"]            = ".",
        ["Slash"]             = "`",
        ["Three"]             = "3",
        ["Seven"]             = "7",
        ["Eight"]             = "8",
        ["Colon"]             = ":",
        ["Semicolon"]         = ";",
        ["LessThan"]          = "<",
        ["GreaterThan"]       = ">",
        ["Question"]          = "?",
        ["Equals"]            = "=",
        ["At"]                = "@",
        ["LeftBracket"]       = "LeftBracket",
        ["RightBracket"]      = "RightBracked",
        ["BackSlash"]         = "BackSlash",
        ["Caret"]             = "^",
        ["Underscore"]        = "_",
        ["Backquote"]         = "`",
        ["LeftCurly"]         = "{",
        ["Pipe"]              = "|",
        ["RightCurly"]        = "}",
        ["Tilde"]             = "~",
        ["Delete"]            = "Delete",
        ["End"]               = "End",
        ["KeypadZero"]        = "Keypad0",
        ["KeypadOne"]         = "Keypad1",
        ["KeypadTwo"]         = "Keypad2",
        ["KeypadThree"]       = "Keypad3",
        ["KeypadFour"]        = "Keypad4",
        ["KeypadFive"]        = "Keypad5",
        ["KeypadSix"]         = "Keypad6",
        ["KeypadSeven"]       = "Keypad7",
        ["KeypadEight"]       = "Keypad8",
        ["KeypadNine"]        = "Keypad9",
        ["KeypadPeriod"]      = "KeypadP",
        ["KeypadDivide"]      = "KeypadD",
        ["KeypadMultiply"]    = "KeypadM",
        ["KeypadMinus"]       = "KeypadM",
        ["KeypadPlus"]        = "KeypadP",
        ["KeypadEnter"]       = "KeypadE",
        ["KeypadEquals"]      = "KeypadE",
        ["Insert"]            = "Insert",
        ["Home"]              = "Home",
        ["PageUp"]            = "PageUp",
        ["PageDown"]          = "PageDown",
        ["RightShift"]        = "RightShift",
        ["LeftShift"]         = "LeftShift",
        ["RightControl"]      = "RightControl",
        ["LeftControl"]       = "LeftControl",
        ["LeftAlt"]           = "LeftAlt",
        ["RightAlt"]          = "RightAlt"
    }

    local _mp = SpookiThemePresets.Spooki
    local Themes = {
        ["Preset"] = {
            ["AccentGradient"]        = _mp.Gradient,
            ["Background 2"]          = _mp.Background,
            ["Background"]            = _mp.Background,
            ["Text"]                  = FromRGB(255, 255, 255),
            ["Outline"]               = _mp.Accent,
            ["Section Top"]           = _mp.Element,
            ["Section Background"]    = _mp.SectionBg,
            ["Section Background 2"]  = _mp.Element,
            ["Accent"]                = _mp.Accent,
            ["Element"]               = _mp.Element,
        }
    }

    Library.Theme = TableClone(Themes["Preset"])


    local ActiveGradients = {}
    local function ApplySpookiBorder(instance, thickness)
        if not instance or instance:FindFirstChild("SpookiStroke") then
            return
        end
        local stroke = InstanceNew("UIStroke")
        stroke.Name = "SpookiStroke"
        stroke.Color = FromRGB(255, 255, 255)
        stroke.Thickness = thickness or 1.6
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.LineJoinMode = Enum.LineJoinMode.Round
        stroke.Parent = instance
        local gradient = InstanceNew("UIGradient")
        gradient.Name = "SpookiGradient"
        gradient.Color = RGBSequence({
            RGBSequenceKeypoint(0, FromRGB(40, 110, 255)),
            RGBSequenceKeypoint(0.25, FromRGB(10, 20, 40)),
            RGBSequenceKeypoint(0.5, FromRGB(0, 0, 0)),
            RGBSequenceKeypoint(0.75, FromRGB(10, 20, 40)),
            RGBSequenceKeypoint(1, FromRGB(40, 110, 255))
        })
        gradient.Rotation = math.random(0, 359)
        gradient.Parent = stroke
        TableInsert(ActiveGradients, gradient)
        return stroke
    end

    RunService.RenderStepped:Connect(function(dt)
        for i = #ActiveGradients, 1, -1 do
            local gradient = ActiveGradients[i]
            if gradient and gradient.Parent then
                gradient.Rotation = (gradient.Rotation + 90 * dt) % 360
            else
                TableRemove(ActiveGradients, i)
            end
        end
    end)


    local Tween = { } do
        Tween.__index = Tween

        Tween.Create = function(self, Item, Info, Goal, IsRawItem)
            if not Item then return nil end
            Item = IsRawItem and Item or (type(Item) == "table" and Item.Instance) or Item
            if not Item or not Item.Parent then return nil end
            Info = Info or TweenInfo.new(Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction)

            local NewTween = {
                Tween = TweenService:Create(Item, Info, Goal),
                Info = Info,
                Goal = Goal,
                Item = Item
            }

            NewTween.Tween:Play()

            setmetatable(NewTween, Tween)

            return NewTween
        end

        Tween.GetProperty = function(self, Item)
            Item = Item or self.Item 

            if Item:IsA("Frame") then
                return { "BackgroundTransparency" }
            elseif Item:IsA("TextLabel") or Item:IsA("TextButton") then
                return { "TextTransparency", "BackgroundTransparency" }
            elseif Item:IsA("ImageLabel") or Item:IsA("ImageButton") then
                return { "BackgroundTransparency", "ImageTransparency" }
            elseif Item:IsA("ScrollingFrame") then
                return { "BackgroundTransparency", "ScrollBarImageTransparency" }
            elseif Item:IsA("TextBox") then
                return { "TextTransparency", "BackgroundTransparency" }
            elseif Item:IsA("UIStroke") then 
                return { "Transparency" }
            end
        end

        Tween.FadeItem = function(self, Item, Property, Visibility, Speed)
            local Item = Item or self.Item 

            local OldTransparency = Item[Property]
            Item[Property] = Visibility and 1 or OldTransparency

            local NewTween = Tween:Create(Item, TweenInfo.new(Speed or Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction), {
                [Property] = Visibility and OldTransparency or 1
            }, true)

            Library:Connect(NewTween.Tween.Completed, function()
                if not Visibility then 
                    task.wait()
                    Item[Property] = OldTransparency
                end
            end)

            return NewTween
        end

        Tween.Get = function(self)
            if not self.Tween then 
                return
            end

            return self.Tween, self.Info, self.Goal
        end

        Tween.Pause = function(self)
            if not self.Tween then 
                return
            end

            self.Tween:Pause()
        end

        Tween.Play = function(self)
            if not self.Tween then 
                return
            end

            self.Tween:Play()
        end

        Tween.Clean = function(self)
            if not self.Tween then 
                return
            end

            Tween:Pause()
            self = nil
        end
    end

    local Instances = { } do
        Instances.__index = Instances

        Instances.Create = function(self, Class, Properties)
            local NewItem = {
                Instance = InstanceNew(Class),
                Properties = Properties,
                Class = Class
            }

            setmetatable(NewItem, Instances)

            for Property, Value in NewItem.Properties do
                NewItem.Instance[Property] = Value
            end

            return NewItem
        end

        Instances.ApplyBorder = function(self, thickness)
            if self and self.Instance then
                ApplySpookiBorder(self.Instance, thickness)
            end
            return self
        end

        Instances.FadeItem = function(self, Visibility, Speed)
            local Item = self.Instance

            if Visibility == true then 
                Item.Visible = true
            end

            local Descendants = Item:GetDescendants()
            TableInsert(Descendants, Item)

            local NewTween

            for Index, Value in Descendants do 
                local TransparencyProperty = Tween:GetProperty(Value)

                if not TransparencyProperty then 
                    continue
                end

                if type(TransparencyProperty) == "table" then 
                    for _, Property in TransparencyProperty do 
                        NewTween = Tween:FadeItem(Value, Property, not Visibility, Speed)
                    end
                else
                    NewTween = Tween:FadeItem(Value, TransparencyProperty, not Visibility, Speed)
                end
            end
        end

        Instances.AddToTheme = function(self, Properties)
            if not self.Instance then 
                return
            end

            Library:AddToTheme(self, Properties)
        end

        Instances.ChangeItemTheme = function(self, Properties)
            if not self.Instance then 
                return
            end

            Library:ChangeItemTheme(self, Properties)
        end

        Instances.Connect = function(self, Event, Callback, Name)
            if not self.Instance then 
                return
            end

            if not self.Instance[Event] then 
                return
            end

            if IsMobile then
                if Event == "MouseButton1Down" or Event == "MouseButton1Click" then 
                    Event = "TouchTap"
                elseif Event == "MouseButton2Down" or Event == "MouseButton2Click" then 
                    Event = "TouchLongPress"
                end
            end

            return Library:Connect(self.Instance[Event], Callback, Name)
        end

        Instances.Tween = function(self, Info, Goal)
            if not self.Instance then 
                return
            end

            return Tween:Create(self, Info, Goal)
        end

        Instances.Disconnect = function(self, Name)
            if not self.Instance then 
                return
            end

            return Library:Disconnect(Name)
        end

        Instances.Clean = function(self)
            if not self.Instance then 
                return
            end

            self.Instance:Destroy()
            self = nil
        end

        Instances.MakeDraggable = function(self)
            if not self.Instance then 
                return
            end
        
            local Gui = self.Instance
            local Dragging = false 
            local DragStart
            local StartPosition 
        
            local function GetUIScale()
                local scaleObj = Gui:FindFirstChildOfClass("UIScale")
                if scaleObj then return scaleObj.Scale end
                local parent = Gui.Parent
                while parent do
                    local s = parent:FindFirstChildOfClass("UIScale")
                    if s then return s.Scale end
                    if parent:IsA("ScreenGui") then break end
                    parent = parent.Parent
                end
                return 1
            end
        
            self:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = true
                    DragStart = Input.Position
                    StartPosition = Gui.Position
                    Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Dragging = false
                        end
                    end)
                end
            end)
        
            Library:Connect(UserInputService.InputChanged, function(Input)
                if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) and Dragging then
                    local DragDelta = Input.Position - DragStart
                    Gui.Position = UDim2New(
                        StartPosition.X.Scale,
                        StartPosition.X.Offset + DragDelta.X,
                        StartPosition.Y.Scale,
                        StartPosition.Y.Offset + DragDelta.Y
                    )
                end
            end)
        
            return Dragging
        end

        Instances.MakeResizeable = function(self, Minimum, Maximum, Window)
            if not self.Instance then 
                return
            end

            local Gui = self.Instance

            local Resizing = false 
            local CurrentSide = nil

            local StartMouse = nil 
            local StartPosition = nil 
            local StartSize = nil
            
            local EdgeThickness = 2

            local MakeEdge = function(Name, Position, Size)
                local Button = Instances:Create("TextButton", {
                    Name = "\0",
                    Size = Size,
                    Position = Position,
                    BackgroundColor3 = FromRGB(166, 147, 243),
                    BackgroundTransparency = 1,
                    Text = "",
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    Parent = Gui,
                    ZIndex = 99999,
                })  Button:AddToTheme({BackgroundColor3 = "Accent"})

                return Button
            end

            local Edges = {
                {Button = MakeEdge(
                    "Left", 
                    UDim2New(0, 0, 0, 0), 
                    UDim2New(0, EdgeThickness, 1, 0)), 
                    Side = "L"
                },

                {Button = MakeEdge(
                    "Right", 
                    UDim2New(1, -EdgeThickness, 0, 0), 
                    UDim2New(0, EdgeThickness, 1, 0)), 
                    Side = "R"
                },

                {Button = MakeEdge(
                    "Top", UDim2New(0, 0, 0, 0), 
                    UDim2New(1, 0, 0, EdgeThickness)), 
                    Side = "T"
                },

                {Button = MakeEdge(
                    "Bottom", 
                    UDim2New(0, 0, 1, -EdgeThickness), 
                    UDim2New(1, 0, 0, EdgeThickness)), 
                    Side = "B"
                },
            }

            local BeginResizing = function(Side)
                Resizing = true 
                CurrentSide = Side 

                StartMouse = UserInputService:GetMouseLocation()

                StartPosition = Vector2New(Gui.Position.X.Offset, Gui.Position.Y.Offset)
                StartSize = Vector2New(Gui.Size.X.Offset, Gui.Size.Y.Offset)
                
                for Index, Value in Edges do 
                    Value.Button:Tween(nil, {BackgroundTransparency = (Value.Side == Side) and 0 or 1})
                end
            end

            local EndResizing = function()
                Resizing = false 
                CurrentSide = nil

                for Index, Value in Edges do 
                    Value.Button.Instance.BackgroundTransparency = 1
                end
            end

            for Index, Value in Edges do 
                Value.Button:Connect("InputBegan", function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        BeginResizing(Value.Side)
                    end
                end)
            end

            Library:Connect(UserInputService.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if Resizing then
                        EndResizing()
                    end
                end
            end)

            Library:Connect(RunService.RenderStepped, function()
                if not Resizing or not CurrentSide then 
                    return 
                end

                local MouseLocation = UserInputService:GetMouseLocation()
                local dx = MouseLocation.X - StartMouse.X
                local dy = MouseLocation.Y - StartMouse.Y
            
                local x, y = StartPosition.X, StartPosition.Y
                local w, h = StartSize.X, StartSize.Y

                if CurrentSide == "L" then
                    x = StartPosition.X + dx
                    w = StartSize.X - dx

                    if Window then
                        Window.Left.Y = h
                    end
                elseif CurrentSide == "R" then
                    w = StartSize.X + dx

                    if Window then
                        Window.Right.Y = h
                    end
                elseif CurrentSide == "T" then
                    y = StartPosition.Y + dy
                    h = StartSize.Y - dy

                    if Window then
                        Window.Top.X = w
                    end
                elseif CurrentSide == "B" then
                    h = StartSize.Y + dy

                    if Window then
                        Window.Bottom.X = w
                    end
                end
            
                if w < Minimum.X then
                    if CurrentSide == "L" then
                        x = x - (Minimum.X - w)
                    end
                    w = Minimum.X
                end
                if h < Minimum.Y then
                    if CurrentSide == "T" then
                        y = y - (Minimum.Y - h)
                    end
                    h = Minimum.Y
                end
            
                self:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2FromOffset(x, y)})
                self:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2FromOffset(w, h)})
            end)
        end

        Instances.OnHover = function(self, Function)
            if not self.Instance then 
                return
            end
            
            return Library:Connect(self.Instance.MouseEnter, Function)
        end

        Instances.OnHoverLeave = function(self, Function)
            if not self.Instance then 
                return
            end
            
            return Library:Connect(self.Instance.MouseLeave, Function)
        end
    end

    local CustomFont = { } do
        function CustomFont:New(Name, Weight, Style, Data)
            if not isfile(Data.Id) then 
                writefile(Data.Id, game:HttpGet(Data.Url))
            end

            local Data = {
                name = Name,
                faces = {
                    {
                        name = Name,
                        weight = Weight,
                        style = Style,
                        assetId = getcustomasset(Data.Id)
                    }
                }
            }

            writefile(`{Library.Folders.Assets}/{Name}.font`, HttpService:JSONEncode(Data))
            return getcustomasset(`{Library.Folders.Assets}/{Name}.font`)
        end

        local SemiBold = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)

        local Regular = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)

        local Light = Font.new("rbxassetid://12187365364", Enum.FontWeight.Light, Enum.FontStyle.Normal)

        Library.Fonts = {
            ["SemiBold"] = SemiBold,
            ["Regular"] = Regular,
            ["Light"] = Light,
            ["Indie Flower"] = Font.fromEnum(Enum.Font.IndieFlower),
            ["Fredoka One"] = Font.fromEnum(Enum.Font.FredokaOne),
            ["Cartoon"] = Font.fromEnum(Enum.Font.Cartoon),
        }

        Library.Font = SemiBold
    end

    Library.Holder = Instances:Create("ScreenGui", {
        Parent = gethui(),
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        DisplayOrder = 2,
        ResetOnSpawn = false
    })

    Library.UnusedHolder = Instances:Create("ScreenGui", {
        Parent = gethui(),
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        Enabled = false,
        ResetOnSpawn = false
    })

    
    local function shouldBorder(inst)
        return inst:IsA("TextButton") or inst:IsA("TextBox") or (inst:IsA("Frame") and inst.BackgroundTransparency < 1)
    end

    if Library.Holder and Library.Holder.Instance then
        Library.Holder.Instance.DescendantAdded:Connect(function(inst)
            task.defer(function()
                if inst and inst.Parent and shouldBorder(inst) then
                    ApplySpookiBorder(inst, inst:IsA("TextButton") and 1.5 or 1.3)
                end
            end)
        end)
    end

Library.NotifHolder  = Instances:Create("Frame", {
        Parent = Library.Holder.Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        Size = UDim2New(0, 0, 1, 0),
        Position = UDim2New(1, 0, 0, 0),
        AnchorPoint = Vector2New(1, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = FromRGB(255, 255, 255)
    })
    
    Instances:Create("UIListLayout", {
        Parent = Library.NotifHolder.Instance,
        Name = "\0",
        Padding = UDimNew(0, 12),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    Instances:Create("UIPadding", {
        Parent = Library.NotifHolder.Instance,
        Name = "\0",
        PaddingTop = UDimNew(0, 12),
        PaddingBottom = UDimNew(0, 12),
        PaddingRight = UDimNew(0, 12),
        PaddingLeft = UDimNew(0, 12)
    })    

    Library.Unload = function(self)
        for Index, Value in self.Connections do 
            pcall(function() Value.Connection:Disconnect() end)
        end

        for Index, Value in self.Threads do 
            pcall(function() coroutine.close(Value) end)
        end

        if self.Holder then 
            pcall(function() self.Holder:Clean() end)
        end

        if self.UnusedHolder then 
            pcall(function() self.UnusedHolder:Clean() end)
        end

        if self.WatermarkFrame then
            pcall(function() 
                self.WatermarkFrame.Instance:Destroy()
                self.WatermarkFrame = nil
            end)
        end

        for _, Object in pairs(self.ToClean) do
            pcall(function()
                if Object and Object.Parent then
                    Object:Destroy()
                end
            end)
        end

        Library = nil 
        getgenv().Library = nil
    end

    Library.GetImage = function(self, Image)
        local ImageData = self.Images[Image]

        if not ImageData then 
            return
        end

        return getcustomasset(self.Folders.Assets .. "/" .. ImageData[1])
    end

    Library.Round = function(self, Number, Float)
        local Multiplier = 1 / (Float or 1)
        return MathFloor(Number * Multiplier) / Multiplier
    end

    Library.Thread = function(self, Function)
        local NewThread = coroutine.create(Function)
        local success, result = coroutine.resume(NewThread)
        if not success then
            warn("Library thread error:", result)
        end
        return NewThread
    end
    
    Library.SafeCall = function(self, Function, ...)
        local Arguements = { ... }
        local Success, Result = pcall(Function, TableUnpack(Arguements))

        if not Success then
            warn(Result)
            return false
        end

        return Success
    end

    Library.Connect = function(self, Event, Callback, Name)
        Name = Name or StringFormat("connection_number_%s_%s", self.UnnamedConnections + 1, HttpService:GenerateGUID(false))

        local NewConnection = {
            Event = Event,
            Callback = Callback,
            Name = Name,
            Connection = nil
        }

        Library:Thread(function()
            NewConnection.Connection = Event:Connect(Callback)
        end)

        TableInsert(self.Connections, NewConnection)
        return NewConnection
    end

    Library.Disconnect = function(self, Name)
        for _, Connection in self.Connections do 
            if Connection.Name == Name then
                Connection.Connection:Disconnect()
                break
            end
        end
    end

    Library.NextFlag = function(self)
        local FlagNumber = self.UnnamedFlags + 1
        return StringFormat("flag_number_%s_%s", FlagNumber, HttpService:GenerateGUID(false))
    end

    Library.AddToTheme = function(self, Item, Properties)
        Item = Item.Instance or Item 

        local ThemeData = {
            Item = Item,
            Properties = Properties,
        }

        for Property, Value in ThemeData.Properties do
            if type(Value) == "string" then
                Item[Property] = self.Theme[Value]
            else
                Item[Property] = Value()
            end
        end

        TableInsert(self.ThemeItems, ThemeData)
        self.ThemeMap[Item] = ThemeData
    end

    Library.ToRich = function(self, Text, Color)
        return `<font color="rgb({MathFloor(Color.R * 255)}, {MathFloor(Color.G * 255)}, {MathFloor(Color.B * 255)})">{Text}</font>`
    end

    Library.RegisterEmergencyStop = function(self, Callback)
        if type(Callback) ~= "function" then return end
        TableInsert(self.EmergencyStopCallbacks, Callback)
    end

    Library.TriggerEmergencyStop = function(self)
        for _, Callback in self.EmergencyStopCallbacks do
            pcall(Callback)
        end
    end

    Library.GetConfig = function(self)
        local Config = { } 

        local Success, Result = Library:SafeCall(function()
            for Index, Value in pairs(Library.Flags) do 
                if type(Value) == "table" and Value.Key ~= nil then
                    Config[Index] = {Key = tostring(Value.Key), Mode = Value.Mode or Value.ModeSelected or "Toggle"}
                elseif type(Value) == "table" and (Value.Color or Value.HexValue) then
                    local Hex = Value.HexValue or (Value.Color and typeof(Value.Color) == "Color3" and Value.Color:ToHex())
                    Config[Index] = {Color = "#" .. (Hex or "FFFFFF"), Alpha = Value.Alpha}
                else
                    Config[Index] = Value
                end
            end
        end)

        return HttpService:JSONEncode(Config)
    end

    Library.LoadConfig = function(self, Config)
        local Decoded = HttpService:JSONDecode(Config)

        local Success, Result = Library:SafeCall(function()
            for Index, Value in pairs(Decoded) do 
                local SetFunction = Library.SetFlags[Index]

                if not SetFunction then
                    continue
                end

                if type(Value) == "table" and Value.Key ~= nil then
                    SetFunction(Value)
                elseif type(Value) == "table" and Value.Color then
                    SetFunction(Value.Color, Value.Alpha)
                elseif Value ~= nil then
                    SetFunction(Value)
                end
            end
        end)

        return Success, Result
    end

    Library.DeleteConfig = function(self, Config)
        if isfile(Library.Folders.Configs .. "/" .. Config) then 
            delfile(Library.Folders.Configs .. "/" .. Config)
        end
    end

    Library.RefreshConfigsList = function(self, Element)
        if not Element or not Element.Refresh then 
            return 
        end

        local List = { }

        if isfolder(Library.Folders.Configs) then
            for Index, FilePath in listfiles(Library.Folders.Configs) do
                local FileName = FilePath:match("[^/^\\]+$")

                if FileName and FileName:sub(-5):lower() == ".json" then
                    TableInsert(List, FileName)
                end
            end
        end

        Element:Refresh(List)
    end

    Library.ChangeItemTheme = function(self, Item, Properties)
        Item = Item.Instance or Item

        if not self.ThemeMap[Item] then 
            return
        end

        self.ThemeMap[Item].Properties = Properties
        self.ThemeMap[Item] = self.ThemeMap[Item]
    end

    Library.ChangeTheme = function(self, Theme, Color)
        self.Theme[Theme] = Color

        for _, Item in self.ThemeItems do
            for Property, Value in Item.Properties do
                if type(Value) == "string" and Value == Theme then
                    Item.Item[Property] = Color
                elseif type(Value) == "function" then
                    Item.Item[Property] = Value()
                end
            end
        end
    end

    Library.IsMouseOverFrame = function(self, Frame)
        if not Frame then return false end
        Frame = Frame.Instance or Frame
        if not Frame or not Frame.Parent then return false end

        local MousePosition = Vector2New(Mouse.X, Mouse.Y)

        return MousePosition.X >= Frame.AbsolutePosition.X and MousePosition.X <= Frame.AbsolutePosition.X + Frame.AbsoluteSize.X 
        and MousePosition.Y >= Frame.AbsolutePosition.Y and MousePosition.Y <= Frame.AbsolutePosition.Y + Frame.AbsoluteSize.Y
    end

    Library.Lerp = function(self, Start, Finish, Time)
        return Start + (Finish - Start) * Time
    end

    Library.CompareVectors = function(self, PointA, PointB)
        return (PointA.X < PointB.X) or (PointA.Y < PointB.Y)
    end

    Library.IsClipped = function(self, Object, Column)
        local Parent = Column
        
        local BoundryTop = Parent.AbsolutePosition
        local BoundryBottom = BoundryTop + Parent.AbsoluteSize

        local Top = Object.AbsolutePosition
        local Bottom = Top + Object.AbsoluteSize 

        return Library:CompareVectors(Top, BoundryTop) or Library:CompareVectors(BoundryBottom, Bottom)
    end

    Library.GetCalculatedRayPosition = function(self, Position, Normal, Origin, Direction)
        local N = Normal
        local D = Direction
        local V = Origin - Position

        local Number = (N.x * V.x) + (N.y * V.y) + (N.z * V.z)
        local Den = (N.x * D.x) + (N.y * D.y) + (N.z * D.z)
        local A = -Number / Den

        return Origin + (A * Direction)
    end

    Library.MaxConnections = 5000
    Library.ConnectionCleanupInterval = 300
    Library.LargeScriptMode = false
    Library.RenderYieldInterval = 0.03

    Library.BatchUpdate = function(self, callback)
        local oldSetting = self._batchMode
        self._batchMode = true
        local ok, result = pcall(callback)
        self._batchMode = false
        return ok, result
    end

    Library.CleanupConnections = function(self)
        local alive = {}
        for _, conn in ipairs(self.Connections) do
            if conn.Connection and conn.Connection.Connected then
                table.insert(alive, conn)
            end
        end
        self.Connections = alive
        if #self.Connections > self.MaxConnections then
            self.Connections = {table.unpack(self.Connections, #self.Connections - self.MaxConnections + 1)}
        end
    end

    Library.ChangeTheme = function(self, Theme, Color)
        if self._batchMode then
            self._batchedThemes = self._batchedThemes or {}
            self._batchedThemes[Theme] = Color
            return
        end
        self.Theme[Theme] = Color
        for _, Item in self.ThemeItems do
            for Property, Value in Item.Properties do
                if type(Value) == "string" and Value == Theme then
                    Item.Item[Property] = Color
                elseif type(Value) == "function" then
                    Item.Item[Property] = Value()
                end
            end
        end
    end

    Library.FlushBatchedThemes = function(self)
        if not self._batchedThemes then return end
        for theme, color in pairs(self._batchedThemes) do
            self.Theme[theme] = color
        end
        for _, Item in self.ThemeItems do
            for Property, Value in Item.Properties do
                if type(Value) == "string" and self._batchedThemes[Value] then
                    Item.Item[Property] = self._batchedThemes[Value]
                elseif type(Value) == "function" then
                    Item.Item[Property] = Value()
                end
            end
        end
        self._batchedThemes = nil
    end

    Library.UpdateText = function(self)
        for Index, Value in self.UnusedHolder.Instance:GetDescendants() do 
            if Value:IsA("TextLabel") or Value:IsA("TextButton") or Value:IsA("TextBox") then
                Value.FontFace = Library.Font
            end
        end

        for Index, Value in self.Holder.Instance:GetDescendants() do 
            if Value:IsA("TextLabel") or Value:IsA("TextButton") or Value:IsA("TextBox") then
                Value.FontFace = Library.Font
            end
        end
    end

    Library.MakeBlurred = function(self, Item, Window)
        Item = Item.Instance
        local BlurItem = Item

        local Part = Instances:Create("Part", {
            Material = Enum.Material.Glass,
            Transparency = 1,
            Reflectance = 0,
            CastShadow = false,
            Anchored = true,
            CanCollide = false,
            CanQuery = false,
            CollisionGroup = " ",
            Size = Vector3New(1, 1, 1) * 0.01,
            Color = FromRGB(0,0,0),
            Parent = Camera
        })

        table.insert(self.ToClean, Part.Instance)
            
        local BlockMesh = Instances:Create("BlockMesh", {Parent = Part.Instance})

        local DepthOfField = Instances:Create("DepthOfFieldEffect", {
            Parent = Lighting,
            Enabled = true,
            FarIntensity = 0,
            FocusDistance = 0,
            InFocusRadius = 1000,
            NearIntensity = 1,
            Name = ""
        })

        table.insert(self.ToClean, DepthOfField.Instance)

        Library:Connect(RunService.RenderStepped, function()
            if Window.IsOpen then
                if Item.Visible then
                    DepthOfField:Tween(nil, {NearIntensity = 1})

                    Part:Tween(nil, {Transparency = 0.97})
                    Part:Tween(nil, {Size = Vector3New(1, 1, 1) * 0.01})

                    local Corner0 = BlurItem.AbsolutePosition;
                    local Corner1 = Corner0 + BlurItem.AbsoluteSize;
                        
                    local Ray0 = Camera.ScreenPointToRay(Camera, Corner0.X, Corner0.Y, 1);
                    local Ray1 = Camera.ScreenPointToRay(Camera, Corner1.X, Corner1.Y, 1);

                    local Origin = Camera.CFrame.Position + Camera.CFrame.LookVector * (0.05 - Camera.NearPlaneZ);

                    local Normal = Camera.CFrame.LookVector;

                    local Position0 = Library:GetCalculatedRayPosition(Origin, Normal, Ray0.Origin, Ray0.Direction)
                    local Position1 = Library:GetCalculatedRayPosition(Origin, Normal, Ray1.Origin, Ray1.Direction)

                    Position0 = Camera.CFrame:PointToObjectSpace(Position0)
                    Position1 = Camera.CFrame:PointToObjectSpace(Position1)

                    local Size = Position1 - Position0
                    local Center = (Position0 + Position1) / 2

                    BlockMesh.Instance.Offset = Center
                    BlockMesh.Instance.Scale  = Size / 0.0101

                    Part.Instance.CFrame = Camera.CFrame
                else
                    DepthOfField:Tween(nil, {NearIntensity = 0})
                    BlockMesh.Instance.Offset = Vector3New(0, 0, 0)
                    BlockMesh.Instance.Scale  = Vector3New(0, 0, 0)
                end
            else
                DepthOfField:Tween(nil, {NearIntensity = 0})
                BlockMesh.Instance.Offset = Vector3New(0, 0, 0)
                BlockMesh.Instance.Scale  = Vector3New(0, 0, 0)
            end
        end)
    end

    Library.EscapePattern = function(self, String)
        local ShouldEscape = false 

        if string.match(String, "[%(%)%.%%%+%-%*%?%[%]%^%$]") then
            ShouldEscape = true
        end

        if ShouldEscape then
            return StringGSub(String, "[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
        end

        return String
    end

    do 
        Library.CreateColorpicker = function(self, Data)
            local Colorpicker = {
                Flag = Data.Flag,

                Hue = 0,
                Saturation = 0,
                Value = 0,

                Alpha = 0,

                Color = FromRGB(0, 0, 0),
                HexValue = "#000000",

                SavedColors = { },

                IsOpen = false 
            }

            local Items = { } do
                local IsCompact = Data.Compact == true
                local BtnSize = IsCompact and UDim2New(0, 14, 0, 14) or UDim2New(0, 100, 0, 20)
                Items["ColorpickerButton"] = Instances:Create("TextButton", {
                    Parent = Data.Parent.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(0, 0.5),
                    Position = IsCompact and UDim2New(0, 0, 0.5, 0) or UDim2New(0, 0, 0, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = BtnSize,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                if Data.LayoutOrder then Items["ColorpickerButton"].Instance.LayoutOrder = Data.LayoutOrder end
                if Data.Parent2 and not Data.Parent2.Instance:FindFirstChild("nig") then
                    Items["PaletteIcon"] = Instances:Create("ImageLabel", {
                        Parent = Data.Parent2.Instance,
                        ImageColor3 = FromRGB(141, 141, 150),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Size = UDim2New(0, 16, 0, 16),
                        AnchorPoint = Vector2New(0.5, 1),
                        Image = "rbxassetid://92464809279921",
                        Name = "nig",
                        BackgroundTransparency = 1,
                        Position = UDim2New(1, -16, 1, -6),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })                

                    Items["PaletteIcon"]:OnHover(function()
                        Items["PaletteIcon"]:Tween(nil, {ImageColor3 = Library.Theme.Accent})
                    end)
                    
                    Items["PaletteIcon"]:OnHoverLeave(function()
                        Items["PaletteIcon"]:Tween(nil, {ImageColor3 = FromRGB(141, 141, 150)})
                    end)
                end
                
                Items["Color"] = Instances:Create("Frame", {
                    Parent = Items["ColorpickerButton"].Instance,
                    Name = "\0",
                    Size = IsCompact and UDim2New(1, 0, 1, 0) or UDim2New(0, 15, 0, 15),
                    Position = IsCompact and UDim2New(0, 0, 0, 0) or UDim2New(0, 0, 0, 2),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(124, 163, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Color"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["ColorpickerButton"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "#7842ff",
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 25, 0, 2),
                    BorderSizePixel = 0,
                    Visible = not IsCompact,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

                Items["ColorpickerWindow"] = Instances:Create("TextButton", {
                    Parent = Library.UnusedHolder.Instance,
                    AutoButtonColor = false,
                    Text = "",
                    Name = "\0",
                    Visible = false,
                    Position = UDim2New(0.01075268816202879, 0, 0.0336427167057991, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 235, 0, 270),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 25)
                })  Items["ColorpickerWindow"]:AddToTheme({BackgroundColor3 = "Background"})
                
                Instances:Create("UICorner", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Items["Palette"] = Instances:Create("TextButton", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Position = UDim2New(0, 15, 0, 10),
                    Size = UDim2New(1, -31, 1, -159),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(124, 163, 255)
                })
                
                Items["Saturation"] = Instances:Create("Frame", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 1, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["Saturation"].Instance,
                    Name = "\0",
                    Transparency = NumSequence{NumSequenceKeypoint(0, 1), NumSequenceKeypoint(1, 0)}
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Saturation"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Items["Value"] = Instances:Create("Frame", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 1, 1, 1),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(0, 0, 0)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["Value"].Instance,
                    Name = "\0",
                    Rotation = 90,
                    Transparency = NumSequence{NumSequenceKeypoint(0, 1), NumSequenceKeypoint(1, 0)}
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Value"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Items["PaletteDragger"] = Instances:Create("Frame", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 15, 0, 15),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 10, 0, 10),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["PaletteDragger"].Instance,
                    Name = "\0",
                    Color = FromRGB(255, 255, 255),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["PaletteDragger"].Instance,
                    Name = "\0"
                })
                
                Items["Hue"] = Instances:Create("TextButton", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 15, 1, -131),
                    Size = UDim2New(1, -31, 0, 6),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Hue"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })
                
                Items["HueInline"] = Instances:Create("TextButton", {
                    Parent = Items["Hue"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Size = UDim2New(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["HueInline"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["HueInline"].Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 0, 0)), RGBSequenceKeypoint(0.17, FromRGB(255, 255, 0)), RGBSequenceKeypoint(0.33, FromRGB(0, 255, 0)), RGBSequenceKeypoint(0.5, FromRGB(0, 255, 255)), RGBSequenceKeypoint(0.67, FromRGB(0, 0, 255)), RGBSequenceKeypoint(0.83, FromRGB(255, 0, 255)), RGBSequenceKeypoint(1, FromRGB(255, 0, 0))}
                })
                
                Items["HueDragger"] = Instances:Create("Frame", {
                    Parent = Items["HueInline"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0, 0.5),
                    Position = UDim2New(0, 15, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 12, 0, 12),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["HueDragger"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })
                
                Items["Alpha"] = Instances:Create("TextButton", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 15, 1, -107),
                    Size = UDim2New(1, -31, 0, 6),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(124, 163, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Alpha"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["Alpha"].Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(0, 0, 0)), RGBSequenceKeypoint(1, FromRGB(255, 255, 255))}
                })
                
                Items["AlphaDragger"] = Instances:Create("Frame", {
                    Parent = Items["Alpha"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0, 0.5),
                    Position = UDim2New(0, 15, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 12, 0, 12),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["AlphaDragger"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })
                
                Items["SavedColors"] = Instances:Create("ScrollingFrame", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    AnchorPoint = Vector2New(0, 1),
                    BorderSizePixel = 0,
                    CanvasSize = UDim2New(0, 0, 0, 0),
                    ScrollBarImageColor3 = FromRGB(124, 163, 255),
                    MidImage = "rbxassetid://86870199131153",
                    BorderColor3 = FromRGB(0, 0, 0),
                    ScrollBarThickness = 0,
                    Size = UDim2New(1, -20, 0, 69),
                    Selectable = false,
                    TopImage = "rbxassetid://86870199131153",
                    Position = UDim2New(0, 10, 1, -30),
                    BottomImage = "rbxassetid://86870199131153",
                    BackgroundTransparency = 1,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                }) 
                
                Instances:Create("UIGridLayout", {
                    Parent = Items["SavedColors"].Instance,
                    Name = "\0",
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    CellPadding = UDim2New(0, 10, 0, 10),
                    CellSize = UDim2New(0, 25, 0, 25)
                })

                Instances:Create("UIPadding", {
                    Parent = Items["SavedColors"].Instance,
                    Name = "\0",
                    PaddingLeft = UDimNew(0, 5),
                    PaddingTop = UDimNew(0, 5),
                    PaddingRight = UDimNew(0, -125),
                    PaddingBottom = UDimNew(0, 5)
                })

                Items["HEXInput"] = Instances:Create("TextBox", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ClearTextOnFocus = false,
                    Text = "#7ca3ff",
                    AnchorPoint = Vector2New(1, 1),
                    Size = UDim2New(0, 140, 0, 20),
                    TextTransparency = 0.5,
                    PlaceholderColor3 = FromRGB(185, 185, 185),
                    Position = UDim2New(1, -8, 1, -8),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(30, 29, 31)
                })  Items["HEXInput"]:AddToTheme({BackgroundColor3 = "Outline"})

                Instances:Create("UIPadding", {
                    Parent = Items["HEXInput"].Instance,
                    Name = "\0",
                    PaddingLeft = UDimNew(0, 5),
                })
                
                Items["HexLabel"] = Instances:Create("TextLabel", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "Custom:",
                    TextTransparency = 0.5,
                    AnchorPoint = Vector2New(0, 1),
                    Size = UDim2New(0, 40, 0, 20),
                    Position = UDim2New(0, 10, 1, -8),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundTransparency = 1,
                    BackgroundColor3 = FromRGB(30, 29, 31)
                })  Items["HexLabel"]:AddToTheme({TextColor3 = "Text"})
                
                Instances:Create("UICorner", {
                    Parent = Items["HEXInput"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })                
            end

            function Colorpicker:Get()
                return Colorpicker.Color, Colorpicker.Alpha
            end

            function Colorpicker:Update(IsFromAlpha)
                local Hue, Saturation, Value = Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value
                Colorpicker.Color = FromHSV(Hue, Saturation, Value)
                Colorpicker.HexValue = Colorpicker.Color:ToHex()

                Library.Flags[Colorpicker.Flag] = {
                    Alpha = Colorpicker.Alpha,
                    Color = Colorpicker.Color,
                    HexValue = Colorpicker.HexValue,
                    Transparency = 1 - Colorpicker.Alpha
                }

                Items["Color"]:Tween(nil, {BackgroundColor3 = Colorpicker.Color})
                Items["Palette"]:Tween(nil, {BackgroundColor3 = FromHSV(Hue, 1, 1)})
                Items["Text"].Instance.Text = ("#"..Colorpicker.HexValue):upper()
                Items["HEXInput"].Instance.Text = "#"..Colorpicker.HexValue

                if not IsFromAlpha then 
                    Items["Alpha"]:Tween(nil, {BackgroundColor3 = Colorpicker.Color})
                end

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Colorpicker.Color, Colorpicker.Alpha)
                end
            end

            local SlidingPalette = false
            local PaletteChanged
            
            function Colorpicker:SlidePalette(Input)
                if not Input or not SlidingPalette then
                    return
                end

                local ValueX = MathClamp(1 - (Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 1)
                local ValueY = MathClamp(1 - (Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 1)

                Colorpicker.Saturation = ValueX
                Colorpicker.Value = ValueY

                local SlideX = MathClamp((Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 0.955)
                local SlideY = MathClamp((Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 0.955)

                Items["PaletteDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(SlideX, 0, SlideY, 0)})
                Colorpicker:Update()
            end
            
            local SlidingHue = false
            local HueChanged

            function Colorpicker:SlideHue(Input)
                if not Input or not SlidingHue then
                    return
                end
                
                local ValueX = MathClamp((Input.Position.X - Items["Hue"].Instance.AbsolutePosition.X) / Items["Hue"].Instance.AbsoluteSize.X, 0, 1)

                Colorpicker.Hue = ValueX

                local SlideX = MathClamp((Input.Position.X - Items["Hue"].Instance.AbsolutePosition.X) / Items["Hue"].Instance.AbsoluteSize.X, 0, 0.955)

                Items["HueDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(SlideX, 0, 0.5, 0)})
                Colorpicker:Update()
            end

            local SlidingAlpha = false 
            local AlphaChanged

            function Colorpicker:SlideAlpha(Input)
                if not Input or not SlidingAlpha then
                    return
                end

                local ValueX = MathClamp((Input.Position.X - Items["Alpha"].Instance.AbsolutePosition.X) / Items["Alpha"].Instance.AbsoluteSize.X, 0, 1)

                Colorpicker.Alpha = ValueX

                local SlideX = MathClamp((Input.Position.X - Items["Alpha"].Instance.AbsolutePosition.X) / Items["Alpha"].Instance.AbsoluteSize.X, 0, 0.955)

                Items["AlphaDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(SlideX, 0, 0.5, 0)})
                Colorpicker:Update(true)
            end

            local Debounce = false
            local RenderStepped  

            function Colorpicker:SetOpen(Bool)
                if Debounce then 
                    return
                end

                Colorpicker.IsOpen = Bool

                Debounce = true 

                if Colorpicker.IsOpen then 
                    Items["ColorpickerWindow"].Instance.Visible = true
                    Items["ColorpickerWindow"].Instance.Parent = Library.Holder.Instance
                    
                    RenderStepped = RunService.RenderStepped:Connect(function()
                        Items["ColorpickerWindow"].Instance.Position = UDim2New(
                            0, 
                            Items["ColorpickerButton"].Instance.AbsolutePosition.X, 
                            0, 
                            Items["ColorpickerButton"].Instance.AbsolutePosition.Y + Items["ColorpickerButton"].Instance.AbsoluteSize.Y + 5
                        )
                    end)

                    if Data.Section.IsSettings ~= true then
                        for Index, Value in Library.OpenFrames do 
                            if Value ~= Colorpicker then
                                Value:SetOpen(false)
                            end
                        end
                    end

                    Library.OpenFrames[Colorpicker] = Colorpicker 
                else
                    if not Data.Section.IsSettings then
                        if Library.OpenFrames[Colorpicker] then 
                            Library.OpenFrames[Colorpicker] = nil
                        end
                    end

                    if RenderStepped then 
                        RenderStepped:Disconnect()
                        RenderStepped = nil
                    end
                end

                local Descendants = Items["ColorpickerWindow"].Instance:GetDescendants()
                TableInsert(Descendants, Items["ColorpickerWindow"].Instance)

                local NewTween

                for Index, Value in Descendants do 
                    local TransparencyProperty = Tween:GetProperty(Value)

                    if not TransparencyProperty then
                        continue 
                    end

                    if not Value.ClassName:find("UI") then 
                        Value.ZIndex = (Colorpicker.IsOpen and Data.Section.IsSettings and 9) or (Colorpicker.IsOpen and not Data.Section.IsSettings and 3) or 1
                    end

                    if type(TransparencyProperty) == "table" then 
                        for _, Property in TransparencyProperty do 
                            NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
                        end
                    else
                        NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
                    end
                end
                
                NewTween.Tween.Completed:Connect(function()
                    Debounce = false 
                    Items["ColorpickerWindow"].Instance.Visible = Colorpicker.IsOpen
                    task.wait(0.2)
                    Items["ColorpickerWindow"].Instance.Parent = not Colorpicker.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
                end)
            end

            function Colorpicker:Set(Color, Alpha)
                if type(Color) == "table" then
                    Color = FromRGB(Color[1], Color[2], Color[3])
                    Alpha = Color[4]
                elseif type(Color) == "string" then
                    Color = FromHex(Color)
                end 

                Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value = Color:ToHSV()
                Colorpicker.Alpha = Alpha or 0  

                local PaletteValueX = MathClamp(1 - Colorpicker.Saturation, 0, 0.955)
                local PaletteValueY = MathClamp(1 - Colorpicker.Value, 0, 0.955)

                local AlphaPositionX = MathClamp(Colorpicker.Alpha, 0, 0.955)
                    
                local HuePositionX = MathClamp(Colorpicker.Hue, 0, 0.955)

                Items["PaletteDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(PaletteValueX, 0, PaletteValueY, 0)})
                Items["HueDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(HuePositionX, 0, 0.5, 0)})
                Items["AlphaDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(AlphaPositionX, 0, 0.5, 0)})
                Colorpicker:Update()
            end

            Items["ColorpickerButton"]:Connect("MouseButton1Down", function()
                Colorpicker:SetOpen(not Colorpicker.IsOpen)
            end)

            Items["Palette"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    SlidingPalette = true 

                    Colorpicker:SlidePalette(Input)

                    if PaletteChanged then
                        return
                    end

                    PaletteChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            SlidingPalette = false

                            PaletteChanged:Disconnect()
                            PaletteChanged = nil
                        end
                    end)
                end
            end)

            Items["HueInline"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    SlidingHue = true 

                    Colorpicker:SlideHue(Input)

                    if HueChanged then
                        return
                    end

                    HueChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            SlidingHue = false

                            HueChanged:Disconnect()
                            HueChanged = nil
                        end
                    end)
                end
            end)

            Items["Alpha"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    SlidingAlpha = true 

                    Colorpicker:SlideAlpha(Input)

                    if AlphaChanged then
                        return
                    end

                    AlphaChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            SlidingAlpha = false

                            AlphaChanged:Disconnect()
                            AlphaChanged = nil
                        end
                    end)
                end
            end)

            function AddColor(Color)

                    local SaveIndex = #Colorpicker.SavedColors + 1

                    local SavedColor = Instances:Create("TextButton", {
                        Parent = Items["SavedColors"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(0, 0, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        Size = UDim2New(0, 200, 0, 50),
                        BorderSizePixel = 0,
                        TextSize = 14,
                        BackgroundTransparency = 1,
                        ZIndex = 4,
                        BackgroundColor3 = Color
                    })
                    
                    Instances:Create("UICorner", {
                        Parent = SavedColor.Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 6),
                    })                

                    local UIStroke = Instances:Create("UIStroke", {
                        Parent = SavedColor.Instance,
                        Name = "\0",
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        Color = FromRGB(255, 255, 255),
                        Thickness = 1.5,
                        Transparency = 1
                    })

                    SavedColor:OnHover(function()
                        UIStroke:Tween(nil, {Transparency = 0})
                    end)

                    SavedColor:OnHoverLeave(function()
                        UIStroke:Tween(nil, {Transparency = 1})
                    end)
    
                    Colorpicker.SavedColors[SaveIndex] = {
                        Color = Color,
                        Alpha = Colorpicker.Alpha,
                    }
    
                    SavedColor:Connect("MouseButton1Down", function()
                        local NewColorData = Colorpicker.SavedColors[SaveIndex]
                        Colorpicker:Set(NewColorData.Color, NewColorData.Alpha)
                    end)

                    SavedColor:Tween(nil, {BackgroundTransparency = 0})

            end

            local Colors = {
                ["Orange"] = FromRGB(245, 114, 66),
                ["Pink"] = FromRGB(245, 66, 191),
                ["Purple"] = FromRGB(124, 54, 245),
                ["Pink 2"] = FromRGB(202, 110, 255),
                ["Pink 3"] = FromRGB(250, 142, 239),
                ["Yellow"] = FromRGB(214, 206, 92),
                ["Orange 2"] = FromRGB(255, 93, 48),
                ["Orange 3"] = FromRGB(255, 169, 56),   
                ["Green"] = FromRGB(0, 171, 0),
                ["Blue"] = FromRGB(0, 116, 224),
                ["Maroon"] = FromRGB(120, 0, 76),
                ["Whiteish Pink"] = FromRGB(255, 194, 245),         
                ["White"] = FromRGB(255, 255, 255),
                ["Red"] = FromRGB(255, 0, 0),
                ["Sky Blue"] = FromRGB(171, 209, 255),
            }

            AddColor(Colors["Orange"])
            AddColor(Colors["Pink"])
            AddColor(Colors["Purple"])
            AddColor(Colors["Pink 2"])
            AddColor(Colors["Pink 3"])
            AddColor(Colors["Yellow"])
            AddColor(Colors["Orange 2"])
            AddColor(Colors["Orange 3"])
            AddColor(Colors["Green"])
            AddColor(Colors["Blue"])
            AddColor(Colors["Maroon"])
            AddColor(Colors["Whiteish Pink"])
            AddColor(Colors["White"])
            AddColor(Colors["Red"])
            AddColor(Colors["Sky Blue"])

            Items["HEXInput"]:Connect("FocusLost", function()
                Colorpicker:Set(tostring(Items["HEXInput"].Instance.Text), Colorpicker.Alpha)
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if SlidingPalette then 
                        Colorpicker:SlidePalette(Input)
                    end

                    if SlidingHue then
                        Colorpicker:SlideHue(Input)
                    end

                    if SlidingAlpha then
                        Colorpicker:SlideAlpha(Input)
                    end
                end
            end)

            Library:Connect(UserInputService.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    if not Colorpicker.IsOpen then
                        return
                    end

                    if Library:IsMouseOverFrame(Items["ColorpickerWindow"]) or (Items["PaletteIcon"] and Library:IsMouseOverFrame(Items["PaletteIcon"]) and not Data.Section.IsSettings) then
                        return
                    end

                    Colorpicker:SetOpen(false)
                end
            end)

            if Data.Default then
                Colorpicker:Set(Data.Default, Data.Alpha)
            end

            Library.SetFlags[Colorpicker.Flag] = function(Value, Alpha)
                Colorpicker:Set(Value, Alpha)
            end

            return Colorpicker, Items 
        end

        Library.CreateKeybind = function(self, Data)
            local Keybind = {
                Flag = Data.Flag or Library:NextFlag(),
                Default = Data.Default or Enum.KeyCode.E,
                Callback = Data.Callback or function() end,
                Mode = Data.Mode or "Toggle",
                Value = "",
                ModeSelected = "Toggle",
                Toggled = false,
                Picking = false
            }
            local Items = { }
            Items["KeyButton"] = Instances:Create("TextButton", {
                Parent = Data.Parent.Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(240, 240, 240),
                TextTransparency = 0.30000001192092896,
                Text = "None",
                AutoButtonColor = false,
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0, 80, 0, 20),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["KeyButton"]:AddToTheme({TextColor3 = "Text"})
            Items["Modes"] = Instances:Create("Frame", {
                Parent = Data.Parent.Instance,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0, 200, 0, 25),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(27, 26, 29)
            })  Items["Modes"]:AddToTheme({BackgroundColor3 = "Element"})
            Instances:Create("UICorner", { Parent = Items["Modes"].Instance, Name = "\0", CornerRadius = UDimNew(0, 5) })
            Items["Background"] = Instances:Create("Frame", {
                Parent = Items["Modes"].Instance,
                Name = "\0",
                Size = UDim2New(0.35, 0, 1, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundTransparency = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })
            Instances:Create("UICorner", { Parent = Items["Background"].Instance, Name = "\0", CornerRadius = UDimNew(0, 5) })
            Instances:Create("UIGradient", {
                Parent = Items["Background"].Instance,
                Name = "\0",
                Rotation = -115,
                Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(166, 166, 166))}
            }):AddToTheme({Color = function()
                return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
            end})
            Items["Toggle"] = Instances:Create("TextButton", {
                Parent = Items["Modes"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(0, 0, 0),
                TextTransparency = 0.30000001192092896,
                Text = "Toggle",
                AutoButtonColor = false,
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0.35, 0, 1, 0),
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0, -1),
                BorderSizePixel = 0,
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Toggle"]:AddToTheme({TextColor3 = function() return Library.Theme.Text end})
            Items["Hold"] = Instances:Create("TextButton", {
                Parent = Items["Modes"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(240, 240, 240),
                TextTransparency = 0.20000000298023224,
                Text = "Hold",
                BorderColor3 = FromRGB(0, 0, 0),
                AutoButtonColor = false,
                AnchorPoint = Vector2New(0, 0),
                Size = UDim2New(0.35, 0, 1, 0),
                BackgroundTransparency = 1,
                Position = UDim2New(0.35, 0, 0, -1),
                BorderSizePixel = 0,
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Hold"]:AddToTheme({TextColor3 = function() return Library.Theme.Text end})
            Items["Always"] = Instances:Create("TextButton", {
                Parent = Items["Modes"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                TextColor3 = FromRGB(240, 240, 240),
                TextTransparency = 0.20000000298023224,
                Text = "Always",
                BorderColor3 = FromRGB(0, 0, 0),
                AutoButtonColor = false,
                AnchorPoint = Vector2New(0, 0),
                Size = UDim2New(0.4, 0, 1, 0),
                BackgroundTransparency = 1,
                Position = UDim2New(0.7, -12, 0, -1),
                BorderSizePixel = 0,
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Always"]:AddToTheme({TextColor3 = function() return Library.Theme.Text end})
            local KeyListItem
            if Library.KeyList then KeyListItem = Library.KeyList:Add("", "") end
            local Update = function()
                if KeyListItem then KeyListItem:Set("", Keybind.Value) KeyListItem:SetStatus(Keybind.Toggled) end
            end
            function Keybind:SetMode(Mode)
                if Mode == "Toggle" then
                    Items["Background"]:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0, 0), Size = UDim2New(0.35, 0, 1, 0)})
                    Items["Toggle"]:ChangeItemTheme({TextColor3 = function() return FromRGB(0, 0, 0) end})
                    Items["Toggle"]:Tween(nil, {TextColor3 = FromRGB(0, 0, 0)})
                    Items["Hold"]:ChangeItemTheme({TextColor3 = function() return Library.Theme.Text end})
                    Items["Hold"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                    Items["Always"]:ChangeItemTheme({TextColor3 = function() return Library.Theme.Text end})
                    Items["Always"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                elseif Mode == "Hold" then
                    Items["Background"]:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(0.35, 0, 0, 0), Size = UDim2New(0.35, 0, 1, 0)})
                    Items["Toggle"]:ChangeItemTheme({TextColor3 = function() return Library.Theme.Text end})
                    Items["Toggle"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                    Items["Hold"]:ChangeItemTheme({TextColor3 = function() return FromRGB(0, 0, 0) end})
                    Items["Hold"]:Tween(nil, {TextColor3 = FromRGB(0, 0, 0)})
                    Items["Always"]:ChangeItemTheme({TextColor3 = function() return Library.Theme.Text end})
                    Items["Always"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                elseif Mode == "Always" then
                    Items["Background"]:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(0.7, 0, 0, 0), Size = UDim2New(0.3, 0, 1, 0)})
                    Items["Toggle"]:ChangeItemTheme({TextColor3 = function() return Library.Theme.Text end})
                    Items["Toggle"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                    Items["Hold"]:ChangeItemTheme({TextColor3 = function() return Library.Theme.Text end})
                    Items["Hold"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                    Items["Always"]:ChangeItemTheme({TextColor3 = function() return FromRGB(0, 0, 0) end})
                    Items["Always"]:Tween(nil, {TextColor3 = FromRGB(0, 0, 0)})
                end
                Keybind.ModeSelected = Mode
                Library.Flags[Keybind.Flag] = { Mode = Keybind.ModeSelected, Key = Keybind.Key, Toggled = Keybind.Toggled }
                if Data.Callback then Library:SafeCall(Data.Callback, Keybind.Toggled) end
            end
            function Keybind:Press(Bool)
                if Keybind.ModeSelected == "Toggle" then Keybind.Toggled = not Keybind.Toggled
                elseif Keybind.ModeSelected == "Hold" then Keybind.Toggled = Bool
                elseif Keybind.ModeSelected == "Always" then Keybind.Toggled = true end
                Library.Flags[Keybind.Flag] = { Mode = Keybind.ModeSelected, Key = Keybind.Key, Toggled = Keybind.Toggled }
                if Data.Callback then Library:SafeCall(Data.Callback, Keybind.Toggled) end
                Update()
            end
            function Keybind:Set(Key)
                if StringFind(tostring(Key), "Enum") then
                    Keybind.Key = tostring(Key)
                    local KeyName
                    if type(Key) == "string" then
                        KeyName = Key:match("[^%.]+$") or "None"
                        if KeyName == "Backspace" then KeyName = "None" end
                    else
                        KeyName = Key.Name == "Backspace" and "None" or Key.Name
                    end
                    local KeyStr = Keys[Keybind.Key] or StringGSub(StringGSub(KeyName or "", "KeyCode%.", ""), "UserInputType%.", "") or KeyName or "None"
                    Keybind.Value = KeyStr
                    Items["KeyButton"].Instance.Text = KeyStr
                    Library.Flags[Keybind.Flag] = { Mode = Keybind.ModeSelected, Key = Keybind.Key, Toggled = Keybind.Toggled }
                    if Data.Callback then Library:SafeCall(Data.Callback, Keybind.Toggled) end
                    Update()
                elseif type(Key) == "table" and Key.Key ~= nil then
                    Keybind.Key = tostring(Key.Key)
                    local KeyName
                    if type(Key.Key) == "string" then
                        KeyName = Key.Key:match("[^%.]+$") or "None"
                        if KeyName == "Backspace" then KeyName = "None" end
                    else
                        KeyName = Key.Key.Name == "Backspace" and "None" or Key.Key.Name
                    end
                    local KeyStr = Keys[Keybind.Key] or StringGSub(StringGSub(KeyName or "", "KeyCode%.", ""), "UserInputType%.", "") or KeyName or "None"
                    Keybind.Value = KeyStr
                    Items["KeyButton"].Instance.Text = KeyStr
                    if Key.Mode or Key.ModeSelected then Keybind:SetMode(Key.Mode or Key.ModeSelected) end
                    Library.Flags[Keybind.Flag] = { Mode = Keybind.ModeSelected, Key = Keybind.Key, Toggled = Keybind.Toggled }
                    if Data.Callback then Library:SafeCall(Data.Callback, Keybind.Toggled) end
                    Update()
                elseif TableFind({"Toggle", "Hold", "Always"}, Key) then
                    Keybind:SetMode(Key)
                end
                Keybind.Picking = false
            end
            Items["KeyButton"]:Connect("MouseButton1Click", function()
                Keybind.Picking = true
                Items["KeyButton"].Instance.Text = "."
                local InputBegan
                InputBegan = UserInputService.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.Keyboard then Keybind:Set(Input.KeyCode)
                    else Keybind:Set(Input.UserInputType) end
                    if InputBegan then InputBegan:Disconnect() InputBegan = nil end
                end)
            end)
            Items["Toggle"]:Connect("MouseButton1Down", function() Keybind:SetMode("Toggle") end)
            Items["Hold"]:Connect("MouseButton1Down", function() Keybind:SetMode("Hold") end)
            Items["Always"]:Connect("MouseButton1Down", function() Keybind:SetMode("Always") end)
            Library:Connect(UserInputService.InputBegan, function(Input)
                if Keybind.Value == "None" or Keybind.Picking then return end
                if tostring(Input.KeyCode) == Keybind.Key or tostring(Input.UserInputType) == Keybind.Key then
                    if Keybind.ModeSelected == "Toggle" then Keybind:Press()
                    elseif Keybind.ModeSelected == "Hold" then Keybind:Press(true)
                    elseif Keybind.ModeSelected == "Always" then Keybind:Press(true) end
                end
            end)
            Library:Connect(UserInputService.InputEnded, function(Input)
                if Keybind.Value == "None" then return end
                if tostring(Input.KeyCode) == Keybind.Key or tostring(Input.UserInputType) == Keybind.Key then
                    if Keybind.ModeSelected == "Hold" then Keybind:Press(false)
                    elseif Keybind.ModeSelected == "Always" then Keybind:Press(true) end
                end
            end)
            if Keybind.Default then Keybind:Set({ Mode = Data.Mode or "Toggle", Key = Keybind.Default }) end
            Library.SetFlags[Keybind.Flag] = function(Value) Keybind:Set(Value) end
            return Keybind, Items
        end

        Library.KeybindList = function(self, Title)
            local KeybindList = { }
            Library.KeyList = KeybindList

            local Items = { } do 
                Items["KeybindsList"] = Instances:Create("Frame", {
                    Parent = Library.Holder.Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 0.5),
                    BackgroundTransparency = 0.30000001192092896,
                    Position = UDim2New(0, 20, 0.5, 20),
                    Size = UDim2New(0, 100, 0, 30),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundColor3 = FromRGB(27, 25, 29),
                    Visible = false,
                })  Items["KeybindsList"]:AddToTheme({BackgroundColor3 = "Section Background"})

                Items["KeybindsList"]:MakeDraggable()
                
                Instances:Create("UICorner", {
                    Parent = Items["KeybindsList"].Instance,
                    Name = "\0"
                })
                
                Items["Top"] = Instances:Create("Frame", {
                    Parent = Items["KeybindsList"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 12, 0, 40),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(31, 31, 36)
                })  Items["Top"]:AddToTheme({BackgroundColor3 = "Section Background 2"})
                
                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Top"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 21, 0, 20),
                    AnchorPoint = Vector2New(0, 0.5),
                    Image = "rbxassetid://81598136527047",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 15, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["Icon"].Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(131, 131, 131)), RGBSequenceKeypoint(1, FromRGB(255, 255, 255))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})
                
                Items["Title"] = Instances:Create("TextLabel", {
                    Parent = Items["Top"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(248, 248, 248),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Title,
                    AutomaticSize = Enum.AutomaticSize.X,
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 45, 0.5, -1),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 15,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Title"]:AddToTheme({TextColor3 = "Text"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Top"].Instance,
                    Name = "\0"
                })
                
                Instances:Create("Frame", {
                    Parent = Items["Top"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 0, 1, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 10, 0, 5),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(31, 31, 36)
                }):AddToTheme({BackgroundColor3 = "Section Background 2"})
                
                Instances:Create("Frame", {
                    Parent = Items["Top"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(1, 1),
                    Position = UDim2New(1, 0, 1, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 10, 0, 5),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(31, 31, 36)
                }):AddToTheme({BackgroundColor3 = "Section Background 2"})
                
                Items["Content"] = Instances:Create("Frame", {
                    Parent = Items["KeybindsList"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0, 40),
                    Size = UDim2New(1, 12, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UIListLayout", {
                    Parent = Items["Content"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 4),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                Instances:Create("UIPadding", {
                    Parent = Items["Content"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 8),
                    PaddingBottom = UDimNew(0, 8),
                    PaddingRight = UDimNew(0, 8),
                    PaddingLeft = UDimNew(0, 8)
                })
                
                Instances:Create("UIPadding", {
                    Parent = Items["KeybindsList"].Instance,
                    Name = "\0",
                    PaddingRight = UDimNew(0, 12)
                })                
            end

            function KeybindList:SetVisibility(Bool)
                Items["KeybindsList"].Instance.Visible = Bool
            end

            function KeybindList:Add(Name, Key)
                local NewKey = Instances:Create("TextButton", {
                    Parent = Items["Content"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                local NewKeyAccent = Instances:Create("Frame", {
                    Parent = NewKey.Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 0.5),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0.5, 0),
                    Size = UDim2New(0, 6, 0, 6),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UIGradient",{
                    Parent = NewKeyAccent.Instance,
                    Name = "\0",
                    Rotation = -115,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})
                
                Instances:Create("UICorner", {
                    Parent = NewKeyAccent.Instance,
                    Name = "\0"
                })
                
                local NewKeyText = Instances:Create("TextLabel", {
                    Parent = NewKey.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.30000001192092896,
                    Text = Name .. " ["..Key.."]",
                    Size = UDim2New(0, 0, 0, 15),
                    AnchorPoint = Vector2New(0, 0.5),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  NewKeyText:AddToTheme({TextColor3 = "Text"})

                function NewKey:Set(Name, Key)
                    NewKeyText.Instance.Text = Name .. " ["..Key.."]"
                end

                function NewKey:SetStatus(Bool)
                    if Bool then 
                        NewKeyText:Tween(nil, {Position = UDim2New(0, 15, 0.5, 0), TextTransparency = 0})
                        NewKeyAccent:Tween(nil, {BackgroundTransparency = 0})
                    else
                        NewKeyText:Tween(nil, {Position = UDim2New(0, 0, 0.5, 0), TextTransparency = 0.3})
                        NewKeyAccent:Tween(nil, {BackgroundTransparency = 1})
                    end
                end

                return NewKey
            end

            return KeybindList
        end

        Library.Notification = function(self, Data)
            local Items = { } do 
                Items["Notification"] = Instances:Create("Frame", {
                    Parent = Library.NotifHolder.Instance,
                    Name = "\0",
                    BackgroundTransparency = 0.3499999940395355,
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundColor3 = FromRGB(27, 25, 29)
                })
                
                Items["Title"] = Instances:Create("TextLabel", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Data.Title,
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Title"]:AddToTheme({TextColor3 = "Text"})
                
                Instances:Create("UIPadding", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 8),
                    PaddingBottom = UDimNew(0, 8),
                    PaddingRight = UDimNew(0, 8),
                    PaddingLeft = UDimNew(0, 8)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })
                
                Items["Description"] = Instances:Create("TextLabel", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.30000001192092896,
                    Text = Data.Description,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0, 20),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Description"]:AddToTheme({TextColor3 = "Text"})
                
                Items["Accent"] = Instances:Create("Frame", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    Position = UDim2New(0, 0, 0, Items["Description"].Instance.AbsoluteSize.Y + Items["Title"].Instance.AbsoluteSize.Y + 12),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 0, 0, 6),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})
                
                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    Image = "rbxassetid://" .. (Data.Icon or "87107896404147"),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, 0, 0, 0),
                    Size = UDim2New(0, 16, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                if not Data.IconColor then
                    Instances:Create("UIGradient", {
                        Parent = Items["Icon"].Instance,
                        Name = "\0",
                        Rotation = -115,
                        Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))}
                    }):AddToTheme({Color = function()
                        return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                    end})             
                else
                    Instances:Create("UIGradient", {
                        Parent = Items["Icon"].Instance,
                        Name = "\0",
                        Rotation = -115,
                        Color = RGBSequence{RGBSequenceKeypoint(0, Data.IconColor.Start), RGBSequenceKeypoint(1, Data.IconColor.End)}
                    })         
                end   
            end

            local Size = Items["Notification"].Instance.AbsoluteSize
            Items["Notification"].Instance.Size = UDim2New(0, 0, 0, 0)

            for Index, Value in Items do 
                if Value.Instance:IsA("Frame") then
                    Value.Instance.BackgroundTransparency = 1
                elseif Value.Instance:IsA("TextLabel") then 
                    Value.Instance.TextTransparency = 1
                elseif Value.Instance:IsA("ImageLabel") then 
                    Value.Instance.ImageTransparency = 1
                end
            end 
            
            task.wait(0.2)

            Items["Notification"].Instance.AutomaticSize = Enum.AutomaticSize.Y

            Library:Thread(function()
                for Index, Value in Items do
                    if Value and Value.Instance and Value.Instance.Parent then
                        if Value.Instance:IsA("Frame") then
                            Value:Tween(TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0), {BackgroundTransparency = 0})
                        elseif Value.Instance:IsA("TextLabel") then
                            Value:Tween(TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0), {TextTransparency = 0})
                        elseif Value.Instance:IsA("ImageLabel") then
                            Value:Tween(TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0), {ImageTransparency = 0})
                        end
                    end
                end
                if Items["Notification"] and Items["Notification"].Instance and Items["Notification"].Instance.Parent then
                    Items["Notification"]:Tween(TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0), {Size = UDim2New(0, Size.X, 0, Size.Y)})
                    Items["Accent"]:Tween(TweenInfo.new(Data.Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Size = UDim2New(1, 0, 0, 6)})
                end

                task.delay(Data.Duration + 0.15, function()
                    for Index, Value in Items do
                        if Value and Value.Instance and Value.Instance.Parent then
                            if Value.Instance:IsA("Frame") then
                                Value:Tween(nil, {BackgroundTransparency = 1})
                            elseif Value.Instance:IsA("TextLabel") then
                                Value:Tween(nil, {TextTransparency = 1})
                            elseif Value.Instance:IsA("ImageLabel") then
                                Value:Tween(nil, {ImageTransparency = 1})
                            end
                        end
                    end
                    if Items["Notification"] and Items["Notification"].Instance and Items["Notification"].Instance.Parent then
                        Items["Notification"]:Tween(TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0), {Size = UDim2New(0, 0, 0, 0)})
                        task.wait(0.5)
                        Items["Notification"]:Clean()
                    end
                end)
            end)
        end

        Library.Window = function(self, Data)
            Data = Data or { }

            local Window = {
                Name = Data.Name or Data.name or "Spooki hub",
                SubName = Data.SubName or Data.subname or "Fine-tuning for sure wins",
                Logo = Data.Logo or Data.logo or "87107896404147",
                
                Pages = { },
                Items = { },
                IsOpen = false,
                CurrentAlignment = "LeftTabs"
            }

            local Items = { } do
                Items["MainFrame"] = Instances:Create("Frame", {
                    Parent = Library.Holder.Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    BackgroundTransparency = 0.35,
                    Position = UDim2New(0.5519999861717224, 0, 0.5, 0),
                    Size = UDim2New(0, 677, 0, 644),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 25, 29)
                })  Items["MainFrame"]:AddToTheme({BackgroundColor3 = "Background"})

                if IsMobile then 
                    local UIScale = Instances:Create("UIScale", {
                        Parent = Items["MainFrame"].Instance,
                        Name = "\0",
                        Scale = 0.56
                    })

                    Library.Flags["UIScale"] = 0.56
                end

                Items["MainFrame"]:MakeResizeable(Vector2New(Items["MainFrame"].Instance.AbsoluteSize.X, Items["MainFrame"].Instance.AbsoluteSize.Y), Vector2New(9999, 9999), OriginalSizes)
                Library:MakeBlurred(Items["MainFrame"], Window)
                
                Items["LeftTabs"] = Instances:Create("ScrollingFrame", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    Visible = true,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    BackgroundTransparency = 0.15,
                    Size = UDim2New(0, 225, 1, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 25, 29),
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    CanvasSize = UDim2New(0, 0, 0, 0),
                    ScrollBarThickness = 2,
                    ScrollingDirection = Enum.ScrollingDirection.Y,
                    VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
                })  Items["LeftTabs"]:AddToTheme({BackgroundColor3 = "Background"})

                Items["LeftTabs"]:AddToTheme({ScrollBarImageColor3 = "Accent"})
                Library:MakeBlurred(Items["LeftTabs"], Window)

                local Gui = Items["MainFrame"].Instance

                local Dragging = false 
                local DragStart
                local StartPosition 
                local WindowDraggingBlocked = false

                local function GetWindowScale()
                    local scaleObj = Gui:FindFirstChildOfClass("UIScale")
                    if scaleObj then return scaleObj.Scale end
                    local holder = Library.Holder and Library.Holder.Instance
                    if holder then
                        local s = holder:FindFirstChildOfClass("UIScale")
                        if s then return s.Scale end
                    end
                    return 1
                end

                local function BeginWindowDrag(Input)
                    if WindowDraggingBlocked then return end
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        Dragging = true
                        DragStart = Input.Position
                        StartPosition = Gui.Position
                        Input.Changed:Connect(function()
                            if Input.UserInputState == Enum.UserInputState.End then
                                Dragging = false
                            end
                        end)
                    end
                end

                Items["MainFrame"]:Connect("InputBegan", BeginWindowDrag)
                Items["LeftTabs"]:Connect("InputBegan", BeginWindowDrag)
    
                Library:Connect(UserInputService.InputChanged, function(Input)
                    if WindowDraggingBlocked then
                        Dragging = false
                        return
                    end
                    if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) and Dragging then
                        -- 1:1 with finger (no scale amplification)
                        local DragDelta = Input.Position - DragStart
                        Gui.Position = UDim2New(
                            StartPosition.X.Scale,
                            StartPosition.X.Offset + DragDelta.X,
                            StartPosition.Y.Scale,
                            StartPosition.Y.Offset + DragDelta.Y
                        )
                        -- Keep settings panel locked to main window if parented under it
                    end
                end)

                local FBDragMoved = false
                local FBDragStart = Vector3.new()
                local FBClickTimer = 0
                do

                    Items["FloatingGlow"] = Instances:Create("Frame", {
                        Parent = Library.Holder.Instance,
                        Name = "\0",
                        AnchorPoint = Vector2New(0.5, 0),
                        Position = UDim2New(0.5, 0, 0, 14),
                        Size = IsMobile and UDim2New(0, 56, 0, 56) or UDim2New(0, 70, 0, 70),
                        BackgroundTransparency = 0,
                        BackgroundColor3 = Library.Theme.Accent,
                        BorderSizePixel = 0,
                        ZIndex = 125,
                    })
                    Instances:Create("UICorner", { Parent = Items["FloatingGlow"].Instance, CornerRadius = UDimNew(0, 14) })
                    Instances:Create("UIGradient", {
                        Parent = Items["FloatingGlow"].Instance,
                        Name = "\0",
                        Rotation = -115,
                        Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))}
                    }):AddToTheme({Color = function()
                        return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                    end})

                    Items["FloatingRing"] = Instances:Create("Frame", {
                        Parent = Items["FloatingGlow"].Instance,
                        Name = "\0",
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Position = UDim2New(0.5, 0, 0.5, 0),
                        Size = UDim2New(1, -3, 1, -3),
                        BackgroundColor3 = FromRGB(8, 8, 8),
                        BackgroundTransparency = 0,
                        BorderSizePixel = 0,
                        ZIndex = 126,
                    })
                    Instances:Create("UICorner", { Parent = Items["FloatingRing"].Instance, CornerRadius = UDimNew(0, 12) })

                    Items["FloatingButton"] = Instances:Create("TextButton", {
                        Parent = Items["FloatingRing"].Instance,
                        Text = "",
                        AutoButtonColor = false,
                        Name = "\0",
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Position = UDim2New(0.5, 0, 0.5, 0),
                        Size = UDim2New(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        ZIndex = 127,
                        BackgroundColor3 = FromRGB(8, 8, 8)
                    })
                    Instances:Create("UICorner", { Parent = Items["FloatingButton"].Instance, CornerRadius = UDimNew(0, 12) })

                    Items["FloatingLogo"] = Instances:Create("ImageLabel", {
                        Parent = Items["FloatingButton"].Instance,
                        BorderColor3 = FromRGB(0, 0, 0),
                        Name = "\0",
                        Image = "rbxthumb://type=Asset&id=105520281922171&w=420&h=420",
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Position = UDim2New(0.5, 0, 0.5, 0),
                        ZIndex = 128,
                        Size = UDim2New(1, 0, 1, 0),
                        ScaleType = Enum.ScaleType.Crop,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })
                    Instances:Create("UICorner", { Parent = Items["FloatingLogo"].Instance, CornerRadius = UDimNew(0, 12) })

                    local FBRoot = Items["FloatingGlow"].Instance
                    local FBDragging = false
                    local FBStartPos

                    local function GetFBScale()
                        local holder = Library.Holder and Library.Holder.Instance
                        if holder then
                            local s = holder:FindFirstChildOfClass("UIScale")
                            if s then return s.Scale end
                        end
                        return 1
                    end

                    Items["FloatingButton"]:Connect("InputBegan", function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                            FBDragging = true
                            FBDragMoved = false
                            FBDragStart = Input.Position
                            FBStartPos = FBRoot.Position
                            FBClickTimer = tick()
                            Input.Changed:Connect(function()
                                if Input.UserInputState == Enum.UserInputState.End then
                                    FBDragging = false
                                end
                            end)
                        end
                    end)

                    Library:Connect(UserInputService.InputChanged, function(Input)
                        if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) and FBDragging then
                            local delta = Input.Position - FBDragStart
                            -- drag only after clear movement
                            if delta.Magnitude > 12 then
                                FBDragMoved = true
                                FBRoot.Position = UDim2New(
                                    FBStartPos.X.Scale,
                                    FBStartPos.X.Offset + delta.X,
                                    FBStartPos.Y.Scale,
                                    FBStartPos.Y.Offset + delta.Y
                                )
                            end
                        end
                    end)

                    task.spawn(function()
                        while Items["FloatingGlow"] and Items["FloatingGlow"].Instance and Items["FloatingGlow"].Instance.Parent do
                            Items["FloatingGlow"]:Tween(TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.55})
                            task.wait(1.2)
                            Items["FloatingGlow"]:Tween(TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundTransparency = 0})
                            task.wait(1.2)
                        end
                    end)
                end

                Items["PagePlaceholder"] = Instances:Create("Frame", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    Visible = true,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 0),
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["LeftTabs"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 12),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                Instances:Create("UIPadding", {
                    Parent = Items["LeftTabs"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 15),
                    PaddingBottom = UDimNew(0, 15),
                    PaddingRight = UDimNew(0, 12),
                    PaddingLeft = UDimNew(0, 12)
                })

                Items["Logo"] = Instances:Create("ImageLabel", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(255, 255, 255),
                    ScaleType = Enum.ScaleType.Fit,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 35, 0, 35),
                    Image = "rbxassetid://"..Window.Logo,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 12, 0, 12),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                }) 

                Instances:Create("UIGradient", {
                    Parent = Items["Logo"].Instance,
                    Name = "\0",
                    Enabled = true,
                    Rotation = -115,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})
                
                Items["Title"] = Instances:Create("TextLabel", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Window.Name or "Spooki hub",
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 52, 0, 13),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 16,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Title"]:AddToTheme({TextColor3 = "Text"})

                Items["Credit"] = Instances:Create("TextLabel", {
                    Parent = Items["Title"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.5,
                    Text = "by slender",
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 12),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, 6, 0.5, 0),
                    AnchorPoint = Vector2New(0, 0.5),
                    BorderSizePixel = 0,
                    ZIndex = 3,
                    TextSize = math.floor(16 * 0.6),
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Credit"]:AddToTheme({TextColor3 = "Text"})
                
                Items["SubTitle"] = Instances:Create("TextLabel", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.4000000059604645,
                    Text = Window.SubName,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 52, 0, 30),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["SubTitle"]:AddToTheme({TextColor3 = "Text"})

                Items["Content"] = Instances:Create("Frame", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 0.85,
                    Position = UDim2New(0, 0, 0, 55),
                    Size = UDim2New(1, 0, 1, -55),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 25, 29)
                })  Items["Content"]:AddToTheme({BackgroundColor3 = "Background"})

                Items["CloseButton"] = Instances:Create("TextButton", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 0.20000000298023224,
                    Position = UDim2New(1, -14, 0, 11),
                    Size = UDim2New(0, 32, 0, 32),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(27, 25, 29)
                })  Items["CloseButton"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["CloseButton"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["CloseIcon"] = Instances:Create("ImageLabel", {
                    Parent = Items["CloseButton"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(240, 240, 240),
                    ImageTransparency = 0.30000001192092896,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 11, 0, 11),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "rbxassetid://130510492706892",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    ZIndex = 3,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["CloseIcon"]:AddToTheme({ImageColor3 = "Text"})        
                
                Items["CloseIconAccent"] = Instances:Create("Frame", {
                    Parent = Items["CloseButton"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    BorderSizePixel = 0,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    Size = UDim2New(0, 0, 0, 0),
                    ZIndex = 2,
                    BackgroundTransparency = 1,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UICorner", {
                    Parent = Items["CloseIconAccent"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })

                Instances:Create("UICorner", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })      

                Instances:Create("UICorner", {
                    Parent = Items["LeftTabs"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })      
                
                do
                    Items["LeftBottomPixels"] = Instances:Create("Frame", {
                        Parent = Items["MainFrame"].Instance,
                        Name = "\0",
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(1, 1),
                        BackgroundTransparency = 1,
                        Position = UDim2New(0, 1, 1, 0),
                        Size = UDim2New(0, 5, 0, 5),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })
                    
                    Items["___1"] = Instances:Create("Frame", {
                        Parent = Items["LeftBottomPixels"].Instance,
                        Name = "\0",
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(0, 1),
                        BackgroundTransparency = 0.11999999731779099,
                        Position = UDim2New(0, 2, 1, 0),
                        Size = UDim2New(0, 1, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  Items["___1"]:AddToTheme({BackgroundColor3 = "Background"})
                    
                    Items["___2"] = Instances:Create("Frame", {
                        Parent = Items["LeftBottomPixels"].Instance,
                        Name = "\0",
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(0, 1),
                        BackgroundTransparency = 0.11999999731779099,
                        Position = UDim2New(0, 4, 1, 0),
                        Size = UDim2New(0, 1, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  Items["___2"]:AddToTheme({BackgroundColor3 = "Background"})
                    
                    Items["___3"] = Instances:Create("Frame", {
                        Parent = Items["LeftBottomPixels"].Instance,
                        Name = "\0",
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(0, 1),
                        BackgroundTransparency = 0.11999999731779099,
                        Position = UDim2New(0, 3, 1, 0),
                        Size = UDim2New(0, 1, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  Items["___3"]:AddToTheme({BackgroundColor3 = "Background"})
                    
                    Items["___4"] = Instances:Create("Frame", {
                        Parent = Items["LeftBottomPixels"].Instance,
                        Name = "\0",
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(0, 1),
                        BackgroundTransparency = 0.11999999731779099,
                        Position = UDim2New(0, 3, 1, -1),
                        Size = UDim2New(0, 1, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  Items["___4"]:AddToTheme({BackgroundColor3 = "Background"})
                    
                    Items["___5"] = Instances:Create("Frame", {
                        Parent = Items["LeftBottomPixels"].Instance,
                        Name = "\0",
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(0, 1),
                        BackgroundTransparency = 0.11999999731779099,
                        Position = UDim2New(0, 4, 1, -1),
                        Size = UDim2New(0, 1, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  Items["___5"]:AddToTheme({BackgroundColor3 = "Background"})
                    
                    Items["___6"] = Instances:Create("Frame", {
                        Parent = Items["LeftBottomPixels"].Instance,
                        Name = "\0",
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(0, 1),
                        BackgroundTransparency = 0.11999999731779099,
                        Position = UDim2New(0, 5, 1, 0),
                        Size = UDim2New(0, 1, 0, 1),
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  Items["___6"]:AddToTheme({BackgroundColor3 = "Background"})
                    
                    Items["LeftTopPixels"] = Instances:Create("Frame", {
                        Parent = Items["MainFrame"].Instance,
                        Name = "\0",
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(1, 0),
                        BackgroundTransparency = 1,
                        Position = UDim2New(0, 1, 0, 0),
                        Size = UDim2New(0, 5, 0, 5),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })
                    
                    Items["___7"] = Instances:Create("Frame", {
                        Parent = Items["LeftTopPixels"].Instance,
                        Name = "\0",
                        Size = UDim2New(0, 1, 0, 1),
                        Position = UDim2New(0, 2, 0, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        BackgroundTransparency = 0.12,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  Items["___7"]:AddToTheme({BackgroundColor3 = "Background"})   
                    
                    Items["___8"]= Instances:Create("Frame", {
                        Parent = Items["LeftTopPixels"].Instance,
                        Name = "\0",
                        Size = UDim2New(0, 1, 0, 1),
                        BackgroundTransparency = 0.12,
                        Position = UDim2New(0, 3, 0, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  Items["___8"]:AddToTheme({BackgroundColor3 = "Background"})   
                    
                    Items["___9"]= Instances:Create("Frame", {
                        Parent = Items["LeftTopPixels"].Instance,
                        Name = "\0",
                        Size = UDim2New(0, 1, 0, 1),
                        Position = UDim2New(0, 4, 0, 0),
                        BackgroundTransparency = 0.12,
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  Items["___9"]:AddToTheme({BackgroundColor3 = "Background"})   
                    
                    Items["___10"] = Instances:Create("Frame", {
                        Parent = Items["LeftTopPixels"].Instance,
                        Name = "\0",
                        Size = UDim2New(0, 1, 0, 1),
                        Position = UDim2New(0, 5, 0, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        BackgroundTransparency = 0.12,
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  Items["___10"]:AddToTheme({BackgroundColor3 = "Background"})   
                    
                    Items["___11"]=Instances:Create("Frame", {
                        Parent = Items["LeftTopPixels"].Instance,
                        Name = "\0",
                        Size = UDim2New(0, 1, 0, 1),
                        Position = UDim2New(0, 3, 0, 1),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        BackgroundTransparency = 0.12,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  Items["___11"]:AddToTheme({BackgroundColor3 = "Background"})   
                    
                    Items["___12"] = Instances:Create("Frame", {
                        Parent = Items["LeftTopPixels"].Instance,
                        Name = "\0",
                        Size = UDim2New(0, 1, 0, 1),
                        Position = UDim2New(0, 4, 0, 1),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        BackgroundTransparency = 0.12,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  Items["___12"]:AddToTheme({BackgroundColor3 = "Background"})                                      
                end

                function Window:SetTransparency()
                    local val = Library.Flags["BackgroundTransparency"]
                    local numVal = tonumber(val) or 0
                    Items["MainFrame"].Instance.BackgroundTransparency = numVal
                    if not Library.Flags["SpookiBgImageEnabled"] then
                        Items["Content"].Instance.BackgroundTransparency = numVal
                        Items["LeftTabs"].Instance.BackgroundTransparency = numVal
                    end
                    if Items["FloatingButton"] then
                        Items["FloatingButton"].Instance.BackgroundTransparency = numVal
                    end

                    for key, Value in Items do 
                        if type(key) == "string" and key:sub(1, 3) == "___" then
                            Value.Instance.BackgroundTransparency = numVal
                        end
                    end
                end

                function Window:SetUIScale()

                    local UIScale = Items["MainFrame"].Instance:FindFirstChildOfClass("UIScale")
                    if not UIScale then
                        local UIScaleItem = Instances:Create("UIScale", {
                            Parent = Items["MainFrame"].Instance,
                            Name = "\0",
                            Scale = 1
                        })
                        UIScale = UIScaleItem.Instance
                    end
                    UIScale.Scale = Library.Flags["UIScale"] or 1

                    if Items["FloatingGlow"] then
                        local fbScale = Items["FloatingGlow"].Instance:FindFirstChildOfClass("UIScale")
                        if not fbScale then
                            fbScale = InstanceNew("UIScale")
                            fbScale.Parent = Items["FloatingGlow"].Instance
                            fbScale.Name = "\0"
                        end
                        fbScale.Scale = Library.Flags["UIScale"] or 1
                    end
                end

                Instances:Create("UIGradient", {
                    Parent = Items["CloseIconAccent"].Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))},
                    Rotation = -115
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})

                Items["MinimizeButton"] = Instances:Create("TextButton", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    Visible = false,
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 0.20000000298023224,
                    Position = UDim2New(1, -56, 0, 11),
                    Size = UDim2New(0, 32, 0, 32),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(27, 25, 29)
                })  Items["MinimizeButton"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["MinimizeButton"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["MinimizeIcon"] = Instances:Create("ImageLabel", {
                    Parent = Items["MinimizeButton"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(240, 240, 240),
                    ImageTransparency = 0.30000001192092896,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 11, 0, 11),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "rbxassetid://79384247470010",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    ZIndex = 3,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["MinimizeIcon"]:AddToTheme({ImageColor3 = "Text"})
                
                Items["MinimizeIconAccent"] = Instances:Create("Frame", {
                    Parent = Items["MinimizeButton"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    BorderSizePixel = 0,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    Size = UDim2New(0, 0, 0, 0),
                    ZIndex = 2,
                    BackgroundTransparency = 1,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UICorner", {
                    Parent = Items["MinimizeIconAccent"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["MinimizeIconAccent"].Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))},
                    Rotation = -115
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})
                
                Items["MinimizeButton"]:OnHover(function()
                    Items["MinimizeIconAccent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Size = UDim2New(1, 0, 1, 0),
                        BackgroundTransparency = 0
                    })
                end)

                Items["MinimizeButton"]:OnHoverLeave(function()
                    Items["MinimizeIconAccent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Size = UDim2New(0, 0, 0, 0),
                        BackgroundTransparency = 1
                    })
                end)
                
                Items["MinimizeButton"]:Connect("MouseButton1Down", function()
                    Window:SetOpen(false)
                end)

                Items["SettingsButton"] = Instances:Create("TextButton", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 0.20000000298023224,
                    Position = UDim2New(1, -56, 0, 11),
                    Size = UDim2New(0, 32, 0, 32),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(27, 25, 29)
                })  Items["SettingsButton"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["SettingsButton"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["SettingsIcon"] = Instances:Create("ImageLabel", {
                    Parent = Items["SettingsButton"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(240, 240, 240),
                    ImageTransparency = 0.30000001192092896,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 15, 0, 14),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "rbxassetid://122669828593160",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    ZIndex = 3,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["SettingsIcon"]:AddToTheme({ImageColor3 = "Text"})

                Items["SettingsIconAccent"] = Instances:Create("Frame", {
                    Parent = Items["SettingsButton"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    BorderSizePixel = 0,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    Size = UDim2New(0, 0, 0, 0),
                    ZIndex = 2,
                    BackgroundTransparency = 1,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UICorner", {
                    Parent = Items["SettingsIconAccent"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })

                Instances:Create("UIGradient", {
                    Parent = Items["SettingsIconAccent"].Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))},
                    Rotation = -115
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})

                Items["SettingsButton"]:OnHover(function()
                    Items["SettingsIconAccent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Size = UDim2New(1, 0, 1, 0),
                        BackgroundTransparency = 0
                    })
                end)

                Items["SettingsButton"]:OnHoverLeave(function()
                    Items["SettingsIconAccent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Size = UDim2New(0, 0, 0, 0),
                        BackgroundTransparency = 1
                    })
                end)

                Items["CloseButton"]:OnHover(function()
                    Items["CloseIconAccent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Size = UDim2New(1, 0, 1, 0),
                        BackgroundTransparency = 0
                    })
                end)

                Items["CloseButton"]:OnHoverLeave(function()
                    Items["CloseIconAccent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Size = UDim2New(0, 0, 0, 0),
                        BackgroundTransparency = 1
                    })
                end)
                
                Items["CloseButton"]:Connect("MouseButton1Down", function()
                    Window:SetOpen(false)
                end)
                
                local Settings = {
                    IsOpen = false,
                    Name = ""..#Library.Sections,
                    Items = { },
                    IsSettings = true,
                    Elements = { }
                }

                local SettingsItems = { }
                do
                    SettingsItems["Settings"] = Instances:Create("Frame", {
                        Parent = Items["MainFrame"].Instance,
                        Name = "\0",
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(1, 0),
                        BorderSizePixel = 0,
                        Position = UDim2New(1, -10, 0, 50),
                        Size = UDim2New(0, 300, 0, 280),
                        ZIndex = 50,
                        Visible = false,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        BackgroundColor3 = FromRGB(21, 21, 24)
                    }) SettingsItems["Settings"]:AddToTheme({BackgroundColor3 = "Section Background 2"})
                    
                    Instances:Create("UICorner", {
                        Parent = SettingsItems["Settings"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 6)
                    })
                    
                    SettingsItems["CloseButton"] = Instances:Create("TextButton", {
                        Parent = SettingsItems["Settings"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(0, 0, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        AnchorPoint = Vector2New(0, 1),
                        BorderSizePixel = 0,
                        Position = UDim2New(0, 8, 1, -8),
                        Size = UDim2New(1, -16, 0, 32),
                        ZIndex = 2,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(27, 26, 29)
                    }) SettingsItems["CloseButton"]:AddToTheme({BackgroundColor3 = "Element"})
                    
                    Instances:Create("UICorner", {
                        Parent = SettingsItems["CloseButton"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 4)
                    })
                    
                    SettingsItems["Text"] = Instances:Create("TextLabel", {
                        Parent = SettingsItems["CloseButton"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(240, 240, 240),
                        TextTransparency = 0.30000001192092896,
                        Text = "Close",
                        AutomaticSize = Enum.AutomaticSize.X,
                        Size = UDim2New(0, 0, 0, 15),
                        AnchorPoint = Vector2New(0.5, 0.5),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        Position = UDim2New(0.5, 0, 0.5, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })
                    
                    SettingsItems["Content"] = Instances:Create("ScrollingFrame", {
                        Parent = SettingsItems["Settings"].Instance,
                        Name = "\0",
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        Selectable = false,
                        Size = UDim2New(1, -8, 1, -46),
                        Position = UDim2New(0, 4, 0, 4),
                        ScrollBarThickness = 2,
                        BackgroundColor3 = FromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        BorderColor3 = FromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        CanvasSize = UDim2New(0, 0, 0, 0)
                    })  SettingsItems["Content"]:AddToTheme({ScrollBarImageColor3 = "Accent"})
                    
                    Instances:Create("UIListLayout", {
                        Parent = SettingsItems["Content"].Instance,
                        Name = "\0",
                        Padding = UDimNew(0, 4),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })                    
                    
                    Instances:Create("UIPadding", {
                        Parent = SettingsItems["Content"].Instance,
                        Name = "\0",
                        PaddingTop = UDimNew(0, 4),
                        PaddingBottom = UDimNew(0, 4),
                        PaddingRight = UDimNew(0, 4),
                        PaddingLeft = UDimNew(0, 4)
                    })

                    SettingsItems["Accent"] = Instances:Create("Frame", {
                        Parent = SettingsItems["CloseButton"].Instance,
                        Name = "\0",
                        Size = UDim2New(0, 0, 0, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        BackgroundColor3 = FromRGB(255, 255, 255),
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Position = UDim2New(0.5, 0, 0.5, 0)
                    })
    
                    SettingsItems["Gradient"] = Instances:Create("UIGradient", {
                        Parent = SettingsItems["Accent"].Instance,
                        Name = "\0",
                        Enabled = true,
                        Rotation = -115,
                        Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))}
                    })  SettingsItems["Gradient"]:AddToTheme({Color = function()
                        return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                    end})

                    Instances:Create("UICorner", {
                        Parent = SettingsItems["Accent"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 4)
                    })
    
                    Instances:Create("UICorner", {
                        Parent = SettingsItems["CloseButton"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 4)
                    })

                    SettingsItems["CloseButton"]:OnHover(function()
                        SettingsItems["Accent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(1, 0, 1, 0), BackgroundTransparency = 0})
                    end)
    
                    SettingsItems["CloseButton"]:OnHoverLeave(function()
                        SettingsItems["Accent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(0, 0, 0, 0), BackgroundTransparency = 1})
                    end)

                    local RenderStepped 
                    local Debounce = false
    
                    function Settings:SetOpen(Bool)
                        if Debounce then 
                            return
                        end
        
                        Settings.IsOpen = Bool
        
                        Debounce = true 
        
                        if Settings.IsOpen then 
                            for Index, Value in Settings.Elements do
                                if type(Value.RefreshPosition) == "function" then
                                    Value:RefreshPosition(true)
                                end
                                task.wait(0.03)
                            end
    
                            SettingsItems["Settings"].Instance.Visible = true
                            SettingsItems["Settings"].Instance.Parent = Items["MainFrame"].Instance
                            SettingsItems["Settings"].Instance.Position = UDim2New(1, -10, 0, 50)
                            SettingsItems["Settings"].Instance.Size = UDim2New(0, 300, 0, 280)
        
                            for Index, Value in Library.OpenFrames do 
                                if Value ~= Settings then 
                                    Value:SetOpen(false)
                                end
                            end
        
                            Library.OpenFrames[Settings] = Settings 
                        else
                            for Index, Value in Settings.Elements do
                                if type(Value.RefreshPosition) == "function" then
                                    Value:RefreshPosition(false)
                                end
                            end
    
                            if Library.OpenFrames[Settings] then 
                                Library.OpenFrames[Settings] = nil
                            end
        
                            -- settings stays parented to MainFrame (moves with window)
                            if RenderStepped then 
                                RenderStepped:Disconnect()
                                RenderStepped = nil
                            end
                        end
        
                        local Descendants = SettingsItems["Settings"].Instance:GetDescendants()
                        TableInsert(Descendants, SettingsItems["Settings"].Instance)
        
                        local NewTween
        
                        for Index, Value in Descendants do 
                            local TransparencyProperty = Tween:GetProperty(Value)
        
                            if not TransparencyProperty then
                                continue 
                            end
        
                            if not Value.ClassName:find("UI") then 
                                Value.ZIndex = Settings.IsOpen and 7 or 1
                                SettingsItems["Text"].Instance.ZIndex = 8
                            end
        
                            if type(TransparencyProperty) == "table" then 
                                for _, Property in TransparencyProperty do 
                                    NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
                                end
                            else
                                NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
                            end
                        end
                        
                        NewTween.Tween.Completed:Connect(function()
                            Debounce = false 
                            SettingsItems["Settings"].Instance.Visible = Settings.IsOpen
                            SettingsItems["Settings"].Instance.Parent = Items["MainFrame"].Instance
                        end)
                    end
    
                    SettingsItems["CloseButton"]:Connect("MouseButton1Down", function()
                        Settings:SetOpen(false)
                    end)
    
                    Items["SettingsButton"]:Connect("InputBegan", function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then 
                            Settings:SetOpen(not Settings.IsOpen)
                        end
                    end)
    
                    Settings.Items = SettingsItems
                    setmetatable(Settings, Library.Sections)
                end

                Settings:Label("First gradient color"):Colorpicker({
                    Flag = "AccentColor",
                    Default = Library.Theme.Accent,
                    Callback = function(Color)
                        Library.Theme.Accent = Color
                        Library:ChangeTheme("Accent", Color)
                    end
                })

                Settings:Label("Second gradient color"):Colorpicker({
                    Flag = "AccentGradientColor",
                    Default = Library.Theme.AccentGradient,
                    Callback = function(Color)
                        Library.Theme.AccentGradient = Color
                        Library:ChangeTheme("AccentGradient", Color)
                    end
                })

                Settings:Dropdown({
                    Name = "Font weight",
                    Flag = "FontStyle",
                    Default = "SemiBold",
                    Items = {"Light", "Regular", "SemiBold", "Indie Flower", "Fredoka One", "Cartoon"},
                    Callback = function(Value)
                        local FontData = Library.Fonts[Value]

                        if FontData then
                            Library.Font = FontData
                            Library:UpdateText()
                        end
                    end
                })

                Settings:Dropdown({
                    Name = "Notification Position",
                    Flag = "NotificationPosition",
                    Default = "Right",
                    Items = {"Right", "Left"},
                    Callback = function(Value)
                        if Value == "Right" then
                            Library.NotifHolder.Instance.Position = UDim2New(1, 0, 0, 0)
                            Library.NotifHolder.Instance.AnchorPoint = Vector2New(1, 0)
                        else
                            Library.NotifHolder.Instance.Position = UDim2New(0, 0, 0, 0)
                            Library.NotifHolder.Instance.AnchorPoint = Vector2New(0, 0)
                        end
                    end
                })

                Settings:Slider({
                    Name = "Background Transparency",
                    Default = 1,
                    Decimals = 0.01,
                    Max = 1,
                    Min = 0,
                    Suffix = "%",
                    Flag = "BackgroundTransparency",
                    Callback = function(Value)
                        Window:SetTransparency(Value)
                    end
                })

                Settings:Slider({
                    Name = "UI Size",
                    Default = IsMobile and 0.56 or 1,
                    Decimals = 0.01,
                    Max = 1.3,
                    Min = 0.3,
                    Suffix = "x",
                    Flag = "UIScale",
                    Callback = function(Value)
                        Window:SetUIScale()
                        Window:SetCenter()
                    end
                })

                Settings:Keybind({
                    Name = "Menu Keybind",
                    Flag = "MenuBind",
                    Default = Enum.KeyCode.RightAlt,
                    Callback = function(Value)
                        Library.MenuKeybind = tostring(Value)
                    end
                })

                Settings:Dropdown({
                    Name = "Theme Preset",
                    Flag = "SpookiThemePreset",
                    Default = "Spooki",
                    Items = {"Spooki", "Dark", "Darker", "Purple"},
                    Callback = function(Value)
                        local preset = SpookiThemePresets[Value]
                        if not preset then return end
                        local mapped = {
                            Accent = preset.Accent,
                            AccentGradient = preset.Gradient,
                            Background = preset.Background,
                            ["Background 2"] = preset.Background,
                            ["Section Top"] = preset.Element,
                            ["Section Background"] = preset.SectionBg,
                            ["Section Background 2"] = preset.Element,
                            Element = preset.Element,
                            Outline = preset.Accent,
                        }
                        if Library.BatchUpdate then
                            Library:BatchUpdate(function()
                                for k, v in pairs(mapped) do
                                    Library.Theme[k] = v
                                    Library:ChangeTheme(k, v)
                                end
                            end)
                            if Library.FlushBatchedThemes then Library:FlushBatchedThemes() end
                        else
                            for k, v in pairs(mapped) do
                                Library.Theme[k] = v
                                Library:ChangeTheme(k, v)
                            end
                        end
                        for k, v in pairs(preset) do
                            Library.Theme[k] = v
                        end
                        if Library.SetFlags["AccentColor"] then
                            Library.SetFlags["AccentColor"](preset.Accent)
                        end
                        if Library.SetFlags["AccentGradientColor"] then
                            Library.SetFlags["AccentGradientColor"](preset.Gradient)
                        end
                    end
                })

                local BG_IMAGE_ID  = "rbxthumb://type=Asset&id=105520281922171&w=420&h=420"
                local BgImageLabel = nil
                local BgTintLabel  = nil

                Window.SpookiBg = Window.SpookiBg or {
                    FullHub     = true,
                    Transparency = 0.01,
                }

                local function DestroyBgImage()
                    if BgImageLabel then
                        pcall(function() BgImageLabel:Destroy() end)
                        BgImageLabel = nil
                    end
                    if BgTintLabel then
                        pcall(function() BgTintLabel:Destroy() end)
                        BgTintLabel = nil
                    end
                end

                local function ApplyBgImage(Visible)
                    DestroyBgImage()

                    if Items["Content"] and Items["Content"].Instance then
                        Items["Content"].Instance.BackgroundTransparency = Visible and 0.93 or 0.75
                    end
                    if Items["LeftTabs"] and Items["LeftTabs"].Instance then
                        Items["LeftTabs"].Instance.BackgroundTransparency = Visible and 0.9 or 0.15
                    end

                    if not Visible then return end

                    local parentFrame = Items["MainFrame"].Instance
                    local isFullHub = Window.SpookiBg and Window.SpookiBg.FullHub
                    local LEFTTABS_W = 225

                    local xOff = isFullHub and -LEFTTABS_W or 0
                    local xExt = isFullHub and LEFTTABS_W or 0

                    BgImageLabel = InstanceNew("ImageLabel")
                    BgImageLabel.Parent              = parentFrame
                    BgImageLabel.Name                = "SpookiBgImage"
                    BgImageLabel.Image               = BG_IMAGE_ID
                    BgImageLabel.Size                = UDim2New(1, xExt, 1, 0)
                    BgImageLabel.Position            = UDim2New(0, xOff, 0, 0)
                    BgImageLabel.BackgroundTransparency = 1
                    BgImageLabel.ImageTransparency   = Window.SpookiBg.Transparency or 0.01
                    BgImageLabel.ScaleType           = Enum.ScaleType.Crop
                    BgImageLabel.ZIndex              = 0
                    BgImageLabel.BorderSizePixel     = 0

                    local uc = InstanceNew("UICorner")
                    uc.CornerRadius = UDimNew(0, 8)
                    uc.Parent = BgImageLabel

                    BgTintLabel = InstanceNew("Frame")
                    BgTintLabel.Parent               = parentFrame
                    BgTintLabel.Name                 = "SpookiBgTint"
                    BgTintLabel.Size                 = UDim2New(1, xExt, 1, 0)
                    BgTintLabel.Position             = UDim2New(0, xOff, 0, 0)
                    BgTintLabel.BackgroundTransparency = 0.5
                    BgTintLabel.BackgroundColor3     = FromRGB(0, 0, 0)
                    BgTintLabel.ZIndex               = 1
                    BgTintLabel.BorderSizePixel      = 0

                    local uc2 = InstanceNew("UICorner")
                    uc2.CornerRadius = UDimNew(0, 8)
                    uc2.Parent = BgTintLabel
                end

                task.spawn(function()
                    task.wait(0.15)
                    ApplyBgImage(true)
                end)

                -- Background image always on (toggles removed per request)
                Window.SpookiBg.FullHub = true
                Library.Flags["SpookiBgImageEnabled"] = true
                Window.SpookiApplyBg = ApplyBgImage

                Settings:Button({
                    Name = "Reset to Defaults",
                    Callback = function()

                        local preset = SpookiThemePresets.Spooki
                        Library.Theme["Accent"]              = preset.Accent
                        Library.Theme["AccentGradient"]      = preset.Gradient
                        Library.Theme["Background"]          = preset.Background
                        Library.Theme["Background 2"]        = preset.Background
                        Library.Theme["Section Background"]  = preset.SectionBg
                        Library.Theme["Section Background 2"]= preset.Element
                        Library.Theme["Element"]             = preset.Element
                        Library.Theme["Outline"]             = preset.Accent
                        Library:ChangeTheme("Accent",              preset.Accent)
                        Library:ChangeTheme("AccentGradient",      preset.Gradient)
                        Library:ChangeTheme("Background",          preset.Background)
                        Library:ChangeTheme("Background 2",        preset.Background)
                        Library:ChangeTheme("Section Background",  preset.SectionBg)
                        Library:ChangeTheme("Section Background 2",preset.Element)
                        Library:ChangeTheme("Element",             preset.Element)
                        Library:ChangeTheme("Outline",             preset.Accent)

                        for flag, default in pairs(Library.FlagDefaults) do
                            if Library.SetFlags[flag] then
                                pcall(Library.SetFlags[flag], default)
                            end
                        end
                        Window:SetTransparency()
                        Window:SetUIScale()
                        Library:Notification({
                            Title   = "Spooki Hub",
                            Description = "Settings reset to defaults.",
                            Duration = 2,
                            Icon = "87107896404147"
                        })
                    end
                })

                Settings:Button({
                    Name = "Emergency Stop (Teleport/Tween)",
                    Callback = function()
                        Library:TriggerEmergencyStop()
                        Library:Notification({
                            Title   = "Spooki Hub",
                            Description = "Stopped all auto-teleport and Tween activity.",
                            Duration = 2,
                            Icon = "87107896404147"
                        })
                    end
                })

                Settings:Button({
                    Name = "Format",
                    Callback = function()

                        pcall(function()
                            local folder = Library.Folders and Library.Folders.Configs
                            if folder then
                                local autoSaveFile = folder .. "/autosave.json"
                                if isfile(autoSaveFile) then
                                    delfile(autoSaveFile)
                                end
                            end
                        end)

                        local preset = SpookiThemePresets.Spooki
                        Library.Theme["Accent"]              = preset.Accent
                        Library.Theme["AccentGradient"]      = preset.Gradient
                        Library.Theme["Background"]          = preset.Background
                        Library.Theme["Background 2"]        = preset.Background
                        Library.Theme["Section Background"]  = preset.SectionBg
                        Library.Theme["Section Background 2"]= preset.Element
                        Library.Theme["Element"]             = preset.Element
                        Library.Theme["Outline"]             = preset.Accent
                        Library:ChangeTheme("Accent",              preset.Accent)
                        Library:ChangeTheme("AccentGradient",      preset.Gradient)
                        Library:ChangeTheme("Background",          preset.Background)
                        Library:ChangeTheme("Background 2",        preset.Background)
                        Library:ChangeTheme("Section Background",  preset.SectionBg)
                        Library:ChangeTheme("Section Background 2",preset.Element)
                        Library:ChangeTheme("Element",             preset.Element)
                        Library:ChangeTheme("Outline",             preset.Accent)

                        for flag, default in pairs(Library.FlagDefaults) do
                            if Library.SetFlags[flag] then
                                pcall(Library.SetFlags[flag], default)
                            end
                        end
                        Window:SetTransparency()
                        Window:SetUIScale()

                        Library:Notification({
                            Title   = "Spooki Hub",
                            Description = "Formatted: all settings wiped and reset to defaults.",
                            Duration = 3,
                            Icon = "87107896404147"
                        })
                    end
                })

                Window.Items = Items
            end
            
            local Debounce = false

            function Window:SetCenter()
                Items["MainFrame"].Instance.AnchorPoint = Vector2New(0.5, 0.5)
                Items["MainFrame"].Instance.Position = UDim2New(0.5, 0, 0.5, 0)
            end

            function Window:SetOpen(Bool)
                if Debounce then 
                    return
                end

                Window.IsOpen = Bool

                Debounce = true 

                if Window.IsOpen then 
                    Items["MainFrame"].Instance.Visible = true 
                end

                local Descendants = Items["MainFrame"].Instance:GetDescendants()
                TableInsert(Descendants, Items["MainFrame"].Instance)

                local NewTween
                local tweenCount = 0
                local MAX_BATCH_TWEENS = 200

                for Index, Value in Descendants do 

                    if Value.Name == "SpookiBgImage" then
                        local visibleTp = Window.SpookiBg.Transparency or 0.01
                        if Bool then
                            Value.ImageTransparency = 1
                            NewTween = Tween:Create(Value, TweenInfo.new(Library.FadeSpeed, Library.Tween.Style, Library.Tween.Direction), {
                                ImageTransparency = visibleTp
                            }, true)
                        else
                            NewTween = Tween:Create(Value, TweenInfo.new(Library.FadeSpeed, Library.Tween.Style, Library.Tween.Direction), {
                                ImageTransparency = 1
                            }, true)
                            NewTween.Tween.Completed:Connect(function()
                                Value.ImageTransparency = visibleTp
                            end)
                        end
                        tweenCount = tweenCount + 1
                        continue
                    end

                    if Value.Name == "SpookiBgTint" then
                        if Bool then
                            Value.BackgroundTransparency = 1
                            NewTween = Tween:Create(Value, TweenInfo.new(Library.FadeSpeed, Library.Tween.Style, Library.Tween.Direction), {
                                BackgroundTransparency = 0.5
                            }, true)
                        else
                            NewTween = Tween:Create(Value, TweenInfo.new(Library.FadeSpeed, Library.Tween.Style, Library.Tween.Direction), {
                                BackgroundTransparency = 1
                            }, true)
                            NewTween.Tween.Completed:Connect(function()
                                Value.BackgroundTransparency = 0.5
                            end)
                        end
                        tweenCount = tweenCount + 1
                        continue
                    end

                    local TransparencyProperty = Tween:GetProperty(Value)

                    if not TransparencyProperty then
                        continue 
                    end

                    if type(TransparencyProperty) == "table" then 
                        for _, Property in TransparencyProperty do 
                            NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
                            tweenCount = tweenCount + 1
                        end
                    else
                        NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
                        tweenCount = tweenCount + 1
                    end

                    if tweenCount >= MAX_BATCH_TWEENS then
                        task.wait()
                        tweenCount = 0
                    end
                end
                
                NewTween.Tween.Completed:Connect(function()
                    Debounce = false 
                    Items["MainFrame"].Instance.Visible = Window.IsOpen
                end)
            end

            if Items["FloatingButton"] then
                Items["FloatingButton"]:Connect("InputEnded", function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        local hold = tick() - FBClickTimer
                        local mag = (Input.Position - FBDragStart).Magnitude
                        -- click: hold between 0.05 and 0.35s AND movement < 15px
                        -- longer hold or bigger move = drag only
                        if (not FBDragMoved) and mag < 15 and hold >= 0.05 and hold <= 0.35 then
                            Window:SetOpen(not Window.IsOpen)
                        end
                    end
                end)
            end

            function Window:Init()
                for __, Value in Window.Pages do
                    if Value.Active then
                        for _, Value2 in Value.Sections do
                            task.spawn(function()
                                Value2:TweenElements(true)
                                Library:RefreshConfigsList(ConfigsDropdown)
                            end)
                        end
                    end
                end

                task.spawn(function()
                    task.wait(0.5)

                    local autoSaveFile = Library.Folders.Configs .. "/autosave.json"
                    local loadedFromAutoSave = false
                    if isfile(autoSaveFile) then
                        local ok = pcall(function()
                            Library:LoadConfig(readfile(autoSaveFile))
                        end)
                        if ok then
                            loadedFromAutoSave = true
                        end
                    end

                    if not loadedFromAutoSave then
                        local autoLoadFile = Library.Folders.Configs .. "/autoload.txt"
                        if isfile(autoLoadFile) then
                            local success, content = pcall(readfile, autoLoadFile)
                            if success and content and isfile(content) then
                                Library:LoadConfig(readfile(content))
                                Library:Notification({
                                    Title = "Config",
                                    Description = "Auto loaded config: " .. content:match("([^/\\]+)$"),
                                    Duration = 2
                                })
                            end
                        end
                    end

                    if Window.SpookiBg then
                        Window.SpookiBg.Transparency = 0.01
                    end
                    if Library.Flags["SpookiBgImageEnabled"] == nil then
                        Library.Flags["SpookiBgImageEnabled"] = true
                    end
                    if Library.Flags["SpookiBgFullHub"] == nil then
                        Library.Flags["SpookiBgFullHub"] = true
                    end
                    Window.SpookiBg.FullHub = Library.Flags["SpookiBgFullHub"]

                    if Window.SpookiApplyBg and Library.Flags["SpookiBgImageEnabled"] then
                        Window.SpookiApplyBg(true)
                    end

                    Window:SetTransparency()

                    task.spawn(function()
                        while true do
                            task.wait(Library.ConnectionCleanupInterval)
                            Library:CleanupConnections()
                        end
                    end)

                    task.spawn(function()
                        while true do
                            task.wait(2)
                            pcall(function()
                                local folder = Library.Folders and Library.Folders.Configs
                                if not folder then
                                    local dir = (Library.Folders and Library.Folders.Directory) or "SpookiHub"
                                    folder = dir .. "/Configs"
                                end
                                if not isfolder(folder) then
                                    local ok = pcall(makefolder, folder)
                                    if not ok then return end
                                end
                                pcall(writefile, folder .. "/autosave.json", Library:GetConfig())
                            end)
                        end
                    end)
                end)
            end

            Library:Connect(UserInputService.InputBegan, function(Input)
                local MenuBindData = Library.Flags.MenuBind
                local CurrentMenuKey = MenuBindData and MenuBindData.Key or Library.MenuKeybind
                if tostring(Input.KeyCode) == CurrentMenuKey or tostring(Input.UserInputType) == CurrentMenuKey then
                    Window:SetOpen(not Window.IsOpen)
                end
            end)

            local SilentLoadStart = false
            pcall(function()
                local path = Library.Folders.Configs .. "/silentload.txt"
                if isfile and isfile(path) and readfile then
                    local ok, content = pcall(readfile, path)
                    if ok and content == "true" then
                        SilentLoadStart = true
                    end
                end
            end)

            Window:SetCenter()

            if not SilentLoadStart then
                task.spawn(function()
                    local Intro = { }

                    task.spawn(function()
                        task.wait(4)
                        pcall(function()
                            if Intro["Holder"] then
                                Intro["Holder"].Instance.Visible = false
                                Intro["Holder"]:Clean()
                            end
                        end)
                        pcall(function()
                            Items["MainFrame"].Instance.Visible = true
                            Window.IsOpen = true
                        end)
                    end)

                    Window.IsOpen = false
                    Items["MainFrame"].Instance.Visible = false

                    Intro["Holder"] = Instances:Create("Frame", {
                        Parent = Library.Holder.Instance,
                        Name = "\0",
                        BackgroundColor3 = FromRGB(8, 8, 8),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Position = UDim2New(0.5, 0, 0.5, 0),
                        Size = UDim2New(1, 999999, 1, 999999),
                        ZIndex = 50
                    })

                    Intro["Logo"] = Instances:Create("ImageLabel", {
                        Parent = Intro["Holder"].Instance,
                        Name = "\0",
                        Image = "rbxassetid://" .. Window.Logo,
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Position = UDim2New(0.5, 0, 0.5, -16),
                        Size = UDim2New(0, 0, 0, 0),
                        ZIndex = 51
                    })

                    Instances:Create("UICorner", {
                        Parent = Intro["Logo"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(1, 0)
                    })

                    Intro["Title"] = Instances:Create("TextLabel", {
                        Parent = Intro["Holder"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        Text = Window.Name,
                        TextColor3 = FromRGB(255, 50, 50),
                        TextTransparency = 1,
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Position = UDim2New(0.5, 0, 0.5, 40),
                        TextSize = 20,
                        ZIndex = 51
                    })

                    Intro["SubTitle"] = Instances:Create("TextLabel", {
                        Parent = Intro["Holder"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        Text = Window.SubName or "",
                        TextColor3 = FromRGB(160, 160, 160),
                        TextTransparency = 1,
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Position = UDim2New(0.5, 0, 0.5, 62),
                        TextSize = 14,
                        ZIndex = 51
                    })

                    do
                        local fmtBtn = InstanceNew("TextButton")
                        fmtBtn.Parent                 = Intro["Holder"].Instance
                        fmtBtn.Name                   = "\0"
                        fmtBtn.Text                   = ""
                        fmtBtn.BackgroundColor3       = FromRGB(20, 18, 22)
                        fmtBtn.BackgroundTransparency = 0.4
                        fmtBtn.BorderSizePixel        = 0
                        fmtBtn.AnchorPoint            = Vector2New(0.5, 0.5)
                        fmtBtn.Position               = UDim2New(0.5, 0, 0.5, 110)
                        fmtBtn.Size                   = UDim2New(0, 140, 0, 34)
                        fmtBtn.ZIndex                 = 51
                        fmtBtn.AutoButtonColor        = false
                        fmtBtn.Visible                = false

                        local fmtBtnUc = InstanceNew("UICorner")
                        fmtBtnUc.CornerRadius = UDimNew(0, 8)
                        fmtBtnUc.Parent = fmtBtn

                        local fmtBtnStroke = InstanceNew("UIStroke")
                        fmtBtnStroke.Color = FromRGB(255, 50, 50)
                        fmtBtnStroke.Thickness = 1
                        fmtBtnStroke.Transparency = 0.6
                        fmtBtnStroke.Parent = fmtBtn

                        local fmtBtnLabel = InstanceNew("TextLabel")
                        fmtBtnLabel.Parent                 = fmtBtn
                        fmtBtnLabel.Name                   = "\0"
                        fmtBtnLabel.FontFace               = Library.Font
                        fmtBtnLabel.Text                   = "FORMAT 🛠️"
                        fmtBtnLabel.TextColor3             = FromRGB(255, 50, 50)
                        fmtBtnLabel.TextTransparency       = 0.2
                        fmtBtnLabel.TextSize               = 13
                        fmtBtnLabel.BackgroundTransparency = 1
                        fmtBtnLabel.BorderSizePixel        = 0
                        fmtBtnLabel.AnchorPoint            = Vector2New(0.5, 0.5)
                        fmtBtnLabel.Position               = UDim2New(0.5, 0, 0.5, 0)
                        fmtBtnLabel.Size                   = UDim2New(1, 0, 1, 0)
                        fmtBtnLabel.ZIndex                 = 52

                        local fmtBtnGlow = InstanceNew("Frame")
                        fmtBtnGlow.Parent                 = fmtBtn
                        fmtBtnGlow.Name                   = "\0"
                        fmtBtnGlow.BackgroundColor3       = FromRGB(255, 50, 50)
                        fmtBtnGlow.BackgroundTransparency = 1
                        fmtBtnGlow.BorderSizePixel        = 0
                        fmtBtnGlow.Size                   = UDim2New(1, 0, 1, 0)
                        fmtBtnGlow.ZIndex                 = 1

                        local fmtBtnGlowUc = InstanceNew("UICorner")
                        fmtBtnGlowUc.CornerRadius = UDimNew(0, 8)
                        fmtBtnGlowUc.Parent = fmtBtnGlow

                        fmtBtn.MouseEnter:Connect(function()
                            fmtBtn:Tween(TweenInfo.new(0.15), {BackgroundTransparency = 0.15})
                            fmtBtnStroke:Tween(TweenInfo.new(0.15), {Transparency = 0.2})
                            fmtBtnGlow:Tween(TweenInfo.new(0.15), {BackgroundTransparency = 0.85})
                        end)
                        fmtBtn.MouseLeave:Connect(function()
                            fmtBtn:Tween(TweenInfo.new(0.3), {BackgroundTransparency = 0.4})
                            fmtBtnStroke:Tween(TweenInfo.new(0.3), {Transparency = 0.6})
                            fmtBtnGlow:Tween(TweenInfo.new(0.3), {BackgroundTransparency = 1})
                        end)
                        fmtBtn.MouseButton1Click:Connect(function()

                            local folder = Library.Folders and Library.Folders.Configs
                            if folder then
                                local autoSaveFile = folder .. "/autosave.json"
                                if isfile and isfile(autoSaveFile) then delfile(autoSaveFile) end
                            end
                            local preset = SpookiThemePresets.Spooki
                            Library.Theme["Accent"]         = preset.Accent
                            Library.Theme["AccentGradient"] = preset.Gradient
                            Library.Theme["Background"]     = preset.Background
                            Library.Theme["Background 2"]   = preset.Background
                            Library.Theme["Section Background"] = preset.SectionBg
                            Library.Theme["Section Background 2"] = preset.Element
                            Library.Theme["Element"]        = preset.Element
                            Library.Theme["Outline"]        = preset.Accent
                            Library:ChangeTheme("Accent",         preset.Accent)
                            Library:ChangeTheme("AccentGradient", preset.Gradient)
                            Library:ChangeTheme("Background",     preset.Background)
                            Library:ChangeTheme("Background 2",   preset.Background)
                            Library:ChangeTheme("Section Background", preset.SectionBg)
                            Library:ChangeTheme("Section Background 2", preset.Element)
                            Library:ChangeTheme("Element",        preset.Element)
                            Library:ChangeTheme("Outline",        preset.Accent)
                            for flag, default in pairs(Library.FlagDefaults) do
                                if Library.SetFlags[flag] then
                                    pcall(Library.SetFlags[flag], default)
                                end
                            end
                            Window:SetTransparency()
                            Window:SetUIScale()
                            Library:Notification({
                                Title   = "Spooki Hub",
                                Description = "Formatted: all settings wiped and reset to defaults.",
                                Duration = 3,
                                Icon = "87107896404147"
                            })
                        end)

                        Intro["FormatBtn"] = { Instance = fmtBtn }
                    end

                    Intro["Holder"]:Tween(TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 0.25
                    })

                    Intro["Logo"]:Tween(TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Size = UDim2New(0, 82, 0, 82)
                    })

                    Intro["Title"]:Tween(TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        TextTransparency = 0
                    })

                    Intro["SubTitle"]:Tween(TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        TextTransparency = 0
                    })

                    task.wait(0.6)
                    if Intro["FormatBtn"] and Intro["FormatBtn"].Instance then
                        Intro["FormatBtn"].Instance.Visible = true
                        Intro["FormatBtn"].Instance.BackgroundTransparency = 0.6
                        Intro["FormatBtn"].Instance:Tween(TweenInfo.new(0.3), {BackgroundTransparency = 0.4})
                    end

                    task.wait(0.4)

                    local ok, err = pcall(Window.SetOpen, Window, true)
                    if not ok then
                        Items["MainFrame"].Instance.Visible = true
                        Window.IsOpen = true
                    end

                    Intro["Holder"]:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        BackgroundTransparency = 1
                    })

                    Intro["Title"]:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        TextTransparency = 1
                    })

                    Intro["SubTitle"]:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        TextTransparency = 1
                    })

                    Intro["Logo"]:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Size = UDim2New(0, 0, 0, 0)
                    })

                    task.wait(0.35)

                    pcall(function()
                        if Intro["Holder"] and Intro["Holder"].Clean then
                            Intro["Holder"]:Clean()
                        end
                    end)
                end)
            else

                Window.IsOpen = false
                Items["MainFrame"].Instance.Visible = false
            end
            return setmetatable(Window, Library)
        end

        Library.Watermark = function(self, Data)
            if not self or not self.Holder or not self.Holder.Instance or not self.Holder.Instance.Parent then return end
            if not self.WatermarkFrame then
                self.WatermarkFrame = Instances:Create("Frame", {
                    Parent = self.Holder.Instance,
                    Name = "Watermark",
                    AnchorPoint = Vector2New(0, 0),
                    Position = UDim2New(0, 15, 0, 15),
                    Size = UDim2New(0, 0, 0, 30),
                    AutomaticSize = Enum.AutomaticSize.X,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 25, 29),
                    BackgroundTransparency = 0.2,
                    ZIndex = 10,
                    Visible = false
                })
                self.WatermarkFrame:MakeDraggable()

                Instances:Create("UICorner", {
                    Parent = self.WatermarkFrame.Instance,
                    CornerRadius = UDimNew(0, 4)
                })
                
                Instances:Create("UIStroke", {
                    Parent = self.WatermarkFrame.Instance,
                    Color = FromRGB(0, 0, 0),
                    Thickness = 1,
                    Transparency = 0
                })
                local AccentLine = Instances:Create("Frame", {
                    Parent = self.WatermarkFrame.Instance,
                    Name = "Accent",
                    Size = UDim2New(1, 0, 0, 2),
                    Position = UDim2New(0, 0, 0, 0), 
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    ZIndex = 12
                })
                
                Instances:Create("UICorner", {
                    Parent = AccentLine.Instance,
                    CornerRadius = UDimNew(0, 4)
                })

                local Gradient = Instances:Create("UIGradient", {
                    Parent = AccentLine.Instance,
                    Color = RGBSequence{
                        RGBSequenceKeypoint(0, Library.Theme.Accent), 
                        RGBSequenceKeypoint(1, Library.Theme.AccentGradient)
                    }
                })
                
                Gradient:AddToTheme({
                    Color = function()
                        return RGBSequence{
                            RGBSequenceKeypoint(0, Library.Theme.Accent), 
                            RGBSequenceKeypoint(1, Library.Theme.AccentGradient)
                        }
                    end
                })

                local Content = Instances:Create("Frame", {
                    Parent = self.WatermarkFrame.Instance,
                    Name = "Content",
                    Size = UDim2New(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    ZIndex = 11
                })

                Instances:Create("UIListLayout", {
                    Parent = Content.Instance,
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDimNew(0, 6)
                })

                Instances:Create("UIPadding", {
                    Parent = Content.Instance,
                    PaddingLeft = UDimNew(0, 10),
                    PaddingRight = UDimNew(0, 10),
                    PaddingTop = UDimNew(0, 4) 
                })

                if self.ToClean then
                    table.insert(self.ToClean, self.WatermarkFrame.Instance)
                end
            end

            local ContentFrame = self.WatermarkFrame.Instance:FindFirstChild("Content")
            for Index, Value in ipairs(Data) do
                if Index > 1 then
                    local SepName = "Sep_" .. Index
                    local Sep = ContentFrame:FindFirstChild(SepName)
                    if not Sep then
                        Sep = Instances:Create("TextLabel", {
                            Parent = ContentFrame,
                            Name = SepName,
                            Text = "|",
                            TextColor3 = FromRGB(80, 80, 80),
                            FontFace = Library.Font,
                            TextSize = 12,
                            BackgroundTransparency = 1,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            LayoutOrder = (Index * 2) - 1,
                            ZIndex = 11
                        }).Instance
                    end
                end

                local ItemName = "Item_" .. Index
                local ExistingItem = ContentFrame:FindFirstChild(ItemName)
                
                local Type = type(Value)
                local IsImage = (Type == "number" or (Type == "string" and string.find(Value, "rbxassetid")))

                if ExistingItem then
                    if IsImage and not ExistingItem:IsA("ImageLabel") then
                        ExistingItem:Destroy()
                        ExistingItem = nil
                    elseif not IsImage and not ExistingItem:IsA("TextLabel") then
                        ExistingItem:Destroy()
                        ExistingItem = nil
                    end
                end

                if not ExistingItem then
                    if IsImage then
                        ExistingItem = Instances:Create("ImageLabel", {
                            Parent = ContentFrame,
                            Name = ItemName,
                            BackgroundTransparency = 1,
                            Size = UDim2New(0, 24, 0, 24),
                            ImageColor3 = FromRGB(255, 255, 255),
                            LayoutOrder = Index * 2,
                            ZIndex = 11
                        }).Instance
                    else
                        ExistingItem = Instances:Create("TextLabel", {
                            Parent = ContentFrame,
                            Name = ItemName,
                            TextColor3 = FromRGB(240, 240, 240),
                            FontFace = Library.Font,
                            TextSize = 11,
                            BackgroundTransparency = 1,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            LayoutOrder = Index * 2,
                            ZIndex = 11
                        }).Instance
                    end
                end

                if IsImage then
                    local ImageId = (Type == "number") and "rbxassetid://"..Value or Value
                    if ExistingItem.Image ~= ImageId then
                        ExistingItem.Image = ImageId
                    end
                else
                    local TextVal = tostring(Value)
                    if ExistingItem.Text ~= TextVal then
                        ExistingItem.Text = TextVal
                    end
                end
            end

            for _, Child in pairs(ContentFrame:GetChildren()) do
                if Child.Name:find("Item_") or Child.Name:find("Sep_") then
                    local _, IndexStr = Child.Name:match("(%a+)_(%d+)")
                    local Index = tonumber(IndexStr)
                    if Index and Index > #Data then
                        Child:Destroy()
                    end
                end
            end
        end

        Library.Category = function(self, Name)
            local Items = { } do 
                Items["Category"] = Instances:Create("TextLabel", {
                    Parent = self.Items["LeftTabs"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.4000000059604645,
                    Text = Name,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(1, 0, 0, 15),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Category"]:AddToTheme({TextColor3 = "Text"})
            end                
        end

        Library.Page = function(self, Data)
            Data = Data or { }

            local Page = {
                Window = self,

                Name = Data.Name or Data.name or "Page",
                Icon = Data.Icon or Data.icon or "100050851789190",
                Columns = Data.Columns or Data.columns or 1,

                Items = { },
                ColumnsData = { },
                Sections = { },
                Active = false
            }

            local Items = { } do
                Items["Inactive"] = Instances:Create("TextButton", {
                    Parent = Page.Window.Items["LeftTabs"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2New(0, 200, 0, 40),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(124, 163, 255)
                })  Items["Inactive"]:AddToTheme({BackgroundColor3 = "Accent"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })
                
                Items.Gradient = Instances:Create("UIGradient", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    Transparency = NumSequence{NumSequenceKeypoint(0, 0.41874998807907104), NumSequenceKeypoint(0.445, 0.78125), NumSequenceKeypoint(0.751, 0.9375), NumSequenceKeypoint(1, 1)}
                })
                
                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 18, 0, 18),
                    AnchorPoint = Vector2New(0, 0.5),
                    Image = "rbxassetid://"..Page.Icon,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 16, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UIGradient", {
                    Parent = Items["Icon"].Instance,
                    Name = "\0",
                    Rotation = -115
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Page.Name,
                    AutomaticSize = Enum.AutomaticSize.X,
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 45, 0.5, 0),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})      
                
                Items["Page"] = Instances:Create("Frame", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    Visible = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 1, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    Position = UDim2New(0, 0, 0, 60),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["Page"].Instance,
                    Name = "\0",
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Padding = UDimNew(0, 10),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                })
                
                Instances:Create("UIPadding", {
                    Parent = Items["Page"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 10),
                    PaddingBottom = UDimNew(0, 10),
                    PaddingRight = UDimNew(0, 10),
                    PaddingLeft = UDimNew(0, 10)
                })                

                for Index = 1, Page.Columns do 
                    local NewColumn = Instances:Create("ScrollingFrame", {
                        Parent = Items["Page"].Instance,
                        Name = "\0",
                        ScrollBarImageColor3 = FromRGB(0, 0, 0),
                        Active = true,
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        ScrollBarThickness = 0,
                        BorderColor3 = FromRGB(0, 0, 0),
                        BackgroundTransparency = 1,
                        Size = UDim2New(0, 100, 0, 100),
                        BackgroundColor3 = FromRGB(255, 255, 255),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        CanvasSize = UDim2New(0, 0, 0, 0)
                    })
                    
                    Instances:Create("UIListLayout", {
                        Parent = NewColumn.Instance,
                        Name = "\0",
                        Padding = UDimNew(0, 12),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    Page.ColumnsData[Index] = NewColumn
                end

                Page.Items = Items
            end

            local Debounce = false

            function Page:Turn(Bool)
                if Debounce then 
                    return 
                end

                Page.Active = Bool 
                
                Debounce = true
                Items["Page"].Instance.Visible = Bool 
                Items["Page"].Instance.Parent = Bool and Page.Window.Items["Content"].Instance or Library.UnusedHolder.Instance

                local SlideTween
                if Page.Active then
                    Items["Inactive"]:Tween(nil, {BackgroundTransparency = 0.25})
                    SlideTween = Items["Page"]:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0, 0)})

                    for Index, Value in Page.Sections do 
                        task.spawn(function()

                            Value:TweenElements(true, true)
                        end)
                    end
                else
                    Items["Inactive"]:Tween(nil, {BackgroundTransparency = 1})
                    SlideTween = Items["Page"]:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0, 60)})
                end

                if SlideTween and SlideTween.Tween and SlideTween.Tween.Completed then
                    Library:Connect(SlideTween.Tween.Completed, function()
                        Debounce = false

                        if not Page.Active then
                            for Index, Value in Page.Sections do
                                task.spawn(function()
                                    Value:TweenElements(false, true)
                                end)
                            end
                        end
                    end)
                else

                    task.delay(0.55, function()
                        Debounce = false
                    end)
                end
            end

            Items["Inactive"]:Connect("MouseButton1Down", function()
                for Index, Value in Page.Window.Pages do 
                    if Value == Page and Page.Active then
                        return
                    end

                    Value:Turn(Value == Page)
                end
            end)

            if #Page.Window.Pages == 0 then 
                Page:Turn(true)
            end
            
            TableInsert(Page.Window.Pages, Page)
            return setmetatable(Page, Library.Pages)
        end

        Library.Pages.GlobalChat = function(self, Side)
            local GlobalChat = { }
            Library.GlobalChatt = GlobalChat

            local Items = { } do 
                Items["GlobalChat"] = Instances:Create("Frame", {
                    Parent = self.ColumnsData[Side].Instance,
                    Name = "\0",
                    BackgroundTransparency = 0.30000001192092896,
                    Position = UDim2New(0,0,0,0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 25, 29)
                })  Items["GlobalChat"]:AddToTheme({BackgroundColor3 = "Section Background 2"})

                Items["GlobalChat"]:MakeDraggable()
                
                Instances:Create("UICorner", {
                    Parent = Items["GlobalChat"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Items["Title"] = Instances:Create("TextLabel", {
                    Parent = Items["GlobalChat"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "GLOBAL CHAT",
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 12, 0, 13),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 16,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Title"]:AddToTheme({TextColor3 = "Text"})
                
                Items["SubTitle"] = Instances:Create("TextLabel", {
                    Parent = Items["GlobalChat"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.4000000059604645,
                    Text = "Chat with other users here.",
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 14, 0, 30),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["SubTitle"]:AddToTheme({TextColor3 = "Text"})
                
                Items["Message"] = Instances:Create("Frame", {
                    Parent = Items["GlobalChat"].Instance,
                    Name = "\0",
                    Active = true,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 1),
                    Selectable = true,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 12, 1, -12),
                    Size = UDim2New(1, -66, 0, 32),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 26, 29)
                })  Items["Message"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Message"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Items["Background"] = Instances:Create("Frame", {
                    Parent = Items["Message"].Instance,
                    Name = "\0",
                    Active = true,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, 0),
                    Selectable = true,
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 26, 29)
                })  Items["Background"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Items["Input"] = Instances:Create("TextBox", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    ZIndex = 2,
                    Size = UDim2New(1, -20, 0, 15),
                    Position = UDim2New(0, 10, 0, 8),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    PlaceholderColor3 = FromRGB(185, 185, 185),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    PlaceholderText = "Message...",
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Input"]:AddToTheme({TextColor3 = "Text"})
                
                Items["SendButton"] = Instances:Create("TextButton", {
                    Parent = Items["GlobalChat"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 1),
                    Position = UDim2New(1, -12, 1, -12),
                    Size = UDim2New(0, 32, 0, 32),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(27, 26, 29)
                })  Items["SendButton"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["SendButton"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Items["SendIcon"] = Instances:Create("ImageLabel", {
                    Parent = Items["SendButton"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ImageTransparency = 0.2,
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "rbxassetid://101636617799068",
                    BackgroundTransparency = 1,
                    ZIndex = 3,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    Size = UDim2New(0, 22, 0, 22),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["Accent"] = Instances:Create("Frame", {
                    Parent = Items["SendButton"].Instance,
                    Name = "\0",
                    Size = UDim2New(0, 0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Position = UDim2New(0.5, 0, 0.5, 0)
                })

                Instances:Create("UICorner", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })

                Instances:Create("UIGradient", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    Enabled = true,
                    Rotation = -115,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})

                Items["SendButton"]:OnHover(function()
                    Items["Accent"]:Tween(TweenInfo.new(Library.Tween.Time+0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(1, 0, 1, 0), BackgroundTransparency = 0})
                end)

                Items["SendButton"]:OnHoverLeave(function()
                    Items["Accent"]:Tween(TweenInfo.new(Library.Tween.Time+0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(0, 0, 0, 0), BackgroundTransparency = 1})
                end)
                
                Items["Messages"] = Instances:Create("ScrollingFrame", {
                    Parent = Items["GlobalChat"].Instance,
                    Name = "\0",
                    ScrollBarImageColor3 = FromRGB(124, 163, 255),
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 2,
                    Size = UDim2New(1, -24, 1, -115),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 12, 0, 60),
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    CanvasSize = UDim2New(0, 0, 0, 0)
                })  Items["Messages"]:AddToTheme({ScrollBarImageColor3 = "Accent"})
                
                Instances:Create("UIListLayout", {
                    Parent = Items["Messages"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 5),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Instances:Create("UIPadding", {
                    Parent = Items["Messages"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 0),
                    PaddingBottom = UDimNew(0, 0),
                    PaddingRight = UDimNew(0, 10),
                    PaddingLeft = UDimNew(0, 0)
                })

                Items["Status"] = Instances:Create("Frame", {
                    Parent = Items["GlobalChat"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, -12, 0, 10),
                    Size = UDim2New(0, 100, 0, 20),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["StatusCircle"] = Instances:Create("Frame", {
                    Parent = Items["Status"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(1, 0.5),
                    Position = UDim2New(1, 0, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 12, 0, 12),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 210, 62)
                })

                Items["Glow"] = Instances:Create("ImageLabel", {
                    Parent = Items["StatusCircle"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(255, 210, 62),
                    ScaleType = Enum.ScaleType.Slice,
                    ImageTransparency = 0.30000001192092896,
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    Size = UDim2New(1, 8, 1, 8),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    SliceCenter = RectNew(Vector2New(21, 21), Vector2New(79, 79))
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["StatusCircle"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })
                
                Items["StatusText"] = Instances:Create("TextLabel", {
                    Parent = Items["Status"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 210, 62),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "67 Active | Connected",
                    AnchorPoint = Vector2New(1, 0.5),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, -20, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })                
            end

            function GlobalChat:SetVisibility(Bool)
                Items["GlobalChat"].Instance.Visible = Bool
                Items["GlobalChat"].Instance.Parent = Bool and Data.MainFrame.Instance or Library.UnusedHolder
            end

            function GlobalChat:SetStatus(Text, Color)
                Items["StatusText"].Instance.Text = Text
                Items["StatusText"].Instance.TextColor3 = Color
                Items["StatusCircle"].Instance.BackgroundColor3 = Color
            end

            function GlobalChat:SetStatusText(Text)
                if not Done then
                    Items["StatusText"].Instance.TextColor3 = FromRGB(62, 255, 91)
                    Items["Glow"].Instance.ImageColor3 = FromRGB(62, 255, 91)
                    Items["StatusCircle"].Instance.BackgroundColor3 = FromRGB(62, 255, 91)
                    Done = true
                end
                Items["StatusText"].Instance.Text = Text
            end

            local OnMessagePressed            

            function GlobalChat:OnMessageSendPressed(Func)
                OnMessagePressed = Func
            end

            function GlobalChat:GetTypedMessage()
                return Items["Input"].Instance.Text
            end

            function GlobalChat:ClearText()
                Items["Input"].Instance.Text = ""
            end

            function GlobalChat:SendMessage(Avatar, Username, Message, IsLocalPlayer)
                local SubItems = { } do
                    if not IsLocalPlayer then
                        SubItems["Message1"] = Instances:Create("Frame", {
                            Parent = Items["Messages"].Instance,
                            Name = "\0",
                            BackgroundTransparency = 1,
                            Size = UDim2New(1, 0, 0, 45),
                            ZIndex = 2,
                            BorderColor3 = FromRGB(0, 0, 0),
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.Y,
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        })

                        SubItems["PlayerName"] = Instances:Create("TextLabel", {
                            Parent = SubItems["Message1"].Instance,
                            Name = "\0",
                            FontFace = Library.Font,
                            TextColor3 = FromRGB(240, 240, 240),
                            BorderColor3 = FromRGB(0, 0, 0),
                            Text = Username,
                            Size = UDim2New(0, 0, 0, 15),
                            BackgroundTransparency = 1,
                            RichText = true,
                            Position = UDim2New(0, 38, 0, 0),
                            TextTransparency = 0.3,
                            BorderSizePixel = 0,
                            ZIndex = 2,
                            AutomaticSize = Enum.AutomaticSize.X,
                            TextSize = 14,
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        })  SubItems["PlayerName"]:AddToTheme({TextColor3 = "Text"})

                        SubItems["RealMessage"] = Instances:Create("Frame", {
                            Parent = SubItems["Message1"].Instance,
                            Name = "\0",
                            Position = UDim2New(0, 38, 0, 20),
                            BorderColor3 = FromRGB(0, 0, 0),
                            BorderSizePixel = 0,
                            ZIndex = 2,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            BackgroundColor3 = FromRGB(27, 25, 29)
                        })  SubItems["RealMessage"]:AddToTheme({BackgroundColor3 = "Background"})

                        Instances:Create("UISizeConstraint", {
                            Parent = SubItems["RealMessage"].Instance,
                            Name = "\0",
                            MaxSize = Vector2New(370, 70)
                        })

                        Instances:Create("UICorner", {
                            Parent = SubItems["RealMessage"].Instance,
                            Name = "\0",
                            CornerRadius = UDimNew(0, 4)
                        })

                        SubItems["MessageText"] = Instances:Create("TextLabel", {
                            Parent = SubItems["RealMessage"].Instance,
                            Name = "\0",
                            FontFace = Library.Font,
                            TextColor3 = FromRGB(240, 240, 240),
                            BorderColor3 = FromRGB(0, 0, 0),
                            Text = Message,
                            BackgroundTransparency = 1,
                            TextWrapped = true,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            TextSize = 14,
                            ZIndex = 2,
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        })  SubItems["MessageText"]:AddToTheme({TextColor3 = "Text"})

                        Instances:Create("UIPadding", {
                            Parent = SubItems["RealMessage"].Instance,
                            Name = "\0",
                            PaddingTop = UDimNew(0, 10),
                            PaddingBottom = UDimNew(0, 10),
                            PaddingRight = UDimNew(0, 10),
                            PaddingLeft = UDimNew(0, 10)
                        })

                        SubItems["Avatar"] = Instances:Create("ImageLabel", {
                            Parent = SubItems["Message1"].Instance,
                            Name = "\0",
                            BorderColor3 = FromRGB(0, 0, 0),
                            AnchorPoint = Vector2New(0, 0.5),
                            Image = Avatar,
                            BackgroundTransparency = 1,
                            Position = UDim2New(0, 0, 0.5, 0),
                            Size = UDim2New(0, 30, 0, 30),
                            ZIndex = 2,
                            BorderSizePixel = 0,
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        })

                        Instances:Create("UICorner", {
                            Parent = SubItems["Avatar"].Instance,
                            Name = "\0",
                            CornerRadius = UDimNew(0, 4)
                        })
                    else
                        SubItems["Message1"] = Instances:Create("Frame", {
                            Parent = Items["Messages"].Instance,
                            Name = "\0",
                            BackgroundTransparency = 1,
                            Size = UDim2New(1, 0, 0, 45),
                            BorderColor3 = FromRGB(0, 0, 0),
                            BorderSizePixel = 0,
                            ZIndex = 2,
                            AutomaticSize = Enum.AutomaticSize.Y,
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        })

                        SubItems["PlayerName"] = Instances:Create("TextLabel", {
                            Parent = SubItems["Message1"].Instance,
                            Name = "\0",
                            FontFace = Library.Font,
                            TextColor3 = FromRGB(240, 240, 240),
                            BorderColor3 = FromRGB(0, 0, 0),
                            Text = Username,
                            RichText = true,
                            AnchorPoint = Vector2New(1, 0),
                            Size = UDim2New(0, 0, 0, 15),
                            ZIndex = 2,
                            TextTransparency = 0.3,
                            BackgroundTransparency = 1,
                            Position = UDim2New(1, -38, 0, 0),
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.X,
                            TextSize = 14,
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        })  SubItems["PlayerName"]:AddToTheme({TextColor3 = "Text"})

                        SubItems["RealMessage"] = Instances:Create("Frame", {
                            Parent = SubItems["Message1"].Instance,
                            Name = "\0",
                            AnchorPoint = Vector2New(1, 0),
                            Position = UDim2New(1, -38, 0, 20),
                            BorderColor3 = FromRGB(0, 0, 0),
                            BorderSizePixel = 0,
                            ZIndex = 2,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            BackgroundColor3 = FromRGB(27, 25, 29)
                        })  SubItems["RealMessage"]:AddToTheme({BackgroundColor3 = "Background"})

                        Instances:Create("UISizeConstraint", {
                            Parent = SubItems["RealMessage"].Instance,
                            Name = "\0",
                            MaxSize = Vector2New(370, 75)
                        })

                        Instances:Create("UICorner", {
                            Parent = SubItems["RealMessage"].Instance,
                            Name = "\0",
                            CornerRadius = UDimNew(0, 4)
                        })

                        SubItems["MessageText"] = Instances:Create("TextLabel", {
                            Parent = SubItems["RealMessage"].Instance,
                            Name = "\0",
                            FontFace = Library.Font,
                            TextColor3 = FromRGB(240, 240, 240),
                            BorderColor3 = FromRGB(0, 0, 0),
                            Text = Message,
                            BackgroundTransparency = 1,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            ZIndex = 2,
                            TextWrapped = true,
                            TextSize = 14,
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        })  SubItems["MessageText"]:AddToTheme({TextColor3 = "Text"})

                        Instances:Create("UIPadding", {
                            Parent = SubItems["RealMessage"].Instance,
                            Name = "\0",
                            PaddingTop = UDimNew(0, 10),
                            PaddingBottom = UDimNew(0, 10),
                            PaddingRight = UDimNew(0, 10),
                            PaddingLeft = UDimNew(0, 10)
                        })

                        SubItems["Avatar"] = Instances:Create("ImageLabel", {
                            Parent = SubItems["Message1"].Instance,
                            Name = "\0",
                            BorderColor3 = FromRGB(0, 0, 0),
                            AnchorPoint = Vector2New(1, 0.5),
                            Image = Avatar,
                            ZIndex = 2,
                            BackgroundTransparency = 1,
                            Position = UDim2New(1, 0, 0.5, 0),
                            Size = UDim2New(0, 30, 0, 30),
                            BorderSizePixel = 0,
                            BackgroundColor3 = FromRGB(255, 255, 255)
                        })

                        Instances:Create("UICorner", {
                            Parent = SubItems["Avatar"].Instance,
                            Name = "\0",
                            CornerRadius = UDimNew(0, 4)
                        })
                    end
                end
            end

            Items["SendButton"]:Connect("MouseButton1Down", function()
                if GlobalChat:GetTypedMessage() == "" then
                    return
                end
                
                OnMessagePressed()
            end)

            Items["Messages"]:Connect("ChildAdded", function()
                task.wait()
                Items["Messages"]:Tween(nil, {CanvasPosition = Vector2New(0, Items["Messages"].Instance.AbsoluteCanvasSize.Y - Items["Messages"].Instance.AbsoluteSize.Y)})
            end)

            for Index, Value in Items["GlobalChat"].Instance:GetDescendants() do 
                if Value.ClassName:find("UI") then 
                    continue 
                end

                Value.ZIndex = 2
            end

            Items["GlobalChat"].Instance.ZIndex = 2
            Items["SendIcon"].Instance.ZIndex = 3

            return GlobalChat 
        end

        Library.Pages.Section = function(self, Data)
            Data = Data or { }

            local Section = {
                Window = self.Window,
                Page = self,

                Name = Data.Name or Data.name or "Section",
                Description = Data.Description or Data.Description or "",
                Icon = Data.Icon or Data.icon or "123944728972740",
                Side = Data.Side or Data.side or 1,
                EnableToggle = Data.EnableToggle or Data.enabletoggle or false,

                Items = { },
                IsActive = true,
                Elements = { }
            }

            local Items = { } do
                Items["Section"] = Instances:Create("Frame", {
                    Parent = Section.Page.ColumnsData[Section.Side].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 0.25,
                    ClipsDescendants = true,
                    BorderSizePixel = 0,
                    Size = UDim2New(1, 0, 0, 45),
                    ZIndex = 2,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = FromRGB(29, 28, 32)
                })  Items["Section"]:AddToTheme({BackgroundColor3 = "Section Background 2"})
                
                Items["Top"] = Instances:Create("Frame", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 0.6499999761581421,
                    Size = UDim2New(1, 0, 0, 64),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(31, 31, 36)
                })  Items["Top"]:AddToTheme({BackgroundColor3 = "Outline"})
                
                Items["TopBackground"] = Instances:Create("Frame", {
                    Parent = Items["Top"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 0.6499999761581421,
                    Position = UDim2New(0, 1, 0, 1),
                    Size = UDim2New(1, -2, 1, -2),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(26, 26, 30)
                })  Items["TopBackground"]:AddToTheme({BackgroundColor3 = "Section Top"})
                
                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["TopBackground"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 21, 0, 20),
                    AnchorPoint = Vector2New(0, 0.5),
                    Image = "rbxassetid://"..Section.Icon,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 15, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["Icon"].Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(131, 131, 131)), RGBSequenceKeypoint(1, FromRGB(255, 255, 255))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})
                
                Items["Description"] = Instances:Create("TextLabel", {
                    Parent = Items["TopBackground"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(183, 183, 183),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Section.Description,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 50, 0, 28),
                    BorderSizePixel = 0,
                    TextTransparency = 0.4,
                    ZIndex = 2,
                    TextSize = 15,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Description"]:AddToTheme({TextColor3 = "Text"})
                
                Instances:Create("UICorner", {
                    Parent = Items["TopBackground"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Items["Title"] = Instances:Create("TextLabel", {
                    Parent = Items["TopBackground"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(248, 248, 248),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Section.Name,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,

                    Position = (Section.Description == "") and UDim2New(0, 50, 0, 19) or UDim2New(0, 50, 0, 10),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 15,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Title"]:AddToTheme({TextColor3 = "Text"})
                
                Items["Toggle"] = Instances:Create("TextButton", {
                    Parent = Items["Top"].Instance,
                    Name = "\0",
                    Active = false,

                    Visible = Section.EnableToggle,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0.5),
                    Selectable = false,
                    Position = UDim2New(1, -15, 0.5, 0),
                    Size = UDim2New(0, 26, 0, 16),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Circle"] = Instances:Create("Frame", {
                    Parent = Items["Toggle"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0.5),
                    Position = UDim2New(1, -4, 0.5, 0),
                    Size = UDim2New(0, 8, 0, 8),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Circle"]:AddToTheme({BackgroundColor3 = "Text"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Circle"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 99999)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Toggle"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 9)
                })
                
                Items["Gradient"] = Instances:Create("UIGradient", {
                    Parent = Items["Toggle"].Instance,
                    Name = "\0",
                    Rotation = -115,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))}
                })  Items["Gradient"]:AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})
                
                Instances:Create("UICorner", {
                    Parent = Items["Top"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Items["Fill"] = Instances:Create("Frame", {
                    Parent = Items["Top"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 1, 1, -4),
                    Size = UDim2New(1, -2, 0, 4),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(26, 26, 30)
                })  Items["Fill"]:AddToTheme({BackgroundColor3 = "Section Background"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Fill"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Items["TopFills"] = Instances:Create("Frame", {
                    Parent = Items["Top"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 1),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 1, 0),
                    Size = UDim2New(1, 0, 0, 3),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  
                
                Items["Right1"] = Instances:Create("Frame", {
                    Parent = Items["TopFills"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    BackgroundTransparency = 0.6499999761581421,
                    Position = UDim2New(1, -1, 0, 0),
                    Size = UDim2New(0, 1, 0, 1),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(26, 26, 30)
                })  Items["Right1"]:AddToTheme({BackgroundColor3 = "Section Background"})
                
                Items["Right2"] = Instances:Create("Frame", {
                    Parent = Items["TopFills"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    BackgroundTransparency = 0.6499999761581421,
                    Position = UDim2New(1, -1, 0, 1),
                    Size = UDim2New(0, 1, 0, 1),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(26, 26, 30)
                })  Items["Right2"]:AddToTheme({BackgroundColor3 = "Section Background"})
                
                Items["Right3"] = Instances:Create("Frame", {
                    Parent = Items["TopFills"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    BackgroundTransparency = 0.6499999761581421,
                    Position = UDim2New(1, -2, 0, 1),
                    Size = UDim2New(0, 1, 0, 1),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(26, 26, 30)
                })  Items["Right3"]:AddToTheme({BackgroundColor3 = "Section Background"})
                
                Items["Left1"] = Instances:Create("Frame", {
                    Parent = Items["TopFills"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    BackgroundTransparency = 0.6499999761581421,
                    Position = UDim2New(0, 2, 0, 0),
                    Size = UDim2New(0, 1, 0, 1),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(26, 26, 30)
                })  Items["Left1"]:AddToTheme({BackgroundColor3 = "Section Background"})
                
                Items["Left2"] = Instances:Create("Frame", {
                    Parent = Items["TopFills"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    BackgroundTransparency = 0.6499999761581421,
                    Position = UDim2New(0, 2, 0, 1),
                    Size = UDim2New(0, 1, 0, 1),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(26, 26, 30)
                })  Items["Left2"]:AddToTheme({BackgroundColor3 = "Section Background"})
                
                Items["Left3"] = Instances:Create("Frame", {
                    Parent = Items["TopFills"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    BackgroundTransparency = 0.6499999761581421,
                    Position = UDim2New(0, 3, 0, 1),
                    Size = UDim2New(0, 1, 0, 1),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(26, 26, 30)
                })  Items["Left3"]:AddToTheme({BackgroundColor3 = "Section Background"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Items["Background"] = Instances:Create("Frame", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 0.6499999761581421,
                    Position = UDim2New(0, 1, 0, 64),
                    Size = UDim2New(1, -2, 1, -65),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(24, 22, 25)
                })  Items["Background"]:AddToTheme({BackgroundColor3 = "Section Background"})
                
                Items["Content"] = Instances:Create("Frame", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 12, 0, 15),
                    Size = UDim2New(1, -24, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["Content"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 12),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })                

                Items["Fade"] = Instances:Create("TextButton", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 0, 10, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutoButtonColor = false,
                    Visible = false,
                    Text = "",
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(24, 22, 25)
                })  Items["Fade"]:AddToTheme({BackgroundColor3 = "Section Background"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Fade"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })                

                Instances:Create("UIPadding", {
                    Parent = Items["Content"].Instance,
                    Name = "\0",
                    PaddingBottom = UDimNew(0, 10)
                })

                Section.Items = Items
            end

            function Section:ToggleBackground()
                Section.IsActive = not Section.IsActive

                if not Section.IsActive then 
                    Items["Fade"].Instance.Visible = true
                    Items["Fade"]:Tween(nil, {BackgroundTransparency = 0.3})
    
                    Items["Gradient"].Instance.Enabled = false
                    Items["Toggle"]:ChangeItemTheme({BackgroundColor3 = "Element"})
                    Items["Toggle"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                    Items["Circle"]:Tween(nil, {AnchorPoint = Vector2New(0, 0.5), Position = UDim2New(0, 4, 0.5, 0), BackgroundColor3 = Library.Theme.Text, BackgroundTransparency = 0.6})
                else
                    Items["Fade"]:Tween(nil, {BackgroundTransparency = 1})
                    task.spawn(function() 
                        task.wait(Library.Tween.Time)
                        Items["Fade"].Instance.Visible = false
                    end)

                    Items["Gradient"].Instance.Enabled = true
                    Items["Toggle"]:ChangeItemTheme({BackgroundColor3 = "Text"})
                    Items["Toggle"]:Tween(nil, {BackgroundColor3 = Library.Theme.Text})
                    Items["Circle"]:Tween(nil, {AnchorPoint = Vector2New(1, 0.5), Position = UDim2New(1, -4, 0.5, 0), BackgroundColor3 = Library.Theme.Text, BackgroundTransparency = 0})
                end
            end

            Library:Connect(Items["Content"].Instance.Changed, function(Property)
                if Property == "AbsoluteSize" then
                    Items["Fade"].Instance.Size = UDim2New(1, 0, 0, Items["Content"].Instance.AbsoluteSize.Y + 10)
                end
            end)

            function Section:TweenElements(Bool, Debounce)
                local yieldInt = Library.RenderYieldInterval or 0.03
                for Index, Value in Section.Elements do
                    if type(Value.RefreshPosition) == "function" then
                        Value:RefreshPosition(Bool)
                    end
                    if not Debounce and Index % 30 == 0 then 
                        task.wait(yieldInt)
                    end
                end
            end

            Items["Toggle"]:Connect("MouseButton1Down", function()
                Section:ToggleBackground()
            end)

            Section.Page.Sections[Section.Name] = Section

            return setmetatable(Section, Library.Sections)
        end

        Library.Sections.Toggle = function(self, Data)
            Data = Data or { }
            
            local Toggle = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Toggle",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or false,
                Callback = Data.Callback or Data.callback or function() end,

                Value = false
            }

            local Items = { } do 
                Items["Toggle"] = Instances:Create("TextButton", {
                    Parent = Toggle.Section.Items["Content"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2New(1, 0, 0, 24),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Indicator"] = Instances:Create("Frame", {
                    Parent = Items["Toggle"].Instance,
                    Name = "\0",
                    Size = UDim2New(0, 24, 0, 24),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(124, 163, 255)
                })  Items["Indicator"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Indicator"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 3)
                })
                
                Items["Accent"] = Instances:Create("Frame", {
                    Parent = Items["Indicator"].Instance,
                    Name = "\0",
                    Size = UDim2New(0, 0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Position = UDim2New(0.5, 0, 0.5, 0)
                })

                Instances:Create("UICorner", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 3)
                })

                Items["CheckImage"] = Instances:Create("ImageLabel", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 0, 0, 0),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "rbxassetid://121760666525660",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    ImageTransparency = 1,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["CheckImage"]:AddToTheme({ImageColor3 = "Text"})
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Toggle"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.30000001192092896,
                    Text = Toggle.Name,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    Position = UDim2New(0, 24, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

                Items["Gradient"] = Instances:Create("UIGradient", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    Enabled = true,
                    Rotation = -115,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))}
                })  Items["Gradient"]:AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})

                Items["Toggle"]:OnHover(function()
                    Items["Indicator"]:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(0, 21, 0, 21), Position = UDim2New(0, -3, 0, -3)})
                end)

                Items["Toggle"]:OnHoverLeave(function()
                    Items["Indicator"]:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(0, 18, 0, 18), Position = UDim2New(0, 0, 0, 0)})
                end)
            end

                Items["Indicator"].Instance.Position = UDim2New(0, 60, 0, 0)
            Items["Text"].Instance.Position = UDim2New(0, 84, 0, 0)

            Toggle.SubColorpickerCount = 0
            local function GetRightContainer()
                if not Items["RightContainer"] then
                    Items["RightContainer"] = Instances:Create("Frame", {
                        Parent = Items["Toggle"].Instance,
                        Name = "\0",
                        AnchorPoint = Vector2New(1, 0.5),
                        Position = UDim2New(1, -10, 0.5, 0),
                        Size = UDim2New(0, 0, 0, 18),
                        AutomaticSize = Enum.AutomaticSize.X,
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1
                    })
                    Instances:Create("UIListLayout", {
                        Parent = Items["RightContainer"].Instance,
                        Name = "\0",
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalAlignment = Enum.HorizontalAlignment.Right,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDimNew(0, 6),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })
                    Instances:Create("UIPadding", {
                        Parent = Items["RightContainer"].Instance,
                        Name = "\0",
                        PaddingRight = UDimNew(0, 4),
                        PaddingLeft = UDimNew(0, 4)
                    })
                end
                return Items["RightContainer"]
            end

            function Toggle:SubKeybind(Data)
                Data = Data or { }
                local SubKeybind = {
                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Enum.KeyCode.RightShift,
                    DefaultMode = Data.Mode or Data.mode or Data.DefaultMode or Data.defaultMode or "Toggle",
                    Key = "",
                    Value = "None",
                    Mode = "Toggle",
                    ToggleRef = Toggle,
                    Picking = false,
                    ModeMenuOpen = false
                }
                SubKeybind.Mode = SubKeybind.DefaultMode
                local SubKeybindItems = { }
                local KeyListItem
                if Library.KeyList then KeyListItem = Library.KeyList:Add(Toggle.Name, "None") end
                local function UpdateKeyList()
                    if KeyListItem then
                        KeyListItem:Set(Toggle.Name, SubKeybind.Value)
                        KeyListItem:SetStatus(Toggle.Value)
                    end
                end
                local RightContainer = GetRightContainer()
                SubKeybindItems["Container"] = Instances:Create("Frame", {
                    Parent = RightContainer.Instance,
                    Name = "\0",
                    Size = UDim2New(0, 55, 0, 16),
                    LayoutOrder = 999,
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 26, 29)
                })  SubKeybindItems["Container"]:AddToTheme({BackgroundColor3 = "Element"})
                Instances:Create("UICorner", { Parent = SubKeybindItems["Container"].Instance, Name = "\0", CornerRadius = UDimNew(0, 4) })
                SubKeybindItems["KeyButton"] = Instances:Create("TextButton", {
                    Parent = SubKeybindItems["Container"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.30000001192092896,
                    Text = "None",
                    AutoButtonColor = false,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  SubKeybindItems["KeyButton"]:AddToTheme({TextColor3 = "Text"})
                local ModeMenuFrame = Instances:Create("Frame", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    Visible = false,
                    ClipsDescendants = false,
                    Size = UDim2New(0, 55, 0, 44),
                    Position = UDim2New(0, 0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 500,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 26, 29)
                })  ModeMenuFrame:AddToTheme({BackgroundColor3 = "Element"})
                Instances:Create("UICorner", { Parent = ModeMenuFrame.Instance, Name = "\0", CornerRadius = UDimNew(0, 4) })
                Instances:Create("UIListLayout", {
                    Parent = ModeMenuFrame.Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 2),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Top
                })
                Instances:Create("UIPadding", {
                    Parent = ModeMenuFrame.Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 3),
                    PaddingBottom = UDimNew(0, 3),
                    PaddingLeft = UDimNew(0, 4),
                    PaddingRight = UDimNew(0, 4)
                })
                local TweenInfoHover = TweenInfo.new(Library.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                local AccentColor = Library.Theme.Accent or FromRGB(255, 80, 80)
                local function CreateModeOption(Name, IsSelected)
                    local Row = Instances:Create("TextButton", {
                        Parent = ModeMenuFrame.Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = IsSelected and FromRGB(240, 240, 240) or FromRGB(160, 160, 165),
                        Text = "",
                        AutoButtonColor = false,
                        Size = UDim2New(1, -8, 0, 16),
                        BorderSizePixel = 0,
                        ZIndex = 501,
                        TextSize = 12,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundColor3 = FromRGB(0, 0, 0),
                        BackgroundTransparency = 1
                    })
                    Row.Instance.LayoutOrder = Name == "Toggle" and 0 or 1
                    local CircleContainer = Instances:Create("Frame", {
                        Parent = Row.Instance,
                        Name = "\0",
                        Size = UDim2New(0, 14, 0, 16),
                        Position = UDim2New(0, 0, 0, 0),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1
                    })
                    local Circle = Instances:Create("Frame", {
                        Parent = CircleContainer.Instance,
                        Name = "\0",
                        Size = UDim2New(0, 5, 0, 5),
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Position = UDim2New(0.5, 0, 0.5, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 502,
                        BorderSizePixel = 0,
                        BackgroundColor3 = AccentColor,
                        BackgroundTransparency = IsSelected and 0 or 1
                    })
                    Instances:Create("UICorner", { Parent = Circle.Instance, Name = "\0", CornerRadius = UDimNew(1, 0) })
                    local CircleStroke = Instances:Create("UIStroke", {
                        Parent = Circle.Instance,
                        Name = "\0",
                        Color = AccentColor,
                        Thickness = 1,
                        Transparency = IsSelected and 1 or 0
                    })
                    local Label = Instances:Create("TextLabel", {
                        Parent = Row.Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = IsSelected and FromRGB(240, 240, 240) or FromRGB(160, 160, 165),
                        Text = Name,
                        Size = UDim2New(1, -18, 0, 16),
                        Position = UDim2New(0, 14, 0, 0),
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextSize = 12,
                        ZIndex = 502
                    })
                    Row:OnHover(function()
                        Label:Tween(TweenInfoHover, {TextColor3 = FromRGB(255, 255, 255)})
                    end)
                    Row:OnHoverLeave(function()
                        local active = (Name == "Toggle" and SubKeybind.Mode == "Toggle") or (Name == "Hold" and SubKeybind.Mode == "Hold")
                        Label:Tween(TweenInfoHover, {TextColor3 = active and FromRGB(240, 240, 240) or FromRGB(160, 160, 165)})
                    end)
                    return { Row = Row, Circle = Circle, CircleStroke = CircleStroke, Label = Label }
                end
                local MenuToggle = CreateModeOption("Toggle", SubKeybind.Mode == "Toggle")
                local MenuHold = CreateModeOption("Hold", SubKeybind.Mode == "Hold")
                local function UpdateModeVisuals()
                    local toggleSel = SubKeybind.Mode == "Toggle"
                    local holdSel = SubKeybind.Mode == "Hold"
                    MenuToggle.Circle.Instance.BackgroundTransparency = toggleSel and 0 or 1
                    MenuToggle.CircleStroke.Instance.Transparency = toggleSel and 1 or 0
                    MenuToggle.Label.Instance.TextColor3 = toggleSel and FromRGB(240, 240, 240) or FromRGB(160, 160, 165)
                    MenuHold.Circle.Instance.BackgroundTransparency = holdSel and 0 or 1
                    MenuHold.CircleStroke.Instance.Transparency = holdSel and 1 or 0
                    MenuHold.Label.Instance.TextColor3 = holdSel and FromRGB(240, 240, 240) or FromRGB(160, 160, 165)
                end
                local function CloseModeMenu()
                    if not SubKeybind.ModeMenuOpen then return end
                    SubKeybind.ModeMenuOpen = false
                    ModeMenuFrame.Instance.Visible = false
                    ModeMenuFrame.Instance.Parent = Library.UnusedHolder.Instance
                end
                local function SetMode(Mode)
                    SubKeybind.Mode = Mode
                    UpdateModeVisuals()
                    Library.Flags[SubKeybind.Flag] = { Key = SubKeybind.Key, Mode = SubKeybind.Mode }
                end
                MenuToggle.Row:Connect("MouseButton1Click", function()
                    SetMode("Toggle")
                    CloseModeMenu()
                end)
                MenuHold.Row:Connect("MouseButton1Click", function()
                    SetMode("Hold")
                    CloseModeMenu()
                end)
                local function OpenModeMenu()
                    if SubKeybind.ModeMenuOpen then CloseModeMenu() return end
                    SubKeybind.ModeMenuOpen = true
                    ModeMenuFrame.Instance.Parent = Library.Holder.Instance
                    ModeMenuFrame.Instance.Visible = true
                    local ContainerPos = SubKeybindItems["Container"].Instance.AbsolutePosition
                    local ContainerSize = SubKeybindItems["Container"].Instance.AbsoluteSize
                    ModeMenuFrame.Instance.Position = UDim2New(0, ContainerPos.X + ContainerSize.X - 55, 0, ContainerPos.Y + ContainerSize.Y + 4)
                end
                SubKeybindItems["Container"]:Connect("InputBegan", function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton2 then OpenModeMenu() end
                end)
                SubKeybindItems["KeyButton"]:Connect("InputBegan", function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton2 then OpenModeMenu() end
                end)
                Library:Connect(UserInputService.InputBegan, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.MouseButton2 or Input.UserInputType == Enum.UserInputType.Touch then
                        if SubKeybind.ModeMenuOpen and not Library:IsMouseOverFrame(ModeMenuFrame) and not Library:IsMouseOverFrame(SubKeybindItems["Container"]) then
                            CloseModeMenu()
                        end
                    end
                end)
                local function UpdateKeyDisplay()
                    local KeyStr = Keys[SubKeybind.Key] or StringGSub(StringGSub(tostring(SubKeybind.Key), "Enum%.KeyCode%.", ""), "Enum%.UserInputType%.", "") or "None"
                    SubKeybind.Value = KeyStr
                    SubKeybindItems["KeyButton"].Instance.Text = KeyStr
                end
                local function SetKey(Key)
                    if StringFind(tostring(Key), "Enum") then
                        SubKeybind.Key = tostring(Key)
                        local KeyName
                        if type(Key) == "string" then
                            KeyName = Key:match("[^%.]+$") or "None"
                            if KeyName == "Backspace" then KeyName = "None" end
                        else
                            KeyName = Key.Name == "Backspace" and "None" or Key.Name
                        end
                        local KeyStr = Keys[SubKeybind.Key] or StringGSub(StringGSub(KeyName or "", "KeyCode%.", ""), "UserInputType%.", "") or KeyName or "None"
                        SubKeybind.Value = KeyStr
                        SubKeybindItems["KeyButton"].Instance.Text = KeyStr
                        Library.Flags[SubKeybind.Flag] = { Key = SubKeybind.Key, Mode = SubKeybind.Mode }
                        SubKeybind.Picking = false
                        UpdateKeyList()
                    end
                end
                SubKeybindItems["KeyButton"]:Connect("MouseButton1Click", function()
                    SubKeybind.Picking = true
                    SubKeybindItems["KeyButton"].Instance.Text = "..."
                    local InputBegan
                    InputBegan = UserInputService.InputBegan:Connect(function(Input)
                        if Input.UserInputType == Enum.UserInputType.Keyboard then
                            SetKey(Input.KeyCode)
                        else
                            SetKey(Input.UserInputType)
                        end
                        if InputBegan then InputBegan:Disconnect() InputBegan = nil end
                    end)
                end)
                Library:Connect(UserInputService.InputBegan, function(Input)
                    if SubKeybind.Value == "None" or SubKeybind.Picking then return end
                    if tostring(Input.KeyCode) == SubKeybind.Key or tostring(Input.UserInputType) == SubKeybind.Key then
                        if SubKeybind.Mode == "Toggle" then
                            Toggle:Set(not Toggle.Value)
                        elseif SubKeybind.Mode == "Hold" then
                            Toggle:Set(true)
                        end
                    end
                end)
                Library:Connect(UserInputService.InputEnded, function(Input)
                    if SubKeybind.Value == "None" then return end
                    if SubKeybind.Mode == "Hold" and (tostring(Input.KeyCode) == SubKeybind.Key or tostring(Input.UserInputType) == SubKeybind.Key) then
                        Toggle:Set(false)
                    end
                end)
                if SubKeybind.Default then
                    SetKey(SubKeybind.Default)
                end
                SetMode(SubKeybind.DefaultMode)
                Library.SetFlags[SubKeybind.Flag] = function(Value)
                    if Value and type(Value) == "table" then
                        if Value.Key then SetKey(Value.Key) end
                        if Value.Mode == "Toggle" or Value.Mode == "Hold" then SetMode(Value.Mode) end
                    elseif Value and StringFind(tostring(Value), "Enum") then
                        SetKey(Value)
                    end
                end
                function SubKeybind:Get() return SubKeybind.Key, SubKeybind.Value, SubKeybind.Mode end
                function SubKeybind:Set(Key) SetKey(Key) end
                function SubKeybind:SetMode(Mode) SetMode(Mode) end
                SubKeybind.UpdateKeyList = UpdateKeyList
                Toggle.SubKeybindRef = SubKeybind
                return SubKeybind
            end

            function Toggle:Get()
                return Toggle.Value 
            end

            function Toggle:Set(Value)
                Toggle.Value = Value 
                Library.Flags[Toggle.Flag] = Value 

                if Toggle.Value then 
                    Items["Accent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Size = UDim2New(1, 0, 1, 0)})
                    Items["CheckImage"]:Tween(nil, {ImageTransparency = 0, Size = UDim2New(0, 10, 0, 9)})

                else
                    Items["Accent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.05, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Size = UDim2New(0, 0, 0, 0)})
                    Items["CheckImage"]:Tween(nil, {ImageTransparency = 1, Size = UDim2New(0, 0, 0, 0)})

                end

                if Toggle.Callback then 
                    Library:SafeCall(Toggle.Callback, Toggle.Value)
                end
                
                if Toggle.SubKeybindRef and Toggle.SubKeybindRef.UpdateKeyList then
                    Toggle.SubKeybindRef.UpdateKeyList()
                end
            end

            local SettingsItem = { }

            function Toggle:Settings(Size)
                local Settings = {
                    IsOpen = false,
                    Name = "",
                    Items = { },
                    IsSettings = true,
                    Elements = { } 
                }
                Toggle.Settings = Settings

                SettingsItem = { } do 
                    SettingsItem["Settings"] = Instances:Create("Frame", {
                        Parent = Library.UnusedHolder.Instance,
                        Name = "\0",
                        Visible = false,
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(0.5, 0.5),
                        BorderSizePixel = 0,
                        Position = UDim2New(0.8949604630470276, 0, 0.2945185601711273, 0),
                        Size = UDim2New(0, 245, 0, 159),
                        ZIndex = 2,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        BackgroundColor3 = FromRGB(21, 21, 24)
                    })  SettingsItem["Settings"]:AddToTheme({BackgroundColor3 = "Background"})

                    Instances:Create("UICorner", {
                        Parent = SettingsItem["Settings"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 6)
                    })                    

                    SettingsItem["SettingsIcon"] = Instances:Create("ImageLabel", {
                        Parent = Items["Text"].Instance,
                        Name = "\0",
                        ImageColor3 = FromRGB(141, 141, 150),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Size = UDim2New(0, 14, 0, 14),
                        AnchorPoint = Vector2New(0, 0.5),
                        Image = "rbxassetid://101500482366184",
                        BackgroundTransparency = 1,
                        Position = UDim2New(1, 6, 0.5, 1),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  Items["SettingsIcon"] = SettingsItem["SettingsIcon"]

                    SettingsItem["Content"] = Instances:Create("ScrollingFrame", {
                        Parent = SettingsItem["Settings"].Instance,
                        Name = "\0",
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        Selectable = false,
                        Size = UDim2New(1, -8, 1, -46),
                        Position = UDim2New(0, 4, 0, 4),
                        ScrollBarThickness = 2,
                        BackgroundColor3 = FromRGB(255, 255, 255),
                        BorderColor3 = FromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        CanvasSize = UDim2New(0, 0, 0, 0)
                    })  SettingsItem["Content"]:AddToTheme({ScrollBarImageColor3 = "Accent"})
                    
                    Instances:Create("UIListLayout", {
                        Parent = SettingsItem["Content"].Instance,
                        Name = "\0",
                        Padding = UDimNew(0, 4),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })
                    
                    Instances:Create("UIPadding", {
                        Parent = SettingsItem["Content"].Instance,
                        Name = "\0",
                        PaddingTop = UDimNew(0, 4),
                        PaddingBottom = UDimNew(0, 4),
                        PaddingRight = UDimNew(0, 4),
                        PaddingLeft = UDimNew(0, 4)
                    })

                    SettingsItem["Button"] = Instances:Create("TextButton", {
                        Parent = SettingsItem["Settings"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(0, 0, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        BorderSizePixel = 0,
                        Size = UDim2New(1, -16, 0, 32),
                        ZIndex = 2,
                        AnchorPoint = Vector2New(0, 1),
                        Position = UDim2New(0, 8, 1, -8),
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(27, 26, 29)
                    })  SettingsItem["Button"]:AddToTheme({BackgroundColor3 = "Element"})
    
                    SettingsItem["Accent"] = Instances:Create("Frame", {
                        Parent = SettingsItem["Button"].Instance,
                        Name = "\0",
                        Size = UDim2New(0, 0, 0, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        BackgroundColor3 = FromRGB(255, 255, 255),
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Position = UDim2New(0.5, 0, 0.5, 0)
                    })
    
                    SettingsItem["Gradient"] = Instances:Create("UIGradient", {
                        Parent = SettingsItem["Accent"].Instance,
                        Name = "\0",
                        Enabled = true,
                        Rotation = -115,
                        Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))}
                    })  SettingsItem["Gradient"]:AddToTheme({Color = function()
                        return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                    end})
    
                    Instances:Create("UICorner", {
                        Parent = SettingsItem["Accent"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 4)
                    })
                    
                    Instances:Create("UICorner", {
                        Parent = SettingsItem["Button"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 4)
                    })
                    
                    SettingsItem["Text"] = Instances:Create("TextLabel", {
                        Parent = SettingsItem["Button"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(240, 240, 240),
                        TextTransparency = 0.30000001192092896,
                        Text = "Close",
                        AutomaticSize = Enum.AutomaticSize.X,
                        Size = UDim2New(0, 0, 0, 15),
                        AnchorPoint = Vector2New(0.5, 0.5),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        Position = UDim2New(0.5, 0, 0.5, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  SettingsItem["Text"]:AddToTheme({TextColor3 = "Text"})   

                    SettingsItem["Button"]:OnHover(function()
                        SettingsItem["Accent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(1, 0, 1, 0), BackgroundTransparency = 0})
                    end)
    
                    SettingsItem["Button"]:OnHoverLeave(function()
                        SettingsItem["Accent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(0, 0, 0, 0), BackgroundTransparency = 1})
                    end)
                end

                local RenderStepped 
                local Debounce = false

                function Settings:SetOpen(Bool)
                    if Debounce then 
                        return
                    end
    
                    Settings.IsOpen = Bool
    
                    Debounce = true 
    
                    if Settings.IsOpen then 
                        task.spawn(function()
                            for Index, Value in Settings.Elements do
                                if type(Value.RefreshPosition) == "function" then
                                    Value:RefreshPosition(true)
                                end
                                task.wait(0.03)
                            end
                        end)

                        SettingsItem["Settings"].Instance.Visible = true
                        SettingsItem["Settings"].Instance.Parent = Library.Holder.Instance
                        
                        RenderStepped = RunService.RenderStepped:Connect(function()
                            SettingsItem["Settings"].Instance.Position = UDim2New(
                                0, Items["Toggle"].Instance.AbsolutePosition.X + Items["Toggle"].Instance.AbsoluteSize.X / 1.9 + 15, 
                                0, Items["Toggle"].Instance.AbsolutePosition.Y + Items["Toggle"].Instance.AbsoluteSize.Y + Size / 1.9)
                            SettingsItem["Settings"].Instance.Size = UDim2New(0, 245, 0, Size)
                        end)
    
                        for Index, Value in Library.OpenFrames do 
                            if Value ~= Settings then 
                                Value:SetOpen(false)
                            end
                        end
    
                        Library.OpenFrames[Settings] = Settings 
                    else
                        for Index, Value in Settings.Elements do
                            if type(Value.RefreshPosition) == "function" then
                                Value:RefreshPosition(false)
                            end
                        end

                        if Library.OpenFrames[Settings] then 
                            Library.OpenFrames[Settings] = nil
                        end
    
                        if RenderStepped then 
                            RenderStepped:Disconnect()
                            RenderStepped = nil
                        end
                    end
    
                    local Descendants = SettingsItem["Settings"].Instance:GetDescendants()
                    TableInsert(Descendants, SettingsItem["Settings"].Instance)
    
                    local NewTween
    
                    for Index, Value in Descendants do 
                        local TransparencyProperty = Tween:GetProperty(Value)
    
                        if not TransparencyProperty then
                            continue 
                        end
    
                        if not Value.ClassName:find("UI") then 
                            Value.ZIndex = Settings.IsOpen and 7 or 1
                        end
    
                        if type(TransparencyProperty) == "table" then 
                            for _, Property in TransparencyProperty do 
                                NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
                            end
                        else
                            NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
                        end
                    end
                    
                    NewTween.Tween.Completed:Connect(function()
                        Debounce = false 
                        SettingsItem["Settings"].Instance.Visible = Settings.IsOpen
                        task.wait(0.2)
                        SettingsItem["Settings"].Instance.Parent = not Settings.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
                    end)
                end

                SettingsItem["Button"]:Connect("MouseButton1Down", function()
                    Library:Notification({
                        Title = "System",
                        Description = "Unloading script...",
                        Duration = 2,
                        Icon = "87107896404147"
                    })
                    task.wait(0.5)
                    Library:Unload()
                end)

                SettingsItem["SettingsIcon"]:Connect("InputBegan", function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then 
                        Settings:SetOpen(not Settings.IsOpen)
                    end
                end)

                Library:Connect(UserInputService.InputBegan, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then 
                        if Library:IsMouseOverFrame(SettingsItem["Settings"]) then
                            return 
                        end

                        Settings:SetOpen(false)
                    end
                end)

                Settings.Items = SettingsItem

                setmetatable(Settings, Library.Sections)
                return Settings
            end

            function Toggle:SetVisibility(Bool)
                Items["Toggle"].Instance.Visible = Bool 
            end

            function Toggle:Colorpicker(Data)
                Data = Data or { }

                local Colorpicker = {
                    Window = Toggle.Window,
                    Page = Toggle.Page,
                    Section = Toggle.Section,

                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
                    Callback = Data.Callback or Data.callback or function() end,
                    Alpha = Data.Alpha or Data.alpha or false
                }

                if not Items["SubElements"] then
                    Items["SubElements"] = Instances:Create("Frame", {
                        Parent = Toggle.Section.Items["Content"].Instance,
                        Name = "\0",
                        Size = UDim2New(1, 0, 0, 30),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(27, 26, 29)
                    })  Items["SubElements"]:AddToTheme({BackgroundColor3 = "Element"})
                    Instances:Create("UICorner", { Parent = Items["SubElements"].Instance, Name = "\0", CornerRadius = UDimNew(0, 5) })
                    Instances:Create("UIListLayout", {
                        Parent = Items["SubElements"].Instance,
                        Name = "\0",
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        FillDirection = Enum.FillDirection.Horizontal,
                        Padding = UDimNew(0, 5),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })
                    Instances:Create("UIPadding", {
                        Parent = Items["SubElements"].Instance,
                        Name = "\0",
                        PaddingLeft = UDimNew(0, 6)
                    })
                end

                local NewColorpicker, ColorpickerItems = Library:CreateColorpicker({
                    Parent = Items["SubElements"],
                    Page = Colorpicker.Page,
                    Section = Colorpicker.Section,
                    Flag = Colorpicker.Flag,
                    Default = Colorpicker.Default,
                    Callback = Colorpicker.Callback,
                    Alpha = Colorpicker.Alpha
                })

                return NewColorpicker
            end

            function Toggle:SubColorpicker(Data)
                Data = Data or { }
                if Toggle.SubColorpickerCount >= 7 then return nil end
                Toggle.SubColorpickerCount = Toggle.SubColorpickerCount + 1
                local RightContainer = GetRightContainer()
                local Wrapper = Instances:Create("Frame", {
                    Parent = RightContainer.Instance,
                    Name = "\0",
                    Size = UDim2New(0, 14, 0, 18),
                    LayoutOrder = Toggle.SubColorpickerCount - 1,
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1
                })
                local ColorBoxHolder = Instances:Create("Frame", {
                    Parent = Wrapper.Instance,
                    Name = "\0",
                    Size = UDim2New(0, 14, 0, 14),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1
                })
                local DummySection = { IsSettings = false }
                local NewColorpicker = Library:CreateColorpicker({
                    Parent = ColorBoxHolder,
                    Page = Toggle.Page,
                    Section = DummySection,
                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
                    Callback = Data.Callback or Data.callback or function() end,
                    Alpha = Data.Alpha or Data.alpha or false,
                    Compact = true,
                    LayoutOrder = 0
                })
                return NewColorpicker
            end

            function Toggle:Keybind(Data)
                Data = Data or { }

                local Keybind = {
                    Window = Toggle.Window,
                    Page = Toggle.Page,
                    Section = Toggle.Section,

                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Enum.KeyCode.E,
                    Callback = Data.Callback or Data.callback or function(Value) Toggle:Set(Value) end,
                    Mode = Data.Mode or Data.mode or "Toggle"
                }

                if not Items["SubElements"] then
                    Items["SubElements"] = Instances:Create("Frame", {
                        Parent = Toggle.Section.Items["Content"].Instance,
                        Name = "\0",
                        Size = UDim2New(1, 0, 0, 30),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(27, 26, 29)
                    })  Items["SubElements"]:AddToTheme({BackgroundColor3 = "Element"})
                    Instances:Create("UICorner", { Parent = Items["SubElements"].Instance, Name = "\0", CornerRadius = UDimNew(0, 5) })
                    Instances:Create("UIListLayout", {
                        Parent = Items["SubElements"].Instance,
                        Name = "\0",
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        FillDirection = Enum.FillDirection.Horizontal,
                        Padding = UDimNew(0, 5),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })
                    Instances:Create("UIPadding", {
                        Parent = Items["SubElements"].Instance,
                        Name = "\0",
                        PaddingLeft = UDimNew(0, 6)
                    })
                end

                local NewKeybind, KeybindItems = Library:CreateKeybind({
                    Parent = Items["SubElements"],
                    Page = Keybind.Page,
                    Section = Keybind.Section,
                    Flag = Keybind.Flag,
                    Default = Keybind.Default,
                    Mode = Keybind.Mode,
                    Callback = Keybind.Callback
                })

                return NewKeybind
            end

            function Toggle:RefreshPosition(Bool)
                if Bool then 
                    Items["Indicator"].Instance.Position = UDim2New(0, 0, 0, 0)
                    Items["Text"].Instance.Position = UDim2New(0, 24, 0, 0)
                else
                    Items["Indicator"].Instance.Position = UDim2New(0, 60, 0, 0)
                    Items["Text"].Instance.Position = UDim2New(0, 84, 0, 0)
                end 
            end

            Items["Toggle"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then 
                    if Items["SettingsIcon"] and Library:IsMouseOverFrame(Items["SettingsIcon"]) then
                        return 
                    end
                    
                    Toggle:Set(not Toggle.Value)
                end
            end)

            Library.FlagDefaults[Toggle.Flag] = Toggle.Default
            Toggle:Set(Toggle.Default)

            Library.SetFlags[Toggle.Flag] = function(Value)
                Toggle:Set(Value)
            end

            Toggle.Section.Elements[#Toggle.Section.Elements+1] = Toggle
            Toggle:RefreshPosition(true)

            return Toggle 
        end

        Library.Sections.Button = function(self, Data)
            Data = Data or { }

            local Button = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Button",
                Icon = Data.Icon or Data.icon or nil,
                Callback = Data.Callback or Data.callback or function() end
            }

            local Items = { } do 
                Items["Button"] = Instances:Create("TextButton", {
                    Parent = Button.Section.Items["Content"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BorderSizePixel = 0,
                    Size = UDim2New(1, 0, 0, 40),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundTransparency = 0,
                    BackgroundColor3 = FromRGB(27, 26, 29)
                })  Items["Button"]:AddToTheme({BackgroundColor3 = "Element"})

                Items["Accent"] = Instances:Create("Frame", {
                    Parent = Items["Button"].Instance,
                    Name = "\0",
                    Size = UDim2New(0, 0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Position = UDim2New(0.5, 0, 0.5, 0)
                })

                Items["Gradient"] = Instances:Create("UIGradient", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    Enabled = true,
                    Rotation = -115,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))}
                })  Items["Gradient"]:AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})

                Instances:Create("UICorner", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Button"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Button"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.30000001192092896,
                    Text = Button.Name,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})          
                
                if Button.Icon then 
                    Items["Icon"] = Instances:Create("ImageLabel", {
                        Parent = Items["Text"].Instance,
                        Name = "\0",
                        ImageColor3 = FromRGB(240, 240, 240),
                        ImageTransparency = 0.30000001192092896,
                        BorderColor3 = FromRGB(0, 0, 0),
                        Size = UDim2New(0, 18, 0, 18),
                        AnchorPoint = Vector2New(1, 0.5),
                        Image = "rbxassetid://"..Button.Icon,
                        BackgroundTransparency = 1,
                        Position = UDim2New(0, -8, 0.5, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  Items["Icon"]:AddToTheme({ImageColor3 = "Text"})
                end                    

                Items["Button"]:OnHover(function()
                    Items["Accent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(1, 0, 1, 0), BackgroundTransparency = 0})
                end)

                Items["Button"]:OnHoverLeave(function()
                    Items["Accent"]:Tween(TweenInfo.new(Library.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(0, 0, 0, 0), BackgroundTransparency = 1})
                end)
            end 

            function Button:SetVisibility(Bool)
                Items["Button"].Instance.Visible = Bool
            end

            function Button:Press()
                if Items["Button"] and Items["Button"].Instance then
                    Items["Button"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
                    Items["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})
                end
                if Items["Text"] and Items["Text"].Instance then
                    Items["Text"]:Tween(nil, {TextColor3 = FromRGB(0, 0, 0), TextTransparency = 0})
                end
                if Button.Icon and Items["Icon"] and Items["Icon"].Instance then
                    Items["Icon"]:Tween(nil, {ImageColor3 = FromRGB(0, 0, 0), ImageTransparency = 0})
                end

                task.wait(0.2)

                Library:SafeCall(Button.Callback)

                if Items["Button"] and Items["Button"].Instance and Items["Button"].Instance.Parent then
                    Items["Button"]:ChangeItemTheme({BackgroundColor3 = "Element"})
                    Items["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                end
                if Items["Text"] and Items["Text"].Instance and Items["Text"].Instance.Parent then
                    Items["Text"]:Tween(nil, {TextColor3 = Library.Theme.Text, TextTransparency = 0.3})
                end
                if Button.Icon and Items["Icon"] and Items["Icon"].Instance and Items["Icon"].Instance.Parent then
                    Items["Icon"]:Tween(nil, {ImageColor3 = Library.Theme.Text, ImageTransparency = 0.3})
                end
            end

            Items["Button"]:Connect("MouseButton1Down", function()
                Button:Press()
            end)

            return Button
        end

        Library.Sections.Slider = function(self, Data)
            Data = Data or { }

            local Slider = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Slider",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Min = Data.Min or Data.min or 0,
                Default = Data.Default or Data.default or 0,
                Max = Data.Max or Data.max or 100,
                Suffix = Data.Suffix or Data.suffix or "",
                Decimals = Data.Decimals or Data.decimals or 1,
                Callback = Data.Callback or Data.callback or function() end,

                Value = 0,
                Sliding = false
            }

            local Items = { } do 
                Items["Slider"] = Instances:Create("Frame", {
                    Parent = Slider.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 53),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Slider"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.30000001192092896,
                    Text = Slider.Name,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

                Items["RealSlider"] = Instances:Create("TextButton", {
                    Parent = Items["Slider"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(0, 1),
                    BorderSizePixel = 0,
                    Position = UDim2New(0, 10, 1, -4),
                    Size = UDim2New(1, -20, 0, 12),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(27, 26, 29)
                })  Items["RealSlider"]:AddToTheme({BackgroundColor3 = "Element"})

                Instances:Create("UICorner", {
                    Parent = Items["RealSlider"].Instance,
                    Name = "\0"
                })

                Items["Accent"] = Instances:Create("Frame", {
                    Parent = Items["RealSlider"].Instance,
                    Name = "\0",
                    Size = UDim2New(0.5, 0, 1, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UICorner", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0"
                })

                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 16, 0, 12),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "rbxassetid://117786983271442",
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, 5, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UIGradient", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    Rotation = -102,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(166, 166, 166))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})

                Items["Plus"] = Instances:Create("TextButton", {
                    Parent = Items["RealSlider"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.30000001192092896,
                    Text = "+",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(0, 20, 0, 20),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, 0, 0.5, -3),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Plus"]:AddToTheme({TextColor3 = "Text"})

                Items["Minus"] = Instances:Create("TextButton", {
                    Parent = Items["RealSlider"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.30000001192092896,
                    Text = "-",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0.5),
                    Size = UDim2New(0, 20, 0, 20),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, -2, 0.5, -2),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Minus"]:AddToTheme({TextColor3 = "Text"})

                Items["Value"] = Instances:Create("TextLabel", {
                    Parent = Items["Slider"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.30000001192092896,
                    Text = "50%",
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    AnchorPoint = Vector2New(1, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, 0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Value"]:AddToTheme({TextColor3 = "Text"})

                Items["RealSlider"]:OnHover(function()
                    Items["Icon"]:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(0, 18, 0, 14)})
                end)

                Items["RealSlider"]:OnHoverLeave(function()
                    Items["Icon"]:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(0, 16, 0, 12)})
                end)
            end

            Items["RealSlider"].Instance.Position = UDim2New(0, 80, 1, -3)
            Items["Text"].Instance.Position = UDim2New(0, 80, 0, 0)

            function Slider:Get()
                return Slider.Value 
            end

            function Slider:SetVisibility(Bool)
                Items["Slider"].Instance.Visible = Bool
            end

            function Slider:RefreshPosition(Bool)
                if Bool then 
                    Items["RealSlider"].Instance.Position = UDim2New(0, 20, 1, -3)
                    Items["Text"].Instance.Position = UDim2New(0, 0, 0, 0)
                else
                    Items["RealSlider"].Instance.Position = UDim2New(0, 80, 1, -3)
                    Items["Text"].Instance.Position = UDim2New(0, 80, 0, 0)
                end
            end

            function Slider:Set(Value)
                Slider.Value = Library:Round(MathClamp(Value, Slider.Min, Slider.Max), Slider.Decimals)
                Library.Flags[Slider.Flag] = Slider.Value

                Items["Accent"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2New((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)})
                Items["Value"].Instance.Text = Slider.Suffix == "%" and StringFormat("%s%%", Library:Round(Slider.Value * 100, 1)) or StringFormat("%s%s", Slider.Value, Slider.Suffix)

                if Slider.Value >= Slider.Max then 
                    Items["Icon"].Instance.Position = UDim2New(1, -5, 0.5, 0)
                else
                    Items["Icon"].Instance.Position = UDim2New(1, 5, 0.5, 0)
                end

                if Slider.Callback then 
                    Library:SafeCall(Slider.Callback, Slider.Value)
                end
            end

            Items["Plus"]:Connect("MouseButton1Down", function()
                Slider:Set(Slider.Value + Slider.Decimals)
            end)

            Items["Minus"]:Connect("MouseButton1Down", function()
                Slider:Set(Slider.Value - Slider.Decimals)
            end)

            local InputChanged 
            
            Items["RealSlider"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Slider.Sliding = true

                    local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                    local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

                    Slider:Set(Value)

                    if InputChanged then
                        return
                    end

                    InputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Slider.Sliding = false

                            InputChanged:Disconnect()
                            InputChanged = nil
                        end
                    end)
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if Slider.Sliding then
                        local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                        local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

                        Slider:Set(Value)
                    end
                end
            end)

            if Slider.Default then
                Slider:Set(Slider.Default)
            end
            Library.FlagDefaults[Slider.Flag] = Slider.Default

            Library.SetFlags[Slider.Flag] = function(Value)
                Slider:Set(Value)
            end

            Slider.Section.Elements[#Slider.Section.Elements+1] = Slider
            Slider:RefreshPosition(true)
            return Slider 
        end

        Library.Sections.Dropdown = function(self, Data)
            Data = Data or { }

            local Dropdown = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Dropdown",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Items = Data.Items or Data.items or { "One", "Two", "Three" },
                Default = Data.Default or Data.default or nil,
                Callback = Data.Callback or Data.callback or function() end,
                Size = Data.Size or Data.size or 200,
                OptionHolderSize = Data.OptionHolderSize or Data.optionholder or 160,
                Multi = Data.Multi or Data.multi or false,

                Value = { },
                Options = { },
                OptionsWithIndexes = { },
                IsOpen = false
            }

            local Items = { } do 
                Items["Dropdown"] = Instances:Create("Frame", {
                    Parent = Dropdown.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 38),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Dropdown"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.30000001192092896,
                    Text = Dropdown.Name,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    AnchorPoint = Vector2New(0, 0.5),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})
                
                Items["RealDropdown"] = Instances:Create("TextButton", {
                    Parent = Items["Dropdown"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    Size = UDim2New(0, math.max(Dropdown.Size or 180, 180), 0, 32),
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0),
                    Position = UDim2New(1, 0, 0, 0),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(27, 26, 29)
                })  Items["RealDropdown"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["RealDropdown"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Items["Value"] = Instances:Create("TextLabel", {
                    Parent = Items["RealDropdown"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.30000001192092896,
                    Text = "-",
                    Size = UDim2New(1, -40, 0, 15),
                    AnchorPoint = Vector2New(0, 0.5),
                    BorderSizePixel = 0,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 10, 0.5, -1),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Value"]:AddToTheme({TextColor3 = "Text"})
                
                Items["Liner"] = Instances:Create("Frame", {
                    Parent = Items["RealDropdown"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    Position = UDim2New(1, -25, 0, 0),
                    Size = UDim2New(0, 2, 1, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(34, 32, 36)
                })  Items["Liner"]:AddToTheme({BackgroundColor3 = "Outline"})
                
                Items["ArrowIcon"] = Instances:Create("ImageLabel", {
                    Parent = Items["RealDropdown"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(141, 141, 150),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 16, 0, 8),
                    AnchorPoint = Vector2New(1, 0.5),
                    Image = "rbxassetid://123317177279443",
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, -5, 0.5, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["Gradient"] = Instances:Create("UIGradient", {
                    Parent = Items["ArrowIcon"].Instance,
                    Name = "\0",
                    Enabled = false,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(131, 131, 131)), RGBSequenceKeypoint(1, FromRGB(255, 255, 255))}
                })  Items["Gradient"]:AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})

                Items["OptionHolder"] = Instances:Create("TextButton", {
                    Parent = Library.UnusedHolder.Instance,
                    Text = "",
                    AutoButtonColor = false,
                    Name = "\0",
                    Visible = false,
                    Position = UDim2New(0, 897, 0, 101),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 159, 0, 87),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 25, 29)
                })  Items["OptionHolder"]:AddToTheme({BackgroundColor3 = "Background"})
                
                Instances:Create("UIStroke", {
                    Parent = Items["OptionHolder"].Instance,
                    Name = "\0",
                    Color = FromRGB(35, 33, 38),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Outline"})
                
                Instances:Create("UICorner", {
                    Parent = Items["OptionHolder"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })
                
                Items["Holder"] = Instances:Create("ScrollingFrame", {
                    Parent = Items["OptionHolder"].Instance,
                    Name = "\0",
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 2,
                    Size = UDim2New(1, -16, 1, -16),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 8, 0, 8),
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    CanvasSize = UDim2New(0, 0, 0, 0)
                })  Items["Holder"]:AddToTheme({ScrollBarImageColor3 = "Accent"})
                
                Instances:Create("UIListLayout", {
                    Parent = Items["Holder"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 4),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })                
            end

            Items["Text"].Instance.Position = UDim2New(0, 30, 0.5, 0)
            Items["RealDropdown"].Instance.Position = UDim2New(1, 30, 0, 0)

            function Dropdown:Get()
                return Dropdown.Value
            end

            function Dropdown:SetVisibility(Bool)
                Items["Dropdown"].Instance.Visible = Bool
            end

            function Dropdown:RefreshPosition(Bool)
                if Bool then
                    Items["Text"].Instance.Position = UDim2New(0, 0, 0.5, 0)
                    Items["RealDropdown"].Instance.Position = UDim2New(1, 0, 0, 0)
                else
                    Items["Text"].Instance.Position = UDim2New(0, 30, 0.5, 0)
                    Items["RealDropdown"].Instance.Position = UDim2New(1, 30, 0, 0)
                end
            end

            Items["RealDropdown"]:OnHover(function()
                if Dropdown.IsOpen then
                    return 
                end

                Items["ArrowIcon"]:Tween(nil, {ImageColor3 = FromRGB(255, 255, 255)})
                Items["Gradient"].Instance.Enabled = true
            end)

            Items["RealDropdown"]:OnHoverLeave(function()
                if Dropdown.IsOpen then
                    return 
                end

                Items["ArrowIcon"]:Tween(nil, {ImageColor3 = FromRGB(141, 141, 150)})
                Items["Gradient"].Instance.Enabled = false
            end)

            local RenderStepped 

            function Dropdown:SetOpen(Bool)
                if Debounce then 
                    return
                end

                Dropdown.IsOpen = Bool

                Debounce = true 

                if Dropdown.IsOpen then 
                    Items["OptionHolder"].Instance.Visible = true
                    Items["OptionHolder"].Instance.Parent = Library.Holder.Instance

                    Items["ArrowIcon"]:Tween(nil, {Rotation = 180, ImageColor3 = FromRGB(255, 255, 255)})
                    Items["Gradient"].Instance.Enabled = true
                    
                    Library:Thread(function()
                        for Index, Value in Dropdown.OptionsWithIndexes do 
                            task.spawn(function()
                                Value:RefreshPosition(true)
                            end)
                            task.wait(0.05)
                        end
                    end)
                    
                    RenderStepped = RunService.RenderStepped:Connect(function()
                        Items["OptionHolder"].Instance.Position = UDim2New(0, Items["RealDropdown"].Instance.AbsolutePosition.X, 0, Items["RealDropdown"].Instance.AbsolutePosition.Y + Items["RealDropdown"].Instance.AbsoluteSize.Y + 5)
                        Items["OptionHolder"].Instance.Size = UDim2New(0, Items["RealDropdown"].Instance.AbsoluteSize.X, 0, Dropdown.OptionHolderSize)
                    end)

                    for Index, Value in Library.OpenFrames do 
                        if Value ~= Dropdown and not Dropdown.Section.IsSettings then 
                            Value:SetOpen(false)
                        end
                    end

                    Library.OpenFrames[Dropdown] = Dropdown 
                else
                    if not Dropdown.IsOpen then
                        for Index, Value in Dropdown.OptionsWithIndexes do 
                            task.spawn(function()
                                Value:RefreshPosition(false)
                            end)
                        end
                    end

                    if Library.OpenFrames[Dropdown] then 
                        Library.OpenFrames[Dropdown] = nil
                    end

                    if RenderStepped then 
                        RenderStepped:Disconnect()
                        RenderStepped = nil
                    end

                    Items["ArrowIcon"]:Tween(nil, {Rotation = 0, ImageColor3 = FromRGB(141, 141, 150)})
                    Items["Gradient"].Instance.Enabled = false
                end

                local Descendants = Items["OptionHolder"].Instance:GetDescendants()
                TableInsert(Descendants, Items["OptionHolder"].Instance)

                local NewTween

                for Index, Value in Descendants do 
                    local TransparencyProperty = Tween:GetProperty(Value)

                    if not TransparencyProperty then
                        continue 
                    end

                    if not Value.ClassName:find("UI") then 
                        Value.ZIndex = (Dropdown.IsOpen and Dropdown.Section.IsSettings and 8) or (Dropdown.IsOpen and 3) or 1
                    end

                    if type(TransparencyProperty) == "table" then 
                        for _, Property in TransparencyProperty do 
                            NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
                        end
                    else
                        NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
                    end
                end
                
                NewTween.Tween.Completed:Connect(function()
                    Debounce = false 
                    Items["OptionHolder"].Instance.Visible = Dropdown.IsOpen
                    task.wait(0.2)
                    Items["OptionHolder"].Instance.Parent = not Dropdown.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
                end)
            end

            function Dropdown:Set(Option)
                if Dropdown.Multi then 
                    if type(Option) ~= "table" then 
                        return
                    end

                    Dropdown.Value = Option
                    Library.Flags[Dropdown.Flag] = Option

                    for Index, Value in Option do
                        local OptionData = Dropdown.Options[Value]
                        
                        if not OptionData then
                            continue
                        end

                        OptionData.Selected = true 
                        OptionData:Toggle("Active")
                    end

                    Items["Value"].Instance.Text = TableConcat(Option, ", ")
                else
                    if not Dropdown.Options[Option] then
                        return
                    end

                    local OptionData = Dropdown.Options[Option]

                    Dropdown.Value = Option
                    Library.Flags[Dropdown.Flag] = Option

                    for Index, Value in Dropdown.Options do
                        if Value ~= OptionData then
                            Value.Selected = false 
                            Value:Toggle("Inactive")
                        else
                            Value.Selected = true 
                            Value:Toggle("Active")
                        end
                    end

                    Items["Value"].Instance.Text = Option
                end

                if Dropdown.Callback then   
                    Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                end
            end

            function Dropdown:Add(Option)
                local OptionButton = Instances:Create("TextButton", {
                    Parent = Items["Holder"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                local OptionAccent = Instances:Create("Frame", {
                    Parent = OptionButton.Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 0.5),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0.5, 0),
                    Size = UDim2New(0, 6, 0, 6),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UIGradient", {
                    Parent = OptionAccent.Instance,
                    Name = "\0",
                    Enabled = true,
                    Rotation = -115,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})
                
                Instances:Create("UICorner", {
                    Parent = OptionAccent.Instance,
                    Name = "\0"
                })
                
                local OptionText = Instances:Create("TextLabel", {
                    Parent = OptionAccent.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.30000001192092896,
                    Text = Option,
                    Size = UDim2New(0, 0, 0, 15),
                    AnchorPoint = Vector2New(0, 0.5),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 30, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  OptionText:AddToTheme({TextColor3 = "Text"})
                
                local OptionData = {
                    Button = OptionButton,
                    Name = Option,
                    OptionText = OptionText,
                    OptionAccent = OptionAccent,
                    Selected = false
                }
                
                function OptionData:Toggle(Value)
                    if Value == "Active" then
                        OptionText:Tween(nil, {TextTransparency = 0, Position = UDim2New(0, 15, 0.5, 0)})
                        OptionAccent:Tween(nil, {BackgroundTransparency = 0})
                    else
                        OptionText:Tween(nil, {TextTransparency = 0.3, Position = UDim2New(0, 0, 0.5, 0)})
                        OptionAccent:Tween(nil, {BackgroundTransparency = 1})
                    end
                end

                function OptionData:RefreshPosition(Bool)
                    if Bool then 
                        if OptionData.Selected then
                            OptionAccent.Instance.Position = UDim2New(0, 0, 0.5, 0)
                            OptionText.Instance.Position = UDim2New(0, 15, 0.5, 0)
                        else
                            OptionText.Instance.Position = UDim2New(0, 0, 0.5, 0)
                        end
                    else
                        if OptionData.Selected then
                            OptionAccent.Instance.Position = UDim2New(0, 30, 0.5, 0)
                            OptionText.Instance.Position = UDim2New(0, 45, 0.5, 0)
                        else
                            OptionText.Instance.Position = UDim2New(0, 30, 0.5, 0)
                        end
                    end

                end

                function OptionData:Set()
                    OptionData.Selected = not OptionData.Selected

                    if Dropdown.Multi then 
                        local Index = TableFind(Dropdown.Value, OptionData.Name)

                        if Index then 
                            TableRemove(Dropdown.Value, Index)
                        else
                            TableInsert(Dropdown.Value, OptionData.Name)
                        end

                        OptionData:Toggle(Index and "Inactive" or "Active")

                        Library.Flags[Dropdown.Flag] = Dropdown.Value

                        local TextFormat = #Dropdown.Value > 0 and TableConcat(Dropdown.Value, ", ") or "..."
                        Items["Value"].Instance.Text = TextFormat
                    else
                        if OptionData.Selected then 
                            Dropdown.Value = OptionData.Name
                            Library.Flags[Dropdown.Flag] = OptionData.Name

                            OptionData.Selected = true
                            OptionData:Toggle("Active")

                            for Index, Value in Dropdown.Options do 
                                if Value ~= OptionData then
                                    Value.Selected = false 
                                    Value:Toggle("Inactive")
                                end
                            end

                            Items["Value"].Instance.Text = OptionData.Name
                        else
                            Dropdown.Value = nil
                            Library.Flags[Dropdown.Flag] = nil

                            OptionData.Selected = false
                            OptionData:Toggle("Inactive")

                            Items["Value"].Instance.Text = "..."
                        end
                    end

                    if Dropdown.Callback then
                        Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                    end
                end

                OptionData.Button:Connect("MouseButton1Down", function()
                    OptionData:Set()
                end)

                Dropdown.Options[OptionData.Name] = OptionData
                Dropdown.OptionsWithIndexes[#Dropdown.OptionsWithIndexes+1] = OptionData
                OptionData:RefreshPosition(false)

                return OptionData
            end

            function Dropdown:Remove(Option)
                if Dropdown.Options[Option] then
                    Dropdown.Options[Option].Button:Clean()
                    Dropdown.Options[Option] = nil
                end
            end

            function Dropdown:Refresh(List, DefaultVal)
                local OptionsToRemove = {}
                for Name, _ in pairs(Dropdown.Options) do
                    table.insert(OptionsToRemove, Name)
                end
                for _, Name in ipairs(OptionsToRemove) do
                    Dropdown:Remove(Name)
                end
                Dropdown.Options = {}
                Dropdown.OptionsWithIndexes = {}
                for Index, Value in ipairs(List) do
                    Dropdown:Add(Value)
                end
                if DefaultVal then
                    Dropdown:Set(DefaultVal)
                else
                    if Dropdown.Multi then
                        Dropdown.Value = {}
                        Library.Flags[Dropdown.Flag] = Dropdown.Value
                    else
                        Dropdown.Value = nil
                        Library.Flags[Dropdown.Flag] = nil
                    end
                    Items["Value"].Instance.Text = "..."
                end
            end

            Items["RealDropdown"]:Connect("MouseButton1Down", function()
                Dropdown:SetOpen(not Dropdown.IsOpen)
            end)

            Library:Connect(UserInputService.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    if Dropdown.IsOpen then
                        if Library:IsMouseOverFrame(Items["OptionHolder"]) then
                            return
                        end

                        Dropdown:SetOpen(false)
                    end
                end
            end)

            Items["RealDropdown"]:Connect("Changed", function(Property)
                if Property == "AbsolutePosition" and Dropdown.IsOpen then
                    Dropdown.IsOpen = not Library:IsClipped(Items["OptionHolder"].Instance, Dropdown.Section.Items["Section"].Instance.Parent)
                    Items["OptionHolder"].Instance.Visible = Dropdown.IsOpen
                end
            end)

            for Index, Value in Dropdown.Items do 
                Dropdown:Add(Value)
            end

            if Dropdown.Default then 
                Dropdown:Set(Dropdown.Default)
            end
            Library.FlagDefaults[Dropdown.Flag] = Dropdown.Default

            Library.SetFlags[Dropdown.Flag] = function(Value)
                Dropdown:Set(Value)
            end

            Dropdown.Section.Elements[#Dropdown.Section.Elements+1] = Dropdown
            Dropdown:RefreshPosition(true)
            return Dropdown
        end

        Library.Sections.Label = function(self, Name)
            local Label = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Name or "Label"
            }

            local Items = { } do 
                Items["Label"] = Instances:Create("Frame", {
                    Parent = Label.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 20),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Label"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.30000001192092896,
                    Text = Label.Name,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2New(1, -40, 0, 15),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 30, 0, 5),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})          
            end

            function Label:SetText(Text)
                Text = tostring(Text)
                Items["Text"].Instance.Text = Text
            end

            function Label:SetVisibility(Bool)
                Items["Label"].Instance.Visible = Bool
            end

            function Label:RefreshPosition(Bool)
                if Bool then 
                    Items["Text"].Instance.Position = UDim2New(0, 0, 0, 5)
                    if Items["SubElements"] then
                        Items["SubElements"].Instance.Position = UDim2New(0, 0, 0, 30)
                        local nig = Items["Label"].Instance:FindFirstChild("nig")
                        if nig then nig.Position = UDim2New(1, -16, 1, -6) end
                    end
                else 
                    Items["Text"].Instance.Position = UDim2New(0, 30, 0, 5)
                    if Items["SubElements"] then
                        Items["SubElements"].Instance.Position = UDim2New(0, 30, 0, 30)
                        local nig = Items["Label"].Instance:FindFirstChild("nig")
                        if nig then nig.Position = UDim2New(1, 30, 1, -6) end
                    end
                end
            end

            function Label:Colorpicker(Data)
                Data = Data or { }

                local Colorpicker = {
                    Window = Label.Window,
                    Page = Label.Page,
                    Section = Label.Section,

                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
                    Callback = Data.Callback or Data.callback or function() end,
                    Alpha = Data.Alpha or Data.alpha or false
                }

                if not Items["SubElements"] then
                    Items["SubElements"] = Instances:Create("Frame", {
                        Parent = Items["Label"].Instance,
                        Name = "\0",
                        Size = UDim2New(1, 0, 0, 30),
                        Position = UDim2New(0, 0, 0, 30),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(27, 26, 29)
                    })  Items["SubElements"]:AddToTheme({BackgroundColor3 = "Element"})
                    
                    Instances:Create("UICorner", {
                        Parent = Items["SubElements"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 5)
                    })
                    
                    Instances:Create("UIListLayout", {
                        Parent = Items["SubElements"].Instance,
                        Name = "\0",
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        FillDirection = Enum.FillDirection.Horizontal,
                        Padding = UDimNew(0, 5),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })

                    Instances:Create("UIPadding", {
                        Parent = Items["SubElements"].Instance,
                        Name = "\0",
                        PaddingLeft = UDimNew(0, 6)
                    })                
                end

                local NewColorpicker, ColorpickerItems = Library:CreateColorpicker({
                    Parent = Items["SubElements"],
                    Page = Colorpicker.Page,
                    Section = Colorpicker.Section,
                    Flag = Colorpicker.Flag,
                    Default = Colorpicker.Default,
                    Callback = Colorpicker.Callback,
                    Parent2 = Items["Label"],
                    Alpha = Colorpicker.Alpha
                })

                return NewColorpicker
            end

            Label.Section.Elements[#Label.Section.Elements+1] = Label
            Label:RefreshPosition(true)
            return Label
        end

        Library.Sections.Keybind = function(self, Data)
            Data = Data or { }

            local Keybind = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Keybind",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or Enum.KeyCode.RightShift,
                Callback = Data.Callback or Data.callback or function() end,
                Mode = Data.Mode or Data.mode or Enum.KeyCode.RightShift,

                Value = "",
                ModeSelected = "",
                Toggled = false,
                Picking = false
            }

            local Items = { } do
                Items["Label"] = Instances:Create("Frame", {
                    Parent = Keybind.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 20),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["SubElements"] = Instances:Create("Frame", {
                    Parent = Items["Label"].Instance,
                    Name = "\0",
                    Size = UDim2New(1, 0, 0, 30),
                    Position = UDim2New(0, 0, 0, 30),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 26, 29)
                })  Items["SubElements"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["SubElements"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["SubElements"].Instance,
                    Name = "\0",
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDimNew(0, 5),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                Instances:Create("UIPadding", {
                    Parent = Items["SubElements"].Instance,
                    Name = "\0",
                    PaddingLeft = UDimNew(0, 6)
                })
                
                Items["KeyButton"] = Instances:Create("TextButton", {
                    Parent = Items["SubElements"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.30000001192092896,
                    Text = "MouseButton2",
                    AutoButtonColor = false,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    SelectionOrder = 2,
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["KeyButton"]:AddToTheme({TextColor3 = "Text"})
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Label"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.30000001192092896,
                    Text = Keybind.Name,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0, 5),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})
                
                Items["Modes"] = Instances:Create("Frame", {
                    Parent = Items["Label"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    Position = UDim2New(1, 0, 0, 0),
                    Size = UDim2New(0, 200, 0, 25),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 26, 29)
                })  Items["Modes"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Modes"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })
                
                Items["Background"] = Instances:Create("Frame", {
                    Parent = Items["Modes"].Instance,
                    Name = "\0",
                    Size = UDim2New(0.35, 0, 1, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundTransparency = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    Rotation = -115,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(166, 166, 166))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})
                
                Items["Toggle"] = Instances:Create("TextButton", {
                    Parent = Items["Modes"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    TextTransparency = 0.30000001192092896,
                    Text = "Toggle",
                    AutoButtonColor = false,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0.35, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0, -1),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Toggle"]:AddToTheme({TextColor3 = function()
                    return Library.Theme.Text
                end})
                
                Items["Hold"] = Instances:Create("TextButton", {
                    Parent = Items["Modes"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.20000000298023224,
                    Text = "Hold",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(0, 0),
                    Size = UDim2New(0.35, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.35, 0, 0, -1),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Hold"]:AddToTheme({TextColor3 = function()
                    return Library.Theme.Text
                end})        
                
                Items["Always"] = Instances:Create("TextButton", {
                    Parent = Items["Modes"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.20000000298023224,
                    Text = "Always",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(0, 0),
                    Size = UDim2New(0.4, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.7, -12, 0, -1),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Always"]:AddToTheme({TextColor3 = function()
                    return Library.Theme.Text
                end})              
            end

            local KeyListItem 

            if Library.KeyList then 
                KeyListItem = Library.KeyList:Add("", "")
            end

            local Update = function()
                if KeyListItem then 
                    KeyListItem:Set(Data.Name, Keybind.Value)
                    KeyListItem:SetStatus(Keybind.Toggled)
                end
            end

            function Keybind:RefreshPosition(Bool)
                if Bool then 
                    Items["Text"].Instance.Position = UDim2New(0, 0, 0, 5)
                    if Items["SubElements"] then
                        Items["SubElements"].Instance.Position = UDim2New(0, 0, 0, 30)
                    end
                    Items["Modes"].Instance.Position = UDim2New(1, 0, 0, 0)
                else
                    Items["Text"].Instance.Position = UDim2New(0, 30, 0, 5)
                    if Items["SubElements"] then
                        Items["SubElements"].Instance.Position = UDim2New(0, 30, 0, 30)
                    end
                    Items["Modes"].Instance.Position = UDim2New(1, 30, 0, 0)
                end
            end

            function Keybind:SetMode(Mode)
                if Mode == "Toggle" then
                    Items["Background"]:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0, 0), Size = UDim2New(0.35, 0, 1, 0)})
                    Items["Toggle"]:ChangeItemTheme({TextColor3 = function()
                        return FromRGB(0, 0, 0)
                    end})
                    Items["Toggle"]:Tween(nil, {TextColor3 = FromRGB(0, 0, 0)})

                    Items["Hold"]:ChangeItemTheme({TextColor3 = function()
                        return Library.Theme.Text
                    end})
                    Items["Hold"]:Tween(nil, {TextColor3 = Library.Theme.Text})

                    Items["Always"]:ChangeItemTheme({TextColor3 = function()
                        return Library.Theme.Text
                    end})
                    Items["Always"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                elseif Mode == "Hold" then
                    Items["Background"]:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(0.35, 0, 0, 0), Size = UDim2New(0.35, 0, 1, 0)})
                
                    Items["Toggle"]:ChangeItemTheme({TextColor3 = function()
                        return Library.Theme.Text
                    end})
                    Items["Toggle"]:Tween(nil, {TextColor3 = Library.Theme.Text})

                    Items["Hold"]:ChangeItemTheme({TextColor3 = function()
                        return FromRGB(0, 0, 0)
                    end})
                    Items["Hold"]:Tween(nil, {TextColor3 = FromRGB(0, 0, 0)})

                    Items["Always"]:ChangeItemTheme({TextColor3 = function()
                        return Library.Theme.Text
                    end})
                    Items["Always"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                elseif Mode == "Always" then
                    Items["Background"]:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(0.7, 0, 0, 0), Size = UDim2New(0.3, 0, 1, 0)})
                
                    Items["Toggle"]:ChangeItemTheme({TextColor3 = function()
                        return Library.Theme.Text
                    end})
                    Items["Toggle"]:Tween(nil, {TextColor3 = Library.Theme.Text})

                    Items["Hold"]:ChangeItemTheme({TextColor3 = function()
                        return Library.Theme.Text
                    end})
                    Items["Hold"]:Tween(nil, {TextColor3 = Library.Theme.Text})

                    Items["Always"]:ChangeItemTheme({TextColor3 = function()
                        return FromRGB(0, 0, 0)
                    end})
                    Items["Always"]:Tween(nil, {TextColor3 = FromRGB(0, 0, 0)})
                end

                Library.Flags[Keybind.Flag] = {
                    Mode = Keybind.ModeSelected,
                    Key = Keybind.Key,
                    Toggled = Keybind.Toggled
                }

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Keybind.Toggled)
                end
            end

            function Keybind:Press(Bool)
                if Keybind.ModeSelected == "Toggle" then 
                    Keybind.Toggled = not Keybind.Toggled
                elseif Keybind.ModeSelected == "Hold" then 
                    Keybind.Toggled = Bool
                elseif Keybind.ModeSelected == "Always" then 
                    Keybind.Toggled = true
                end

                Library.Flags[Keybind.Flag] = {
                    Mode = Keybind.ModeSelected,
                    Key = Keybind.Key,
                    Toggled = Keybind.Toggled
                }

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Keybind.Toggled)
                end

                Update()
            end

            function Keybind:Get()
                return Keybind.Key, Keybind.ModeSelected, Keybind.Toggled
            end

            function Keybind:Set(Key)
                if StringFind(tostring(Key), "Enum") then 
                    Keybind.Key = tostring(Key)

                    local KeyName
                    if type(Key) == "string" then
                        KeyName = Key:match("[^%.]+$") or "None"
                        if KeyName == "Backspace" then KeyName = "None" end
                    else
                        KeyName = Key.Name == "Backspace" and "None" or Key.Name
                    end

                    local KeyString = Keys[Keybind.Key] or StringGSub(KeyName or "", "Enum.", "") or "None"
                    local TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

                    Keybind.Value = TextToDisplay
                    Items["KeyButton"].Instance.Text = TextToDisplay

                    Library.Flags[Keybind.Flag] = {
                        Mode = Keybind.ModeSelected,
                        Key = Keybind.Key,
                        Toggled = Keybind.Toggled
                    }

                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end

                    Update()
                elseif type(Key) == "table" and Key.Key ~= nil then
                    Keybind.Key = tostring(Key.Key)

                    if Key.Mode or Key.ModeSelected then
                        Keybind:SetMode(Key.Mode or Key.ModeSelected)
                    else
                        Keybind:SetMode("Toggle")
                    end

                    local RealKey = type(Key.Key) == "string" and Key.Key:match("[^%.]+$") or (Key.Key == "Backspace" and "None" or (Key.Key and Key.Key.Name))
                    local KeyString = Keys[Keybind.Key] or StringGSub(tostring(RealKey or Key.Key or ""), "Enum.", "") or RealKey
                    local TextToDisplay = StringGSub(StringGSub(KeyString or "", "KeyCode.", ""), "UserInputType.", "") or "None"

                    Keybind.Value = TextToDisplay
                    Items["KeyButton"].Instance.Text = TextToDisplay

                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end

                    Update()
                elseif TableFind({"Toggle", "Hold", "Always"}, Key) then
                    Keybind.ModeSelected = Key
                    Keybind:SetMode(Key)

                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end

                    Update()
                end

                Keybind.Picking = false
            end

            Items["KeyButton"]:Connect("MouseButton1Click", function()
                Keybind.Picking = true 

                Items["KeyButton"].Instance.Text = "."
                Library:Thread(function()
                    local Count = 1

                    while true do 
                        if not Keybind.Picking then 
                            break
                        end

                        if Count == 4 then
                            Count = 1
                        end

                        Items["KeyButton"].Instance.Text = Count == 1 and "." or Count == 2 and ".." or Count == 3 and "..."
                        Count += 1
                        task.wait(0.35)
                    end
                end)

                local InputBegan
                InputBegan = UserInputService.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.Keyboard then 
                        Keybind:Set(Input.KeyCode)
                    else
                        Keybind:Set(Input.UserInputType)
                    end

                    InputBegan:Disconnect()
                    InputBegan = nil
                end)
            end)

            Library:Connect(UserInputService.InputBegan, function(Input)
                if Keybind.Value == "None" then
                    return
                end

                if tostring(Input.KeyCode) == Keybind.Key then
                    if Keybind.ModeSelected == "Toggle" then 
                        Keybind:Press()
                    elseif Keybind.ModeSelected == "Hold" then 
                        Keybind:Press(true)
                    elseif Keybind.ModeSelected == "Always" then 
                        Keybind:Press(true)
                    end
                elseif tostring(Input.UserInputType) == Keybind.Key then
                    if Keybind.ModeSelected == "Toggle" then 
                        Keybind:Press()
                    elseif Keybind.ModeSelected == "Hold" then 
                        Keybind:Press(true)
                    elseif Keybind.ModeSelected == "Always" then 
                        Keybind:Press(true)
                    end
                end

                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if not Keybind.IsOpen then
                        return
                    end

                    if Library:IsMouseOverFrame(Items["KeybindWindow"]) or Library:IsMouseOverFrame(Items["OptionHolder"]) then
                        return
                    end

                    Keybind:SetOpen(false)
                end
            end)

            Library:Connect(UserInputService.InputEnded, function(Input)
                if Keybind.Value == "None" then
                    return
                end

                if tostring(Input.KeyCode) == Keybind.Key then
                    if Keybind.ModeSelected == "Hold" then 
                        Keybind:Press(false)
                    elseif Keybind.ModeSelected == "Always" then 
                        Keybind:Press(true)
                    end
                elseif tostring(Input.UserInputType) == Keybind.Key then
                    if Keybind.ModeSelected == "Hold" then 
                        Keybind:Press(false)
                    elseif Keybind.ModeSelected == "Always" then 
                        Keybind:Press(true)
                    end
                end
            end)

            Items["Toggle"]:Connect("MouseButton1Down", function()
                Keybind.ModeSelected = "Toggle"
                Keybind:SetMode("Toggle")
            end)

            Items["Hold"]:Connect("MouseButton1Down", function()
                Keybind.ModeSelected = "Hold"
                Keybind:SetMode("Hold")
            end)

            Items["Always"]:Connect("MouseButton1Down", function()
                Keybind.ModeSelected = "Always"
                Keybind:SetMode("Always")
            end)

            if Keybind.Default then 
                Keybind:Set({
                    Mode = Keybind.Mode or "Toggle",
                    Key = Keybind.Default,
                })
            end
            Library.FlagDefaults[Keybind.Flag] = { Key = Keybind.Default, Mode = Keybind.Mode or "Toggle" }

            Library.SetFlags[Keybind.Flag] = function(Value)
                Keybind:Set(Value)
            end

            Keybind.Section.Elements[#Keybind.Section.Elements+1] = Keybind
            Keybind:RefreshPosition(true)
            return Keybind 
        end

        Library.Sections.Sub2keybind = function(self, Data)
            Data = Data or { }

            local Sub2keybind = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Keybind",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or Enum.KeyCode.RightShift,
                Callback = Data.Callback or Data.callback or function() end,
                Mode = Data.Mode or Data.mode or "Toggle",

                Value = "",
                ModeSelected = "Toggle",
                Toggled = false,
                Picking = false,
                Key = "",
                ModeMenuOpen = false
            }
            Sub2keybind.ModeSelected = Sub2keybind.Mode

            local UpdateSub2ModeVisuals
            local Items = { } do
                Items["Label"] = Instances:Create("Frame", {
                    Parent = Sub2keybind.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 20),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Label"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.30000001192092896,
                    Text = Sub2keybind.Name,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0, 2),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

                Items["KeyContainer"] = Instances:Create("Frame", {
                    Parent = Items["Label"].Instance,
                    Name = "\0",
                    Size = UDim2New(0, 70, 0, 18),
                    AnchorPoint = Vector2New(1, 0),
                    Position = UDim2New(1, 0, 0, 1),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 26, 29)
                })  Items["KeyContainer"]:AddToTheme({BackgroundColor3 = "Element"})
                Instances:Create("UICorner", { Parent = Items["KeyContainer"].Instance, Name = "\0", CornerRadius = UDimNew(0, 4) })

                Items["KeyButton"] = Instances:Create("TextButton", {
                    Parent = Items["KeyContainer"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    TextTransparency = 0.30000001192092896,
                    Text = "None",
                    AutoButtonColor = false,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["KeyButton"]:AddToTheme({TextColor3 = "Text"})

                local ModeMenuFrame = Instances:Create("Frame", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    Visible = false,
                    ClipsDescendants = false,
                    Size = UDim2New(0, 55, 0, 44),
                    Position = UDim2New(0, 0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 500,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 26, 29)
                })  ModeMenuFrame:AddToTheme({BackgroundColor3 = "Element"})
                Instances:Create("UICorner", { Parent = ModeMenuFrame.Instance, Name = "\0", CornerRadius = UDimNew(0, 4) })
                Instances:Create("UIListLayout", {
                    Parent = ModeMenuFrame.Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 2),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Top
                })
                Instances:Create("UIPadding", {
                    Parent = ModeMenuFrame.Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 3),
                    PaddingBottom = UDimNew(0, 3),
                    PaddingLeft = UDimNew(0, 4),
                    PaddingRight = UDimNew(0, 4)
                })
                local TweenInfoHover = TweenInfo.new(Library.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                local AccentColor = Library.Theme.Accent or FromRGB(255, 80, 80)
                local function CreateModeOption(Name, IsSelected)
                    local Row = Instances:Create("TextButton", {
                        Parent = ModeMenuFrame.Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = IsSelected and FromRGB(240, 240, 240) or FromRGB(160, 160, 165),
                        Text = "",
                        AutoButtonColor = false,
                        Size = UDim2New(1, -8, 0, 16),
                        BorderSizePixel = 0,
                        ZIndex = 501,
                        TextSize = 12,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundColor3 = FromRGB(0, 0, 0),
                        BackgroundTransparency = 1
                    })
                    Row.Instance.LayoutOrder = Name == "Toggle" and 0 or 1
                    local CircleContainer = Instances:Create("Frame", {
                        Parent = Row.Instance,
                        Name = "\0",
                        Size = UDim2New(0, 14, 0, 16),
                        Position = UDim2New(0, 0, 0, 0),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1
                    })
                    local Circle = Instances:Create("Frame", {
                        Parent = CircleContainer.Instance,
                        Name = "\0",
                        Size = UDim2New(0, 5, 0, 5),
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Position = UDim2New(0.5, 0, 0.5, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 502,
                        BorderSizePixel = 0,
                        BackgroundColor3 = AccentColor,
                        BackgroundTransparency = IsSelected and 0 or 1
                    })
                    Instances:Create("UICorner", { Parent = Circle.Instance, Name = "\0", CornerRadius = UDimNew(1, 0) })
                    local CircleStroke = Instances:Create("UIStroke", {
                        Parent = Circle.Instance,
                        Name = "\0",
                        Color = AccentColor,
                        Thickness = 1,
                        Transparency = IsSelected and 1 or 0
                    })
                    local Label = Instances:Create("TextLabel", {
                        Parent = Row.Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = IsSelected and FromRGB(240, 240, 240) or FromRGB(160, 160, 165),
                        Text = Name,
                        Size = UDim2New(1, -18, 0, 16),
                        Position = UDim2New(0, 14, 0, 0),
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextSize = 12,
                        ZIndex = 502
                    })
                    Row:OnHover(function()
                        Label:Tween(TweenInfoHover, {TextColor3 = FromRGB(255, 255, 255)})
                    end)
                    Row:OnHoverLeave(function()
                        local active = (Name == "Toggle" and Sub2keybind.ModeSelected == "Toggle") or (Name == "Hold" and Sub2keybind.ModeSelected == "Hold")
                        Label:Tween(TweenInfoHover, {TextColor3 = active and FromRGB(240, 240, 240) or FromRGB(160, 160, 165)})
                    end)
                    return { Row = Row, Circle = Circle, CircleStroke = CircleStroke, Label = Label }
                end
                local MenuToggle = CreateModeOption("Toggle", Sub2keybind.ModeSelected == "Toggle")
                local MenuHold = CreateModeOption("Hold", Sub2keybind.ModeSelected == "Hold")
                local function UpdateModeVisuals()
                    local toggleSel = Sub2keybind.ModeSelected == "Toggle"
                    local holdSel = Sub2keybind.ModeSelected == "Hold"
                    MenuToggle.Circle.Instance.BackgroundTransparency = toggleSel and 0 or 1
                    MenuToggle.CircleStroke.Instance.Transparency = toggleSel and 1 or 0
                    MenuToggle.Label.Instance.TextColor3 = toggleSel and FromRGB(240, 240, 240) or FromRGB(160, 160, 165)
                    MenuHold.Circle.Instance.BackgroundTransparency = holdSel and 0 or 1
                    MenuHold.CircleStroke.Instance.Transparency = holdSel and 1 or 0
                    MenuHold.Label.Instance.TextColor3 = holdSel and FromRGB(240, 240, 240) or FromRGB(160, 160, 165)
                end
                UpdateSub2ModeVisuals = UpdateModeVisuals
                local function CloseModeMenu()
                    if not Sub2keybind.ModeMenuOpen then return end
                    Sub2keybind.ModeMenuOpen = false
                    ModeMenuFrame.Instance.Visible = false
                    ModeMenuFrame.Instance.Parent = Library.UnusedHolder.Instance
                end
                local function SetMode(Mode)
                    Sub2keybind.ModeSelected = Mode
                    Sub2keybind.Mode = Mode
                    UpdateModeVisuals()
                    Library.Flags[Sub2keybind.Flag] = { Mode = Sub2keybind.ModeSelected, Key = Sub2keybind.Key, Toggled = Sub2keybind.Toggled }
                end
                MenuToggle.Row:Connect("MouseButton1Click", function()
                    SetMode("Toggle")
                    CloseModeMenu()
                end)
                MenuHold.Row:Connect("MouseButton1Click", function()
                    SetMode("Hold")
                    CloseModeMenu()
                end)
                local function OpenModeMenu()
                    if Sub2keybind.ModeMenuOpen then CloseModeMenu() return end
                    Sub2keybind.ModeMenuOpen = true
                    ModeMenuFrame.Instance.Parent = Library.Holder.Instance
                    ModeMenuFrame.Instance.Visible = true
                    local ContainerPos = Items["KeyContainer"].Instance.AbsolutePosition
                    local ContainerSize = Items["KeyContainer"].Instance.AbsoluteSize
                    ModeMenuFrame.Instance.Position = UDim2New(0, ContainerPos.X + ContainerSize.X - 55, 0, ContainerPos.Y + ContainerSize.Y + 4)
                end
                Items["KeyContainer"]:Connect("InputBegan", function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton2 then OpenModeMenu() end
                end)
                Items["KeyButton"]:Connect("InputBegan", function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton2 then OpenModeMenu() end
                end)
                Library:Connect(UserInputService.InputBegan, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.MouseButton2 or Input.UserInputType == Enum.UserInputType.Touch then
                        if Sub2keybind.ModeMenuOpen and not Library:IsMouseOverFrame(ModeMenuFrame) and not Library:IsMouseOverFrame(Items["KeyContainer"]) then
                            CloseModeMenu()
                        end
                    end
                end)
            end

            local KeyListItem
            if Library.KeyList then KeyListItem = Library.KeyList:Add(Sub2keybind.Name, "") end

            local function UpdateKeyList()
                if KeyListItem then KeyListItem:Set(Sub2keybind.Name, Sub2keybind.Value) KeyListItem:SetStatus(Sub2keybind.Toggled) end
            end

            local function SetKeyDisplay()
                local KeyStr = Keys[Sub2keybind.Key] or StringGSub(StringGSub(tostring(Sub2keybind.Key), "Enum%.KeyCode%.", ""), "Enum%.UserInputType%.", "") or "None"
                Sub2keybind.Value = KeyStr
                Items["KeyButton"].Instance.Text = KeyStr
                UpdateKeyList()
            end

            function Sub2keybind:Set(Key)
                if StringFind(tostring(Key), "Enum") then
                    Sub2keybind.Key = tostring(Key)
                    local KeyName
                    if type(Key) == "string" then
                        KeyName = Key:match("[^%.]+$") or "None"
                        if KeyName == "Backspace" then KeyName = "None" end
                    else
                        KeyName = Key.Name == "Backspace" and "None" or Key.Name
                    end
                    local KeyStr = Keys[Sub2keybind.Key] or StringGSub(StringGSub(KeyName or "", "KeyCode%.", ""), "UserInputType%.", "") or KeyName or "None"
                    Sub2keybind.Value = KeyStr
                    Items["KeyButton"].Instance.Text = KeyStr
                    Library.Flags[Sub2keybind.Flag] = { Mode = Sub2keybind.ModeSelected, Key = Sub2keybind.Key, Toggled = Sub2keybind.Toggled }
                    if Data.Callback then Library:SafeCall(Data.Callback, Sub2keybind.Toggled) end
                    Sub2keybind.Picking = false
                    UpdateKeyList()
                elseif type(Key) == "table" and Key.Key ~= nil then
                    Sub2keybind.Key = tostring(Key.Key)
                    if Key.Mode or Key.ModeSelected then
                        Sub2keybind.ModeSelected = Key.Mode or Key.ModeSelected
                        Sub2keybind.Mode = Sub2keybind.ModeSelected
                        if UpdateSub2ModeVisuals then UpdateSub2ModeVisuals() end
                    end
                    SetKeyDisplay()
                    Library.Flags[Sub2keybind.Flag] = { Mode = Sub2keybind.ModeSelected, Key = Sub2keybind.Key, Toggled = Sub2keybind.Toggled }
                    if Data.Callback then Library:SafeCall(Data.Callback, Sub2keybind.Toggled) end
                end
                Sub2keybind.Picking = false
            end

            function Sub2keybind:Press(Bool)
                if Sub2keybind.ModeSelected == "Toggle" then Sub2keybind.Toggled = not Sub2keybind.Toggled
                elseif Sub2keybind.ModeSelected == "Hold" then Sub2keybind.Toggled = Bool
                elseif Sub2keybind.ModeSelected == "Always" then Sub2keybind.Toggled = true end
                Library.Flags[Sub2keybind.Flag] = { Mode = Sub2keybind.ModeSelected, Key = Sub2keybind.Key, Toggled = Sub2keybind.Toggled }
                if Data.Callback then Library:SafeCall(Data.Callback, Sub2keybind.Toggled) end
                UpdateKeyList()
            end

            function Sub2keybind:Get()
                return Sub2keybind.Key, Sub2keybind.ModeSelected, Sub2keybind.Toggled
            end

            function Sub2keybind:RefreshPosition(Bool)
                if Bool then
                    Items["Text"].Instance.Position = UDim2New(0, 0, 0, 2)
                    Items["KeyContainer"].Instance.Position = UDim2New(1, 0, 0, 1)
                else
                    Items["Text"].Instance.Position = UDim2New(0, 30, 0, 2)
                    Items["KeyContainer"].Instance.Position = UDim2New(1, 30, 0, 1)
                end
            end

            Items["KeyButton"]:Connect("MouseButton1Click", function()
                Sub2keybind.Picking = true
                Items["KeyButton"].Instance.Text = "..."
                local InputBegan
                InputBegan = UserInputService.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.Keyboard then Sub2keybind:Set(Input.KeyCode)
                    else Sub2keybind:Set(Input.UserInputType) end
                    if InputBegan then InputBegan:Disconnect() InputBegan = nil end
                end)
            end)

            Library:Connect(UserInputService.InputBegan, function(Input)
                if Sub2keybind.Value == "None" or Sub2keybind.Picking then return end
                if tostring(Input.KeyCode) == Sub2keybind.Key or tostring(Input.UserInputType) == Sub2keybind.Key then
                    if Sub2keybind.ModeSelected == "Toggle" then Sub2keybind:Press()
                    elseif Sub2keybind.ModeSelected == "Hold" then Sub2keybind:Press(true)
                    elseif Sub2keybind.ModeSelected == "Always" then Sub2keybind:Press(true) end
                end
            end)
            Library:Connect(UserInputService.InputEnded, function(Input)
                if Sub2keybind.Value == "None" then return end
                if tostring(Input.KeyCode) == Sub2keybind.Key or tostring(Input.UserInputType) == Sub2keybind.Key then
                    if Sub2keybind.ModeSelected == "Hold" then Sub2keybind:Press(false)
                    elseif Sub2keybind.ModeSelected == "Always" then Sub2keybind:Press(true) end
                end
            end)

            if Sub2keybind.Default then Sub2keybind:Set({ Mode = Data.Mode or "Toggle", Key = Sub2keybind.Default }) end
            Library.SetFlags[Sub2keybind.Flag] = function(Value) Sub2keybind:Set(Value) end

            Sub2keybind.Section.Elements[#Sub2keybind.Section.Elements+1] = Sub2keybind
            return Sub2keybind
        end

        Library.Sections.Textbox = function(self, Data)
            Data = Data or { }

            local Textbox = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or "",
                Callback = Data.Callback or Data.callback or function() end,
                Placeholder = Data.Placeholder or Data.placeholder or "Placeholder",
                Numeric = Data.Numeric or Data.numeric or false,
                Finished = Data.Finished or Data.finished or false,

                Value = ""
            }

            local Items = { } do 
                Items["Textbox"] = Instances:Create("Frame", {
                    Parent = Textbox.Section.Items["Content"].Instance,
                    Name = "\0",
                    Active = true,
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    Selectable = true,
                    Size = UDim2New(1, 0, 0, 48),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 26, 29)
                }) 
                
                Instances:Create("UICorner", {
                    Parent = Items["Textbox"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Items["Background"] = Instances:Create("Frame", {
                    Parent = Items["Textbox"].Instance,
                    Name = "\0",
                    Active = true,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, 0),
                    Selectable = true,
                    ZIndex = 2,
                    ClipsDescendants = true,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 26, 29)
                })  Items["Background"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Items["Input"] = Instances:Create("TextBox", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(240, 240, 240),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    ZIndex = 2,
                    Size = UDim2New(1, -20, 0, 15),
                    Position = UDim2New(0, 10, 0, 8),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    PlaceholderColor3 = FromRGB(185, 185, 185),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    PlaceholderText = Textbox.Placeholder,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Input"]:AddToTheme({TextColor3 = "Text"})               
            end
            
            function Textbox:Get()
                return Textbox.Value
            end

            function Textbox:SetVisibility(Bool)
                Items["Textbox"].Instance.Visible = Bool
            end

            function Textbox:RefreshPosition(Bool)
                if Bool then
                    Items["Background"].Instance.Position = UDim2New(0, 0, 0, 0)
                else
                    Items["Background"].Instance.Position = UDim2New(0, 30, 0, 0)
                end
            end

            function Textbox:Set(Value)
                if Textbox.Numeric then
                    if (not tonumber(Value)) and StringLen(tostring(Value)) > 0 then
                        Value = Textbox.Value
                    end
                end

                Textbox.Value = Value
                Items["Input"].Instance.Text = Value
                Library.Flags[Textbox.Flag] = Value

                if Textbox.Callback then
                    Library:SafeCall(Textbox.Callback, Value)
                end
            end

            if Textbox.Finished then 
                Items["Input"]:Connect("FocusLost", function(PressedEnterQuestionMark)
                    if PressedEnterQuestionMark then
                        Textbox:Set(Items["Input"].Instance.Text)
                    end
                end)
            else
                Library:Connect(Items["Input"].Instance:GetPropertyChangedSignal("Text"), function()
                    Textbox:Set(Items["Input"].Instance.Text)
                end)
            end

            if Textbox.Default then
                Textbox:Set(Textbox.Default)
            end

            Library.SetFlags[Textbox.Flag] = function(Value)
                Textbox:Set(Value)
            end

            Textbox.Section.Elements[#Textbox.Section.Elements+1] = Textbox
            Textbox:RefreshPosition(true)
            return Textbox
        end

        Library.Sections.Input = Library.Sections.Textbox

        Library.Sections.Listbox = function(self, Data)

            Data = Data or { }

            local Dropdown = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Items = Data.Items or Data.items or { "One", "Two", "Three" },
                Default = Data.Default or Data.default or nil,
                Callback = Data.Callback or Data.callback or function() end,
                Size = Data.Size or Data.size or 125,
                Multi = Data.Multi or Data.multi or false,

                Value = { },
                Options = { },
                IsOpen = false
            }

            local Items = { } do 
                Items["Listbox"] = Instances:Create("Frame", {
                    Parent = Dropdown.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, Dropdown.Size),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Search"] = Instances:Create("TextBox", {
                    Parent = Items["Listbox"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    CursorPosition = -1,
                    TextColor3 = FromRGB(240, 240, 240),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    ZIndex = 2,
                    Size = UDim2New(1, 0, 0, 30),
                    BorderSizePixel = 0,
                    PlaceholderColor3 = FromRGB(185, 185, 185),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    PlaceholderText = "Search..",
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(27, 26, 29)
                })  Items["Search"]:AddToTheme({TextColor3 = "Text", BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Search"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Instances:Create("UIPadding", {
                    Parent = Items["Search"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 4),
                    PaddingLeft = UDimNew(0, 8)
                })

                Items["Background"] = Instances:Create("Frame", {
                    Parent = Items["Listbox"].Instance,
                    Name = "\0",
                    Active = true,
                    Size = UDim2New(1, 0, 1, -30),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Position = UDim2New(0, 0, 0, 30),
                    BackgroundColor3 = FromRGB(27, 26, 29),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                })  Items["Background"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Items["Holder"] = Instances:Create("ScrollingFrame", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    ScrollBarImageColor3 = FromRGB(0, 0, 0),
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 2,
                    Size = UDim2New(1, -4, 1, -8),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Position = UDim2New(0, 0, 0, 4),
                    BackgroundColor3 = FromRGB(27, 26, 29),
                    ZIndex = 2,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    CanvasSize = UDim2New(0, 0, 0, 0)
                })  Items["Holder"]:AddToTheme({ScrollBarImageColor3 = "Accent"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["Holder"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 4),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                Instances:Create("UIPadding", {
                    Parent = Items["Holder"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 8),
                    PaddingBottom = UDimNew(0, 8),
                    PaddingRight = UDimNew(0, 12),
                    PaddingLeft = UDimNew(0, 8)
                })      
                
                Items["_"] = Instances:Create("Frame", {
                    Parent = Items["Listbox"].Instance,
                    Name = "\0",
                    Size = UDim2New(1, 0, 0, 10),
                    Position = UDim2New(0, 0, 0, 25),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 26, 29)
                })  Items["_"]:AddToTheme({BackgroundColor3 = "Element"})

                Instances:Create("Frame", {
                    Parent = Items["_"].Instance,
                    Name = "\0",
                    Size = UDim2New(1, 0, 0, 1),
                    Position = UDim2New(0, 0, 1, -3),
                    AnchorPoint = Vector2New(0, 1),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(27, 26, 29),
                }):AddToTheme({BackgroundColor3 = "Outline"})
            end

            function Dropdown:Get()
                return Dropdown.Value
            end

            function Dropdown:SetVisibility(Bool)
                Items["Listbox"].Instance.Visible = Bool
            end

            function Dropdown:RefreshPosition(Bool)
                if Bool then
                    Items["Background"].Instance.Position = UDim2New(0, 0, 0, 30)
                    Items["Search"].Instance.Position = UDim2New(0, 0, 0, 0)
                    Items["_"].Instance.Position = UDim2New(0, 0, 0, 25)
                else
                    Items["Background"].Instance.Position = UDim2New(0, 30, 0, 30)
                    Items["Search"].Instance.Position = UDim2New(0, 30, 0, 0)
                    Items["_"].Instance.Position = UDim2New(0, 30, 0, 25)
                end
            end

            function Dropdown:Set(Option)
                if Dropdown.Multi then 
                    if type(Option) ~= "table" then 
                        return
                    end

                    Dropdown.Value = Option
                    Library.Flags[Dropdown.Flag] = Option

                    for Index, Value in Option do
                        local OptionData = Dropdown.Options[Value]
                        
                        if not OptionData then
                            continue
                        end

                        OptionData.Selected = true 
                        OptionData:Toggle("Active")
                    end
                else
                    if not Dropdown.Options[Option] then
                        return
                    end

                    local OptionData = Dropdown.Options[Option]

                    Dropdown.Value = Option
                    Library.Flags[Dropdown.Flag] = Option

                    for Index, Value in Dropdown.Options do
                        if Value ~= OptionData then
                            Value.Selected = false 
                            Value:Toggle("Inactive")
                        else
                            Value.Selected = true 
                            Value:Toggle("Active")
                        end
                    end
                end

                if Dropdown.Callback then   
                    Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                end
            end

            function Dropdown:Add(Option)
                local OptionButton = Instances:Create("TextButton", {
                    Parent = Items["Holder"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                local OptionAccent = Instances:Create("Frame", {
                    Parent = OptionButton.Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 0.5),
                    BackgroundTransparency = 1,
                    ZIndex = 2,
                    Position = UDim2New(0, 0, 0.5, 0),
                    Size = UDim2New(0, 6, 0, 6),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIGradient", {
                    Parent = OptionAccent.Instance,
                    Name = "\0",
                    Enabled = true,
                    Rotation = -115,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(143, 143, 143))}
                }):AddToTheme({Color = function()
                    return RGBSequence{RGBSequenceKeypoint(0, Library.Theme.Accent), RGBSequenceKeypoint(1, Library.Theme.AccentGradient)}
                end})
                
                Instances:Create("UICorner", {
                    Parent = OptionAccent.Instance,
                    Name = "\0"
                })
                
                local OptionText = Instances:Create("TextLabel", {
                    Parent = OptionButton.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.30000001192092896,
                    Text = Option,
                    Size = UDim2New(0, 0, 0, 15),
                    AnchorPoint = Vector2New(0, 0.5),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  OptionText:AddToTheme({TextColor3 = "Text"})
                
                local OptionData = {
                    Button = OptionButton,
                    Name = Option,
                    OptionText = OptionText,
                    IsSearching = false,
                    OptionAccent = OptionAccent,
                    Selected = false
                }
                
                function OptionData:Toggle(Value)
                    if Value == "Active" then
                        OptionText:Tween(nil, {TextTransparency = 0, Position = UDim2New(0, 15, 0.5, 0)})
                        OptionAccent:Tween(nil, {BackgroundTransparency = 0})
                    else
                        OptionText:Tween(nil, {TextTransparency = 0.3, Position = UDim2New(0, 0, 0.5, 0)})
                        OptionAccent:Tween(nil, {BackgroundTransparency = 1})
                    end
                end

                function OptionData:Search(Bool)
                    Library:Thread(function()
                        if Bool then 
                            OptionData.IsSearching = true
                            OptionText:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1})
                            task.wait(0.08)
                            OptionButton:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2New(1, 0, 0, 0)})
                            
                            if OptionData.Selected then 
                                OptionAccent:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
                            end
                        else
                            OptionData.IsSearching = false
                            OptionText:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = OptionData.Selected and 0 or 0.3})
                            task.wait(0.08)
                            OptionButton:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2New(1, 0, 0, 20)})
                            
                            if OptionData.Selected then 
                                OptionAccent:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0})
                            end
                        end
                    end)
                end

                function OptionData:Set()
                    OptionData.Selected = not OptionData.Selected

                    if Dropdown.Multi then 
                        local Index = TableFind(Dropdown.Value, OptionData.Name)

                        if Index then 
                            TableRemove(Dropdown.Value, Index)
                        else
                            TableInsert(Dropdown.Value, OptionData.Name)
                        end

                        OptionData:Toggle(Index and "Inactive" or "Active")

                        Library.Flags[Dropdown.Flag] = Dropdown.Value
                    else
                        if OptionData.Selected then 
                            Dropdown.Value = OptionData.Name
                            Library.Flags[Dropdown.Flag] = OptionData.Name

                            OptionData.Selected = true
                            OptionData:Toggle("Active")

                            for Index, Value in Dropdown.Options do 
                                if Value ~= OptionData and not Value.IsSearching then
                                    Value.Selected = false 
                                    Value:Toggle("Inactive")
                                end
                            end
                        else
                            Dropdown.Value = nil
                            Library.Flags[Dropdown.Flag] = nil

                            OptionData.Selected = false
                            OptionData:Toggle("Inactive")
                        end
                    end

                    if Dropdown.Callback then
                        Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                    end
                end

                OptionData.Button:Connect("MouseButton1Down", function()
                    OptionData:Set()
                end)

                Dropdown.Options[OptionData.Name] = OptionData
                return OptionData
            end

            function Dropdown:Remove(Option)
                if Dropdown.Options[Option] then
                    Dropdown.Options[Option].Button:Clean()
                    Dropdown.Options[Option] = nil
                end
            end

            function Dropdown:Refresh(List)
                for Index, Value in Dropdown.Options do 
                    Dropdown:Remove(Value.Name)
                end

                for Index, Value in List do 
                    Dropdown:Add(Value)
                end
            end

            Library:Connect(Items["Search"].Instance:GetPropertyChangedSignal("Text"), function()
                Library:Thread(function()
                    for Index, Value in Dropdown.Options do
                        local InputText = Items["Search"].Instance.Text
                        if InputText ~= "" then
                            if StringFind(StringLower(Value.Name), Library:EscapePattern(StringLower(InputText))) then
                                Value.Button.Instance.Visible = true
                                Value:Search(false)
                            else
                                Value:Search(true)
                                Value.Button.Instance.Visible = false
                            end
                        else
                            Value:Search(false)
                            Value.Button.Instance.Visible = true
                        end
                    end
                end)
            end)

            for Index, Value in Dropdown.Items do 
                Dropdown:Add(Value)
            end

            if Dropdown.Default then 
                Dropdown:Set(Dropdown.Default)
            end

            Library.SetFlags[Dropdown.Flag] = function(Value)
                Dropdown:Set(Value)
            end

            Dropdown.Section.Elements[#Dropdown.Section.Elements+1] = Dropdown
            Dropdown:RefreshPosition(true)
            return Dropdown
        end
    end

    Library.CreateSettingsPage = function(self, Window, KeybindList)
        local Page = Window:Page({Name = "Settings", Icon = "122669828593160"})
        local ConfigsSection = Page:Section({Name = "Configs", Side = 1}) do 
            local ConfigSelected = nil

            local ConfigsDropdown = ConfigsSection:Listbox({
                Flag = "ConfigsList", 
                Items = { }, 
                Multi = false,
                Callback = function(Value)
                    ConfigSelected = Value
                end
            })
            
            ConfigsSection:Textbox({
                Flag = "ConfigsName",
                Placeholder = "Name",
                Numeric = false,
                Finished = false,
                Callback = function(Value)
                end
            })

            ConfigsSection:Button({
                Name = "Create",
                Callback = function()
                    local InputName = Library.Flags["ConfigsName"]
                    if InputName and InputName ~= "" then
                        if not isfolder(Library.Folders.Configs) then
                            makefolder(Library.Folders.Configs)
                        end
                        local FinalName = InputName:find(".json") and InputName or InputName .. ".json"
                        writefile(Library.Folders.Configs .. "/" .. FinalName, Library:GetConfig())
                        
                        Library:RefreshConfigsList(ConfigsDropdown)
                        Library:Notification({
                            Title = "Config",
                            Description = "Created config: " .. FinalName,
                            Duration = 2,
                            Icon = "87107896404147"
                        })
                    end
                end
            })

            ConfigsSection:Button({
                Name = "Load",
                Callback = function()
                    if ConfigSelected and isfile(Library.Folders.Configs .. "/" .. ConfigSelected) then
                        Library:LoadConfig(readfile(Library.Folders.Configs .. "/" .. ConfigSelected))
                        Library:Notification({
                            Title = "Config",
                            Description = "Loaded config: " .. ConfigSelected,
                            Duration = 2,
                            Icon = "87107896404147"
                        })
                    end
                end
            })

            ConfigsSection:Button({
                Name = "Save",
                Callback = function()
                    if ConfigSelected and isfile(Library.Folders.Configs .. "/" .. ConfigSelected) then
                        writefile(Library.Folders.Configs .. "/" .. ConfigSelected, Library:GetConfig())
                        Library:Notification({
                            Title = "Config",
                            Description = "Saved config: " .. ConfigSelected,
                            Duration = 2,
                            Icon = "87107896404147"
                        })
                    end
                end
            })

            ConfigsSection:Button({
                Name = "Refresh",
                Callback = function()
                    Library:RefreshConfigsList(ConfigsDropdown)
                    Library:Notification({
                        Title = "Config",
                        Description = "Refreshed config list",
                        Duration = 2,
                        Icon = "87107896404147"
                    })
                end
            })

            ConfigsSection:Button({
                Name = "Delete",
                Callback = function()
                    if ConfigSelected and isfile(Library.Folders.Configs .. "/" .. ConfigSelected) then
                        delfile(Library.Folders.Configs .. "/" .. ConfigSelected)
                        Library:RefreshConfigsList(ConfigsDropdown)
                        Library:Notification({
                            Title = "Config",
                            Description = "Deleted config: " .. ConfigSelected,
                            Duration = 2,
                            Icon = "87107896404147"
                        })
                        ConfigSelected = nil
                    end
                end
            })

            local AutoLoadLabel = ConfigsSection:Label("Auto Load: None")

            local function UpdateAutoLoadLabel()
                local autoLoadFile = Library.Folders.Configs .. "/autoload.txt"
                if isfile(autoLoadFile) then
                    local success, content = pcall(readfile, autoLoadFile)
                    if success and content then
                        local configName = content:match("([^/\\]+)$")
                        AutoLoadLabel:SetText("Auto Load: " .. (configName or content))
                    else
                        AutoLoadLabel:SetText("Auto Load: None")
                    end
                else
                    AutoLoadLabel:SetText("Auto Load: None")
                end
            end

            ConfigsSection:Button({
                Name = "Set Auto Load Config",
                Callback = function()
                    if ConfigSelected and isfile(Library.Folders.Configs .. "/" .. ConfigSelected) then
                        writefile(Library.Folders.Configs .. "/autoload.txt", Library.Folders.Configs .. "/" .. ConfigSelected)
                        UpdateAutoLoadLabel()
                        Library:Notification({
                            Title = "Config",
                            Description = "Auto load set to: " .. ConfigSelected,
                            Duration = 2,
                            Icon = "87107896404147"
                        })
                    end
                end
            })

            ConfigsSection:Button({
                Name = "Reset Auto Load Config",
                Callback = function()
                    local autoLoadFile = Library.Folders.Configs .. "/autoload.txt"
                    if isfile(autoLoadFile) then
                        delfile(autoLoadFile)
                    end
                    UpdateAutoLoadLabel()
                    Library:Notification({
                        Title = "Config",
                        Description = "Auto load config reset to None",
                        Duration = 2,
                        Icon = "87107896404147"
                    })
                end
            })
            
            if not isfolder(Library.Folders.Configs) then
                makefolder(Library.Folders.Configs)
            end
            Library:RefreshConfigsList(ConfigsDropdown)
            
            task.spawn(function()
                task.wait(0.1)
                UpdateAutoLoadLabel()
            end)
        end

        local UISection = Page:Section({Name = "UI Settings", Side = 2}) do
            UISection:Toggle({
                Name = "Watermark",
                Flag = "WatermarkToggle",
                Default = true,
                Callback = function(Value)
                    if Library.WatermarkFrame then
                        Library.WatermarkFrame.Instance.Visible = Value
                    end
                end
            })

            UISection:Toggle({
                Name = "Keybind List",
                Flag = "KeybindListToggle",
                Default = false,
                Callback = function(Value)
                    if KeybindList then
                        KeybindList:SetVisibility(Value)
                    end
                end
            })

            UISection:Toggle({
                Name = "Silent Load",
                Flag = "SilentLoadToggle",
                Default = (function()
                    local path = Library.Folders.Configs .. "/silentload.txt"
                    if isfile and isfile(path) then
                        local ok, content = pcall(readfile, path)
                        if ok and content == "true" then
                            return true
                        end
                    end
                    return false
                end)(),
                Callback = function(Value)
                    local path = Library.Folders.Configs .. "/silentload.txt"

                    if not isfolder(Library.Folders.Configs) then
                        makefolder(Library.Folders.Configs)
                    end

                    if Value then
                        if writefile then
                            writefile(path, "true")
                        end
                    else
                        if isfile and isfile(path) and delfile then
                            delfile(path)
                        end
                    end
                end
            })

            UISection:Button({
                Name = "Unload Script",
                Callback = function()
                    Library:Notification({
                        Title = "System",
                        Description = "Unloading script...",
                        Duration = 2,
                        Icon = "87107896404147"
                    })
                    task.wait(0.5)
                    Library:Unload()
                end
            })
        end

        local ServerSection = Page:Section({Name = "Server", Side = 2}) do
            ServerSection:Button({
                Name = "Server Hop",
                Callback = function()
                    local TeleportService = game:GetService("TeleportService")
                    local HttpService = game:GetService("HttpService")
                    local PlaceId = game.PlaceId
                    local CurrentJobId = game.JobId
                    task.spawn(function()
                        Library:Notification({Title = "Server Hop", Description = "Searching for server...", Duration = 1, Icon = "87107896404147"})
                        local ok, servers = pcall(function()
                            return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/0?sortOrder=Asc&limit=100"))
                        end)
                        if ok and servers and servers.data then
                            for _, server in servers.data do
                                if server.id ~= CurrentJobId and server.playing and server.playing < server.maxPlayers then
                                    local teleportOk = pcall(function()
                                        TeleportService:TeleportToPlaceInstance(PlaceId, server.id)
                                    end)
                                    if not teleportOk and Library and Library.Notification then
                                        Library:Notification({Title = "Server Hop", Description = "Failed to teleport.", Duration = 2, Icon = "87107896404147"})
                                    end
                                    return
                                end
                            end
                        end
                        if Library and Library.Notification then
                            Library:Notification({Title = "Server Hop", Description = "No servers available to hop to.", Duration = 2, Icon = "87107896404147"})
                        end
                    end)
                end
            })

            ServerSection:Button({
                Name = "Hop Low Server",
                Callback = function()
                    local TeleportService = game:GetService("TeleportService")
                    local HttpService = game:GetService("HttpService")
                    local PlaceId = game.PlaceId
                    local CurrentJobId = game.JobId
                    task.spawn(function()
                        Library:Notification({Title = "Hop Low Server", Description = "Searching for low population server...", Duration = 1, Icon = "87107896404147"})
                        local ok, servers = pcall(function()
                            return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/0?sortOrder=Asc&limit=100"))
                        end)
                        if ok and servers and servers.data then
                            local bestServer = nil
                            local lowestCount = 999
                            for _, server in servers.data do
                                if server.id ~= CurrentJobId and server.playing and server.playing < server.maxPlayers and server.playing < lowestCount then
                                    lowestCount = server.playing
                                    bestServer = server
                                end
                            end
                            if bestServer then
                                local teleportOk = pcall(function()
                                    TeleportService:TeleportToPlaceInstance(PlaceId, bestServer.id)
                                end)
                                if not teleportOk and Library and Library.Notification then
                                    Library:Notification({Title = "Hop Low Server", Description = "Failed to teleport.", Duration = 2, Icon = "87107896404147"})
                                end
                                return
                            end
                        end
                        if Library and Library.Notification then
                            Library:Notification({Title = "Hop Low Server", Description = "No low population servers available.", Duration = 2, Icon = "87107896404147"})
                        end
                    end)
                end
            })

            ServerSection:Button({
                Name = "Rejoin",
                Callback = function()
                    local ok, err = pcall(function()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
                    end)
                    if not ok and Library and Library.Notification then
                        Library:Notification({Title = "Rejoin", Description = "Failed to rejoin.", Duration = 2, Icon = "87107896404147"})
                    end
                end
            })
        end

        return Page
    end
end

getgenv().Library = Library

local spookilib = Library

local function ResolveIcon(icon)
    if not icon or icon == "" then return "" end
    if type(icon) == "number" then return tostring(icon) end
    return icon
end

spookilib.Options  = {}
spookilib.Toggles  = {}

local function CacheOption(flag, wrapper, isToggle)
    if not flag then return wrapper end
    if type(flag) == "string" then
        spookilib.Options[flag] = wrapper
        if isToggle then spookilib.Toggles[flag] = wrapper end
    end
    return wrapper
end

local function MakeToggleWrapper(internal, flag, callback)
    local wrappers = {}
    local userCb = callback or function() end
    local changedCbs = {}

    internal.Callback = function(val)
        pcall(userCb, val)
        for _, cb in ipairs(changedCbs) do pcall(cb, val) end
    end

    task.spawn(function() pcall(userCb, internal.Value) end)

    local w = {
        _internal = internal,
        _flag = flag,
        Value = false,
    }

    function w:SetValue(v)
        v = v or false
        internal:Set(v)
        self.Value = internal.Value
    end

    function w:OnChanged(cb)
        table.insert(changedCbs, cb)
    end

    function w:SetVisible(b)
        internal:SetVisibility(b)
    end

    setmetatable(w, {
        __tostring = function() return tostring(internal.Value) end,
        __index = function(_, k)
            if k == "Value" then return internal.Value end
            if k == "Visible" then return true end
            return rawget(w, k)
        end,
        __newindex = function(_, k, v)
            if k == "Value" then internal:Set(v) end
        end
    })

    return CacheOption(flag, w, true)
end

local function MakeSliderWrapper(internal, flag)
    local changedCbs = {}

    local origCb = internal.Callback
    internal.Callback = function(val)
        pcall(origCb, val)
        for _, cb in ipairs(changedCbs) do pcall(cb, val) end
    end

    local w = {}
    function w:SetValue(v)
        internal:Set(v)
    end
    function w:OnChanged(cb)
        table.insert(changedCbs, cb)
    end
    function w:SetVisible(b)
        internal:SetVisibility(b)
    end
    function w:GetValue()
        return internal:Get()
    end
    setmetatable(w, {
        __index = function(_, k)
            if k == "Value" then return internal:Get() end
            if k == "Visible" then return true end
            return rawget(w, k)
        end,
        __newindex = function(_, k, v)
            if k == "Value" then internal:Set(v) end
        end
    })

    return CacheOption(flag, w)
end

local function MakeDropdownWrapper(internal, flag)
    local w = {}
    function w:SetValue(v)
        internal:Set(v)
    end
    function w:GetValue()
        return internal:Get()
    end
    function w:SetValues(list)
        internal:SetItems(list or {})
    end
    function w:SetVisible(b)
        internal:SetVisibility(b)
    end
    function w:SetItems(list)
        internal:SetItems(list or {})
    end
    function w:OnChanged(cb)
        local orig = internal.Callback
        internal.Callback = function(val)
            pcall(orig, val)
            pcall(cb, val)
        end
    end
    setmetatable(w, {
        __index = function(_, k)
            if k == "Value" then return internal:Get() end
            return rawget(w, k)
        end,
        __newindex = function(_, k, v)
            if k == "Value" then internal:Set(v) end
        end
    })
    return CacheOption(flag, w)
end

local function MakeKeybindWrapper(internal, flag)
    local w = { _onClickCbs = {} }
    function w:SetValue(v)
        internal:Set(v)
    end
    function w:OnChanged(cb)
        local orig = internal.Callback
        internal.Callback = function(val)
            pcall(orig, val)
            pcall(cb, val)
        end
    end
    function w:OnClick(cb)
        table.insert(w._onClickCbs, cb)
    end
    function w:SetVisible(b)
        internal:SetVisibility(b)
    end
    setmetatable(w, {
        __index = function(_, k)
            if k == "Value" then return internal:Get() end
            if k == "Keybind" then return internal end
            return rawget(w, k)
        end,
        __newindex = function(_, k, v)
            if k == "Value" then internal:Set(v) end
        end
    })
    return CacheOption(flag, w)
end

local function MakeButtonWrapper(name)
    return { Name = name, Value = function() end }
end

local function WrapTab(jxSection)
    local tab = {}

    function tab:AddToggle(cfg, cfg2)
        if type(cfg) == "string" then

            local id = cfg
            cfg = cfg2 or {}
            cfg.Flag = cfg.Flag or cfg.flag or id
            cfg.Text = cfg.Text or cfg.Name or id
        end
        if type(cfg) ~= "table" then return end
        local flag = cfg.Flag or cfg.flag or cfg[3] or ("Toggle_" .. tostring(math.random(1,99999)))
        local default = (cfg.Default ~= nil and cfg.Default) or (cfg[2] ~= nil and cfg[2]) or false
        local cb = cfg.Callback or cfg.callback or cfg[4] or function() end
        local name = cfg.Text or cfg.Name or cfg.Title or flag
        local internal = jxSection:Toggle({
            Name = name, Flag = flag, Default = default, Callback = cb,
        })
        return MakeToggleWrapper(internal, flag, cb)
    end

    function tab:AddSlider(cfg, cfg2)
        if type(cfg) == "string" then
            local id = cfg
            cfg = cfg2 or {}
            cfg.Flag = cfg.Flag or cfg.flag or id
            cfg.Text = cfg.Text or cfg.Name or id
        end
        if type(cfg) ~= "table" then return end
        local flag = cfg.Flag or cfg.flag
        if not flag then return end
        local name = cfg.Text or cfg.Name or cfg[1] or flag
        local default = cfg.Default or cfg.Min or 0
        local min = cfg.Min or 0
        local max = cfg.Max or 100
        local rounding = cfg.Rounding or cfg.Decimals or 1
        local suffix = cfg.Suffix or ""
        local cb = cfg.Callback or cfg.callback or function() end
        local compact = cfg.Compact == true
        local internal = jxSection:Slider({
            Name = name, Flag = flag, Default = default,
            Min = min, Max = max, Suffix = suffix,
            Decimals = rounding, Callback = cb,
        })
        if compact then internal:SetVisibility(false) end
        return MakeSliderWrapper(internal, flag)
    end

    function tab:AddDropdown(cfg, cfg2)
        if type(cfg) == "string" then
            local id = cfg
            cfg = cfg2 or {}
            cfg.Flag = cfg.Flag or cfg.flag or id
            cfg.Text = cfg.Text or cfg.Name or id
        end
        if type(cfg) ~= "table" then return end
        local flag = cfg.Flag or cfg.flag
        if not flag then return end
        local name = cfg.Text or cfg.Name or cfg[1] or flag
        local values = cfg.Values or {}
        local default = cfg.Default
        local multi = cfg.Multi == true
        local searchable = cfg.Searchable == true
        local allowNull = cfg.AllowNull == true
        local cb = cfg.Callback or cfg.callback or function() end
        local internal = jxSection:Dropdown({
            Name = name, Flag = flag, Items = values,
            Default = default, Multi = multi,
            Searchable = searchable, AllowNull = allowNull,
            Callback = cb,
        })
        return MakeDropdownWrapper(internal, flag)
    end

    function tab:AddButton(cfg, cb2)
        local name, cb
        if type(cfg) == "string" then
            name, cb = cfg, cb2 or function() end
        elseif type(cfg) == "table" then
            name = cfg.Text or cfg.Name or cfg[1] or "Button"
            cb = cfg.Func or cfg.Callback or cfg.callback or cfg[2] or function() end
        else return end
        local internal = jxSection:Button({ Name = name, Callback = cb })
        return MakeButtonWrapper(name)
    end

    function tab:AddColorpicker(cfg, cfg2)
        if type(cfg) == "string" then
            local id = cfg
            cfg = cfg2 or {}
            cfg.Flag = cfg.Flag or cfg.flag or id
            cfg.Text = cfg.Text or cfg.Name or id
        end
        if type(cfg) ~= "table" then return end
        local flag = cfg.Flag or cfg.flag
        local default = cfg.Default or Color3.fromRGB(255,255,255)
        local cb = cfg.Callback or cfg.callback or function() end
        local name = cfg.Text or cfg.Name or cfg[1] or "Color"
        local internal = jxSection:Label(name):Colorpicker({
            Flag = flag, Default = default, Callback = cb,
        })
        CacheOption(flag, { Value = default, SetValue = function(v) end })
        return internal
    end

    function tab:AddKeybind(cfg, cfg2)
        if type(cfg) == "string" then
            local id = cfg
            cfg = cfg2 or {}
            cfg.Flag = cfg.Flag or cfg.flag or id
            cfg.Text = cfg.Text or cfg.Name or id
        end
        if type(cfg) ~= "table" then return end
        local flag = cfg.Flag or cfg.flag
        local default = cfg.Default or Enum.KeyCode.Unknown
        local cb = cfg.Callback or cfg.callback or function() end
        local name = cfg.Text or cfg.Name or cfg[1] or flag or "Keybind"
        local internal = jxSection:Keybind({
            Name = name, Flag = flag, Default = default, Callback = cb,
        })
        return MakeKeybindWrapper(internal, flag)
    end

    function tab:AddLabel(cfg, isRich)
        local text = (type(cfg) == "table" and (cfg[1] or cfg.Text or "")) or tostring(cfg or "")
        local lbl = jxSection:Label(text)
        local wrapper = { _instance = lbl, _pickerKeybinds = {} }

        function wrapper:AddKeyPicker(pName, pickerCfg)
            pickerCfg = pickerCfg or {}
            local default = pickerCfg.Default or "U"
            local noUI = pickerCfg.NoUI == true
            local flag = pickerCfg.Flag or pName
            local text2 = pickerCfg.Text or pName

            local kb = jxSection:Keybind({
                Name = text2, Flag = noUI and ("__picker_" .. flag) or flag,
                Default = default, NoUI = noUI, Callback = function() end,
            })
            local kbw = MakeKeybindWrapper(kb, flag)
            table.insert(wrapper._pickerKeybinds, kbw)
            return kbw
        end

        function wrapper:SetVisible(b)
            if type(lbl) == "table" and lbl.SetVisibility then
                lbl:SetVisibility(b)
            end
        end

        setmetatable(wrapper, {
            __index = function(_, k)
                if k == "Value" then return end
                if type(lbl) == "table" and lbl[k] then return lbl[k] end
                if type(lbl) == "userdata" then return rawget(wrapper, k) end
                return rawget(wrapper, k)
            end
        })
        return wrapper
    end

    function tab:AddDivider()  jxSection:Divider() end
    function tab:AddSeparator() jxSection:Divider() end

    function tab:AddSection(cfg)
        local name = type(cfg) == "table" and (cfg[1] or cfg.Name or "") or tostring(cfg or "")
        jxSection:Label("── " .. name .. " ──")
        return tab
    end

    function tab:AddParagraph(cfg)
        if type(cfg) == "table" then
            jxSection:Label((cfg[1] or cfg.Title or "") .. ": " .. (cfg[2] or cfg.Content or ""))
        end
    end

    function tab:AddButtonGroup(cfg)
        if type(cfg) == "table" then
            for _, btnCfg in ipairs(cfg) do tab:AddButton(btnCfg) end
        end
    end

    function tab:AddLeftGroupbox(gname)
        local page = jxSection.Page
        if not page then return tab end
        local s2 = page:Section({ Name = gname or "", Side = 1 })
        return WrapTab(s2)
    end
    function tab:AddRightGroupbox(gname)
        local page = jxSection.Page
        if not page then return tab end
        local s2 = page:Section({ Name = gname or "", Side = 2 })
        return WrapTab(s2)
    end

    function tab:AddLeftTabbox()
        local page = jxSection.Page
        local s1 = page:Section({ Name = "", Side = 1 })
        local tb = {}
        function tb:AddTab(tname)
            local subSec = page:Section({ Name = tname or "", Side = 1 })
            return WrapTab(subSec)
        end
        return tb
    end
    function tab:AddRightTabbox()
        local page = jxSection.Page
        local s2 = page:Section({ Name = "", Side = 2 })
        local tb = {}
        function tb:AddTab(tname)
            local subSec = page:Section({ Name = tname or "", Side = 2 })
            return WrapTab(subSec)
        end
        return tb
    end

    setmetatable(tab, {
        __index = function(_, k)
            local v = jxSection[k]
            if type(v) == "function" then
                return function(self, ...) return v(jxSection, ...) end
            end
            return v
        end
    })

    return tab
end

local function WrapWindow(jxWindow)
    local win = {}

    function win:AddTab(cfg, iconArg)
        local name, iconStr
        if type(cfg) == "table" then
            name = cfg.Name or cfg.Title or "Tab"
            iconStr = ResolveIcon(cfg.Icon or cfg.icon or "")
        else
            name = tostring(cfg or "Tab")
            iconStr = iconArg and ResolveIcon(iconArg) or ""
        end
        local page = jxWindow:Page({ Name = name, Icon = iconStr })

        -- Single control area for this tab (one place to manage controls)
        local mainSection = page:Section({ Name = name or "Controls", Side = 1 })
        local wrapped = WrapTab(mainSection)

        function wrapped:AddLeftGroupbox(gname)
            local s2 = page:Section({ Name = gname or "", Side = 1 })
            return WrapTab(s2)
        end
        function wrapped:AddRightGroupbox(gname)
            local s2 = page:Section({ Name = gname or "", Side = 2 })
            return WrapTab(s2)
        end
        function wrapped:AddLeftTabbox()
            local tb = {}
            function tb:AddTab(tname)
                local subSec = page:Section({ Name = tname or "", Side = 1 })
                return WrapTab(subSec)
            end
            return tb
        end
        function wrapped:AddRightTabbox()
            local tb = {}
            function tb:AddTab(tname)
                local subSec = page:Section({ Name = tname or "", Side = 2 })
                return WrapTab(subSec)
            end
            return tb
        end

        -- expose page for advanced use
        wrapped.Page = page
        wrapped.Section = mainSection

        return wrapped
    end

    function win:AddMinimizeButton() return {} end
    function win:AddFloatButton() return {} end

    function win:Notify(cfg, dur)
        if type(cfg) == "string" then
            spookilib:Notification({ Title = "Notification", Description = cfg, Duration = dur or 3 })
        elseif type(cfg) == "table" then
            spookilib:Notification({
                Title = cfg.Title or "Notification",
                Description = cfg.Description or cfg.Text or cfg[1] or "",
                Duration = cfg.Duration or cfg.Time or 3,
            })
        end
    end

    setmetatable(win, {
        __index = function(_, k)
            local v = jxWindow[k]
            if type(v) == "function" then
                return function(self, ...) return v(jxWindow, ...) end
            end
            return v
        end
    })
    return win
end

function spookilib:CreateWindow(cfg)
    cfg = cfg or {}
    local title    = cfg.Title or cfg.Name or "Spooki hub"
    local subtitle = cfg.Footer or cfg.SubTitle or cfg[2] or ""
    local icon     = cfg.Icon or cfg.Logo or "87107896404147"
    local font     = cfg.Font

    if cfg.NotifySide then
        spookilib:SetNotifySide(cfg.NotifySide)
    end

    if font then
        spookilib.Font = font
    end

    local jxWin = spookilib:Window({
        Name    = title,
        SubName = subtitle,
        Logo    = icon,
    })

    if cfg.Size then
        jxWin.Items["MainFrame"].Instance.Size = cfg.Size
    end

    if cfg.Center then
        jxWin:SetCenter()
    end

    jxWin:Init()

    if cfg.AutoShow then
        jxWin:SetOpen(true)
    end

    local wrapped = WrapWindow(jxWin)
    wrapped.SpookiBg = jxWin.SpookiBg
    wrapped.Items = jxWin.Items
    wrapped.Window = jxWin

    return wrapped
end

function spookilib:Notify(text, duration)
    if type(text) == "string" then
        spookilib:Notification({ Title = "Notification", Description = text, Duration = duration or 3 })
    elseif type(text) == "table" then
        spookilib:Notification(text)
    end
end

function spookilib:SetNotifySide(side)
    if spookilib.NotifHolder and spookilib.NotifHolder.Instance then
        local pos = (side == "Left") and UDim2.new(0, 15, 1, -15) or UDim2.new(1, -15, 1, -15)
        spookilib.NotifHolder.Instance.Position = pos
        spookilib.NotifHolder.Instance.AnchorPoint = (side == "Left") and Vector2.new(0, 1) or Vector2.new(1, 1)
    end
end

function spookilib:SetDPIScale(dpi)

    local scale = dpi / 100
    if spookilib.Holder and spookilib.Holder.Instance then
        local uiScale = spookilib.Holder.Instance:FindFirstChildOfClass("UIScale")
        if not uiScale then
            uiScale = Instance.new("UIScale")
            uiScale.Name = "DPI_Scale"
            uiScale.Parent = spookilib.Holder.Instance
        end
        uiScale.Scale = scale
    end
end

function spookilib:Toggle()
    if spookilib.Holder and spookilib.Holder.Instance then
        spookilib.Holder.Instance.Enabled = not spookilib.Holder.Instance.Enabled
    end
end

function spookilib:Unload()
    getgenv().SPOOKI_HUB_Running = false
    if spookilib.Holder and spookilib.Holder.Instance then
        spookilib.Holder.Instance:Destroy()
    end
    for _, conn in ipairs(spookilib.Connections or {}) do
        pcall(conn.Disconnect, conn)
    end
    spookilib.Unloaded = true
end

spookilib.KeybindFrame = {
    Visible = false,
}

spookilib.Themes = {
    Spooki  = SpookiThemePresets.Spooki,
    Dark   = SpookiThemePresets.Dark,
    Darker = SpookiThemePresets.Darker,
    Purple = SpookiThemePresets.Purple,
}

do
    local tm = {
        _library = nil,
        _folder  = "SPOOKI HUB",
        _tab     = nil,
        Themes   = spookilib.Themes,
    }
    function tm:SetLibrary(lib)          self._library = lib end
    function tm:ApplyToTab(tab)          self._tab = tab; spookilib.Flags["SpookiThemePreset"] = "Spooki" end
    function tm:SetFolder(folder)        self._folder = folder end
    function tm:GetFolder()              return self._folder end
    function tm:LoadDefault() end
    function tm:SetTheme(name)
        local preset = SpookiThemePresets[name]
        if not preset then return end
        local L = self._library or spookilib
        local mapped = {
            Accent = preset.Accent,
            AccentGradient = preset.Gradient,
            Outline = preset.Accent,
            Background = preset.Background,
            ["Background 2"] = preset.Background,
            ["Section Top"] = preset.Element,
            ["Section Background"] = preset.SectionBg,
            ["Section Background 2"] = preset.Element,
            Element = preset.Element,
            Text = Color3.fromRGB(255, 255, 255),
        }
        if L.BatchUpdate then
            L:BatchUpdate(function()
                for themeKey, color in pairs(mapped) do
                    L:ChangeTheme(themeKey, color)
                end
            end)
            if L.FlushBatchedThemes then L:FlushBatchedThemes() end
        else
            for themeKey, color in pairs(mapped) do
                L:ChangeTheme(themeKey, color)
            end
        end
        for key, val in pairs(preset) do
            L.Theme[key] = val
        end
        if spookilib.FlagDefaults then
            spookilib.FlagDefaults["SpookiThemePreset"] = name
        end
        if L.Flags then
            L.Flags["SpookiThemePreset"] = name
        end
    end
    spookilib.ThemeManager = tm
end

do
    local sm = {
        _library       = nil,
        _folder        = "SPOOKI HUB",
        _ignoreTheme   = false,
        _ignoreIndexes = {},
    }
    function sm:SetLibrary(lib)           self._library = lib end
    function sm:IgnoreThemeSettings()     self._ignoreTheme = true end
    function sm:IgnoreThemeManager()      self._ignoreTheme = true end
    function sm:SetFolder(folder)         self._folder = folder end
    function sm:SetIgnoreIndexes(list)    self._ignoreIndexes = list or {} end
    function sm:BuildConfigSection(tab) end

    function sm:LoadAutoloadConfig()
        local L = self._library or spookilib
        if L.Folders and L.Folders.Configs then
            local path = L.Folders.Configs .. "/autosave.json"
            if isfile and isfile(path) then
                pcall(function()
                    L:LoadConfig(readfile(path))
                end)
            end
        end
    end

    function sm:Save()
        local L = self._library or spookilib
        if L.Folders and L.Folders.Configs and L.Folders.Directory then
            local path = L.Folders.Configs .. "/config.json"
            pcall(function()
                if not isfolder then return end
                if not isfolder(L.Folders.Configs) then
                    pcall(makefolder, L.Folders.Configs)
                end
                writefile(path, L:GetConfig())
            end)
        end
    end

    function sm:Load()
        local L = self._library or spookilib
        if L.Folders and L.Folders.Configs then
            local path = L.Folders.Configs .. "/config.json"
            if isfile and isfile(path) then
                pcall(function()
                    L:LoadConfig(readfile(path))
                end)
            end
        end
    end

    spookilib.SaveManager = sm
end

spookilib.Save = { Theme = "Spooki" }

function spookilib:Toggle()
    if spookilib.Holder then
        spookilib.Holder.Instance.Enabled = not spookilib.Holder.Instance.Enabled
    end
end

setmetatable(spookilib, {
    __newindex = function(t, k, v)
        rawset(t, k, v)
        if k == "ToggleKeybind" and type(v) == "table" then
            local UIS = game:GetService("UserInputService")
            UIS.InputBegan:Connect(function(input, gpe)
                if gpe then return end
                local cur = rawget(spookilib, "ToggleKeybind")
                if cur and cur.Value and input.KeyCode == cur.Value then
                    spookilib:Toggle()
                end
            end)
        end
    end,
    __index = function(t, k)

        return rawget(t, k)
    end
})

getgenv().spookilib = spookilib
getgenv().redzlib  = spookilib
getgenv().Library  = spookilib

return spookilib