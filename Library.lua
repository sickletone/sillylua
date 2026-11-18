--[[

    Milenium Library
    -> Made by @finobe 
    -> Kind of got bored idk what to do with life
    -> Idk who or why this got leaked, ui was VERY popular and high in demand with customers
]]

-- Variables 
    local uis = game:GetService("UserInputService") 
    local players = game:GetService("Players") 
    local ws = game:GetService("Workspace")
    local rs = game:GetService("ReplicatedStorage")
    local http_service = game:GetService("HttpService")
    local gui_service = game:GetService("GuiService")
    local lighting = game:GetService("Lighting")
    local run = game:GetService("RunService")
    local stats = game:GetService("Stats")
    local coregui = game:GetService("CoreGui")
    local debris = game:GetService("Debris")
    local tween_service = game:GetService("TweenService")
    local sound_service = game:GetService("SoundService")

    local vec2 = Vector2.new
    local vec3 = Vector3.new
    local dim2 = UDim2.new
    local dim = UDim.new 
    local rect = Rect.new
    local cfr = CFrame.new
    local empty_cfr = cfr()
    local point_object_space = empty_cfr.PointToObjectSpace
    local angle = CFrame.Angles
    local dim_offset = UDim2.fromOffset

    local color = Color3.new
    local rgb = Color3.fromRGB
    local hex = Color3.fromHex
    local hsv = Color3.fromHSV
    local rgbseq = ColorSequence.new
    local rgbkey = ColorSequenceKeypoint.new
    local numseq = NumberSequence.new
    local numkey = NumberSequenceKeypoint.new

    local camera = ws.CurrentCamera
    local lp = players.LocalPlayer 
    local mouse = lp:GetMouse() 
    local gui_offset = gui_service:GetGuiInset().Y

    local max = math.max 
    local floor = math.floor 
    local min = math.min 
    local abs = math.abs 
    local noise = math.noise
    local rad = math.rad 
    local random = math.random 
    local pow = math.pow 
    local sin = math.sin 
    local pi = math.pi 
    local tan = math.tan 
    local atan2 = math.atan2 
    local clamp = math.clamp 

    local insert = table.insert 
    local find = table.find 
    local remove = table.remove
    local concat = table.concat
-- 

-- Library init
    local library = {
        directory = "milenium",
        folders = {
            "/fonts",
            "/configs",
        },
        flags = {},
        config_flags = {},
        connections = {},
        notifications = {notifs = {}},
        current_open = nil;

        -- Icon provider (molto.pages.dev): providers are lucide, tabler, heroicons,
        -- solar, material, fluent and phosphor. Tab/section icons can either be a
        -- Roblox asset URL/id, or a provider icon name such as "user-16-solid".
        icon_source = "https://molto.pages.dev/source.lua";
        icon_provider = "lucide";
        icon_providers = {"lucide", "tabler", "heroicons", "solar", "material", "fluent", "phosphor"};
        icon_targets = {};
        -- Editable icon defaults: a provider icon name or a Roblox asset URL.
        -- default_icon is used by window tabs, default_section_icon by sections
        -- (group boxes), and default_subtab_icon by tab-box / multi-section sub tabs.
        default_icon = "rbxassetid://6034767608";
        default_section_icon = "http://www.roblox.com/asset/?id=6022668898";
        default_subtab_icon = nil;
    }

    local themes = {
        preset = {
            accent = rgb(155, 150, 219),
            background = rgb(14, 14, 16), surface = rgb(22, 22, 24),
            text = rgb(245, 245, 245), muted = rgb(72, 72, 73),
        },
        utility = {
            accent = {BackgroundColor3 = {}, TextColor3 = {}, ImageColor3 = {}, ScrollBarImageColor3 = {}},
            background = {BackgroundColor3 = {}}, surface = {BackgroundColor3 = {}},
            text = {TextColor3 = {}}, muted = {TextColor3 = {}},
        }
    }

    library.themes = themes
    getgenv().library = library

    local keys = {
        [Enum.KeyCode.LeftShift] = "LS",
        [Enum.KeyCode.RightShift] = "RS",
        [Enum.KeyCode.LeftControl] = "LC",
        [Enum.KeyCode.RightControl] = "RC",
        [Enum.KeyCode.Insert] = "INS",
        [Enum.KeyCode.Backspace] = "BS",
        [Enum.KeyCode.Return] = "Ent",
        [Enum.KeyCode.LeftAlt] = "LA",
        [Enum.KeyCode.RightAlt] = "RA",
        [Enum.KeyCode.CapsLock] = "CAPS",
        [Enum.KeyCode.One] = "1",
        [Enum.KeyCode.Two] = "2",
        [Enum.KeyCode.Three] = "3",
        [Enum.KeyCode.Four] = "4",
        [Enum.KeyCode.Five] = "5",
        [Enum.KeyCode.Six] = "6",
        [Enum.KeyCode.Seven] = "7",
        [Enum.KeyCode.Eight] = "8",
        [Enum.KeyCode.Nine] = "9",
        [Enum.KeyCode.Zero] = "0",
        [Enum.KeyCode.KeypadOne] = "Num1",
        [Enum.KeyCode.KeypadTwo] = "Num2",
        [Enum.KeyCode.KeypadThree] = "Num3",
        [Enum.KeyCode.KeypadFour] = "Num4",
        [Enum.KeyCode.KeypadFive] = "Num5",
        [Enum.KeyCode.KeypadSix] = "Num6",
        [Enum.KeyCode.KeypadSeven] = "Num7",
        [Enum.KeyCode.KeypadEight] = "Num8",
        [Enum.KeyCode.KeypadNine] = "Num9",
        [Enum.KeyCode.KeypadZero] = "Num0",
        [Enum.KeyCode.Minus] = "-",
        [Enum.KeyCode.Equals] = "=",
        [Enum.KeyCode.Tilde] = "~",
        [Enum.KeyCode.LeftBracket] = "[",
        [Enum.KeyCode.RightBracket] = "]",
        [Enum.KeyCode.RightParenthesis] = ")",
        [Enum.KeyCode.LeftParenthesis] = "(",
        [Enum.KeyCode.Semicolon] = ",",
        [Enum.KeyCode.Quote] = "'",
        [Enum.KeyCode.BackSlash] = "\\",
        [Enum.KeyCode.Comma] = ",",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Slash] = "/",
        [Enum.KeyCode.Asterisk] = "*",
        [Enum.KeyCode.Plus] = "+",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Backquote] = "`",
        [Enum.UserInputType.MouseButton1] = "MB1",
        [Enum.UserInputType.MouseButton2] = "MB2",
        [Enum.UserInputType.MouseButton3] = "MB3",
        [Enum.KeyCode.Escape] = "ESC",
        [Enum.KeyCode.Space] = "SPC",
    }
        
    library.__index = library

    for _, path in next, library.folders do 
        makefolder(library.directory .. path)
    end

    local flags = library.flags 
    local config_flags = library.config_flags
    local notifications = library.notifications 

    local fonts = {}; do
        function Register_Font(Name, Weight, Style, Asset)
            if not isfile(Asset.Id) then
                writefile(Asset.Id, Asset.Font)
            end

            if isfile(Name .. ".font") then
                delfile(Name .. ".font")
            end

            local Data = {
                name = Name,
                faces = {
                    {
                        name = "Normal",
                        weight = Weight,
                        style = Style,
                        assetId = getcustomasset(Asset.Id),
                    },
                },
            }

            writefile(Name .. ".font", http_service:JSONEncode(Data))

            return getcustomasset(Name .. ".font");
        end
        
        local Medium = Register_Font("Medium", 200, "Normal", {
            Id = "Medium.ttf",
            Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/Inter_28pt-Medium.ttf"),
        })

        local SemiBold = Register_Font("SemiBold", 200, "Normal", {
            Id = "SemiBold.ttf",
            Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/Inter_28pt-SemiBold.ttf"),
        })

        fonts = {
            small = Font.new(Medium, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
            font = Font.new(SemiBold, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
        }
    end
--

-- Library functions 
    -- Misc functions
        function library:tween(obj, properties, easing_style, time) 
            local tween = tween_service:Create(obj, TweenInfo.new(time or 0.25, easing_style or Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false, 0), properties):Play()
                
            return tween
        end

        library.resize_handles = {}

        function library:set_resize_handles_visible(shown)
            for _, handle in ipairs(library.resize_handles) do
                handle.Visible = shown and true or false
            end
        end

        function library:resizify(frame, min_width, min_height, on_resize)
            min_width = min_width or 320
            min_height = min_height or 300

            local handle = Instance.new("TextButton")
            handle.Name = "ResizeHandle"
            handle.AnchorPoint = vec2(1, 1)
            handle.Position = dim2(1, -4, 1, -4)
            handle.Size = dim2(0, 18, 0, 18)
            handle.BorderSizePixel = 0
            handle.BackgroundTransparency = 1
            handle.Text = ""
            handle.AutoButtonColor = false
            handle.ZIndex = 30
            handle.Parent = frame
            insert(library.resize_handles, handle)

            -- Always-visible corner grip (three diagonal ticks).
            local grip_lines = {}
            for index = 1, 3 do
                local line = library:create("Frame", {
                    Parent = handle;
                    AnchorPoint = vec2(1, 1);
                    Position = dim2(1, -1 - (index - 1) * 4, 1, -1);
                    Size = dim2(0, 5 + index * 3, 0, 1);
                    Rotation = 45;
                    BackgroundColor3 = rgb(120, 120, 126);
                    BorderSizePixel = 0;
                    ZIndex = 31;
                })
                insert(grip_lines, line)
            end

            handle.MouseEnter:Connect(function()
                for _, line in ipairs(grip_lines) do
                    library:tween(line, {BackgroundColor3 = themes.preset.accent}, Enum.EasingStyle.Quad, 0.15)
                end
            end)
            handle.MouseLeave:Connect(function()
                for _, line in ipairs(grip_lines) do
                    library:tween(line, {BackgroundColor3 = rgb(120, 120, 126)}, Enum.EasingStyle.Quad, 0.15)
                end
            end)

            local resizing, drag_type, start, start_size = false, nil, nil, nil
            local function update_size(position)
                if not resizing or not start_size then return end
                local viewport = (ws.CurrentCamera or camera).ViewportSize
                local scale_object = frame:FindFirstChildOfClass("UIScale")
                local scale = scale_object and scale_object.Scale or 1
                if scale <= 0 then scale = 1 end

                -- Keep the resize 1:1 with the cursor, even when the window is scaled.
                local max_width = max(min_width, (viewport.X - frame.AbsolutePosition.X) / scale)
                local max_height = max(min_height, (viewport.Y - frame.AbsolutePosition.Y) / scale)
                local width = clamp(start_size.X.Offset + (position.X - start.X) / scale, min_width, max_width)
                local height = clamp(start_size.Y.Offset + (position.Y - start.Y) / scale, min_height, max_height)

                if on_resize then
                    on_resize(width, height)
                else
                    frame.Size = dim2(0, width, 0, height)
                end
            end
            handle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    resizing, drag_type = true, input.UserInputType
                    start, start_size = input.Position, frame.Size
                end
            end)
            library:connection(uis.InputChanged, function(input)
                if resizing and ((drag_type == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseMovement)
                    or (drag_type == Enum.UserInputType.Touch and input.UserInputType == Enum.UserInputType.Touch)) then
                    update_size(input.Position)
                end
            end)
            library:connection(uis.InputEnded, function(input)
                if resizing and (input.UserInputType == drag_type or input.UserInputType == Enum.UserInputType.MouseButton1) then resizing, drag_type = false, nil end
            end)
        end

        function fag(tbl)
            local Size = 0
            
            for _ in tbl do
                Size = Size + 1
            end
        
            return Size
        end
        
        function library:next_flag()
            local index = fag(library.flags) + 1;
            local str = string.format("flagnumber%s", index)
            
            return str;
        end 

        function library:mouse_in_frame(uiobject)
            local y_cond = uiobject.AbsolutePosition.Y <= mouse.Y and mouse.Y <= uiobject.AbsolutePosition.Y + uiobject.AbsoluteSize.Y
            local x_cond = uiobject.AbsolutePosition.X <= mouse.X and mouse.X <= uiobject.AbsolutePosition.X + uiobject.AbsoluteSize.X

            return (y_cond and x_cond)
        end

        function library:draggify(frame, header_height)
            header_height = header_height or 70
            local dragging, drag_type, origin, start = false, nil, nil, nil
            local function move_to(position)
                if not dragging then return end
                local viewport = (ws.CurrentCamera or camera).ViewportSize
                frame.Position = dim2(0, clamp(origin.X.Offset + position.X - start.X, 0, max(0, viewport.X - frame.AbsoluteSize.X)),
                    0, clamp(origin.Y.Offset + position.Y - start.Y, 0, max(0, viewport.Y - frame.AbsoluteSize.Y)))
                library:close_element()
            end
            frame.InputBegan:Connect(function(input)
                local header_input = input.Position.Y - frame.AbsolutePosition.Y <= header_height
                if header_input and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                    dragging, drag_type, start, origin = true, input.UserInputType, input.Position, frame.Position
                end
            end)
            library:connection(uis.InputChanged, function(input)
                if dragging and ((drag_type == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseMovement)
                    or (drag_type == Enum.UserInputType.Touch and input.UserInputType == Enum.UserInputType.Touch)) then
                    move_to(input.Position)
                end
            end)
            library:connection(uis.InputEnded, function(input)
                if dragging and (input.UserInputType == drag_type or input.UserInputType == Enum.UserInputType.MouseButton1) then dragging, drag_type = false, nil end
            end)
        end

        function library:convert(str)
            local values = {}

            for value in string.gmatch(str, "[^,]+") do
                insert(values, tonumber(value))
            end
            
            if #values == 4 then              
                return unpack(values)
            else 
                return
            end
        end
        
        function library:convert_enum(enum)
            local enum_parts = {}
        
            for part in string.gmatch(enum, "[%w_]+") do
                insert(enum_parts, part)
            end
        
            local enum_table = Enum
            for i = 2, #enum_parts do
                local enum_item = enum_table[enum_parts[i]]
        
                enum_table = enum_item
            end
        
            return enum_table
        end

        local config_holder
        library.config_directory = library.directory .. "/configs"
        local autoload_file = library.config_directory .. "/autoload.txt"

        function library:clean_config_name(name)
            if type(name) ~= "string" then return nil end
            name = name:gsub("%.cfg$", ""):gsub("[^%w _%-]", "")
            name = name:gsub("^%s+", ""):gsub("%s+$", "")
            return name ~= "" and name or nil
        end

        function library:config_path(name)
            name = library:clean_config_name(name)
            return name and (library.config_directory .. "/" .. name .. ".cfg") or nil
        end

        function library:update_config_list()
            if not config_holder then return {} end
            local selected = flags.config_name_list
            local list = {}
            local seen = {}
            local ok, files = pcall(listfiles, library.config_directory)
            if ok and type(files) == "table" then
                for _, file in ipairs(files) do
                    local normalized = tostring(file):gsub("\\", "/")
                    local name = normalized:match("([^/]+)$")
                    if name and name:match("%.cfg$") then
                        name = name:gsub("%.cfg$", "")
                        if not seen[name] then seen[name] = true; insert(list, name) end
                    end
                end
            end
            table.sort(list, function(a, b) return string.lower(a) < string.lower(b) end)
            config_holder.refresh_options(list)
            flags.config_name_list = selected and find(list, selected) and selected or nil
            return list
        end

        function library:get_config()
            local config = {__theme = {}}
            for theme, value in pairs(themes.preset) do config.__theme[theme] = value:ToHex() end
            for flag, value in next, flags do
                if flag ~= "config_name_list" and flag ~= "config_name_text" then
                    if type(value) == "table" and value.key then
                        config[flag] = {active = value.active, mode = value.mode, key = tostring(value.key)}
                    elseif type(value) == "table" and value.Transparency ~= nil and value.Color then
                        config[flag] = {Transparency = value.Transparency, Color = value.Color:ToHex()}
                    else
                        config[flag] = value
                    end
                end
            end
            return http_service:JSONEncode(config)
        end

        function library:load_config(config_json)
            local config = http_service:JSONDecode(config_json)
            if type(config) ~= "table" then error("Config data must be a JSON object") end
            if type(config.__theme) == "table" then
                for theme, value in pairs(config.__theme) do
                    if themes.preset[theme] and type(value) == "string" then library:update_theme(theme, hex(value)) end
                end
            end
            for flag, value in pairs(config) do
                local setter = library.config_flags[flag]
                if setter then
                    if type(value) == "table" and value.Transparency ~= nil and value.Color then
                        setter(hex(value.Color), value.Transparency)
                    else
                        setter(value)
                    end
                end
            end
            return true
        end

        function library:save_named_config(name, allow_overwrite)
            name = library:clean_config_name(name)
            local path = library:config_path(name)
            if not path then return false, "Enter a valid config name" end
            if not allow_overwrite and isfile(path) then return false, "That config already exists" end
            local ok, err = pcall(writefile, path, library:get_config())
            if not ok then return false, tostring(err) end
            flags.config_name_list = name
            library:update_config_list()
            return true, name
        end

        function library:load_named_config(name)
            local path = library:config_path(name)
            if not path or not isfile(path) then return false, "Select an existing config" end
            local ok, data = pcall(readfile, path)
            if not ok then return false, tostring(data) end
            local loaded, err = pcall(library.load_config, library, data)
            if not loaded then return false, tostring(err) end
            flags.config_name_list = library:clean_config_name(name)
            library:update_config_list()
            return true, flags.config_name_list
        end

        function library:delete_named_config(name)
            local path = library:config_path(name)
            if not path or not isfile(path) then return false, "Select an existing config" end
            local ok, err = pcall(delfile, path)
            if not ok then return false, tostring(err) end
            local clean_name = library:clean_config_name(name)
            if library.autoload_config == clean_name then library:clear_autoload() end
            if flags.config_name_list == clean_name then flags.config_name_list = nil end
            library:update_config_list()
            return true, library:clean_config_name(name)
        end

        function library:set_autoload(name)
            local path = library:config_path(name)
            if not path or not isfile(path) then return false, "Select an existing config" end
            local ok, err = pcall(writefile, autoload_file, library:clean_config_name(name))
            if not ok then return false, tostring(err) end
            library.autoload_config = library:clean_config_name(name)
            return true, library.autoload_config
        end

        function library:clear_autoload()
            if isfile(autoload_file) then
                local ok, err = pcall(delfile, autoload_file)
                if not ok then return false, tostring(err) end
            end
            library.autoload_config = nil
            return true
        end

        function library:round(number, float) 
            local multiplier = 1 / (float or 1)

            return floor(number * multiplier + 0.5) / multiplier
        end 

        function library:icon_api()
            if library._icon_api then return library._icon_api end
            if library._icon_api_failed then return nil end

            local ok, result = pcall(function()
                local source = game:HttpGet(library.icon_source)
                local chunk = loadstring(source)
                if type(chunk) ~= "function" then error("Icon provider could not be loaded") end
                return chunk()
            end)

            if ok and type(result) == "table" and type(result.SetProvider) == "function" and type(result.SetIcon) == "function" then
                library._icon_api = result
                return result
            end

            library._icon_api_failed = true
            return nil
        end

        function library:is_icon_asset(icon)
            return type(icon) == "string" and (icon:match("^rbxasset") ~= nil or icon:match("^http") ~= nil or icon:match("^asset") ~= nil)
        end

        function library:register_icon(instance, icon)
            for _, target in ipairs(library.icon_targets) do
                if target.instance == instance then
                    target.icon = icon
                    return
                end
            end
            insert(library.icon_targets, {instance = instance; icon = icon})
        end

        function library:forget_icon(instance)
            for index = #library.icon_targets, 1, -1 do
                if library.icon_targets[index].instance == instance then
                    remove(library.icon_targets, index)
                end
            end
        end

        -- Accepts either a Roblox asset ("rbxassetid://...") or a provider icon name.
        function library:apply_icon(instance, icon)
            if not instance or type(icon) ~= "string" then return instance end

            if library:is_icon_asset(icon) then
                library:forget_icon(instance)
                instance.Image = icon
                instance.ImageRectOffset = vec2(0, 0)
                instance.ImageRectSize = vec2(0, 0)
                return instance
            end

            local api = library:icon_api()
            if api then
                local ok = pcall(function()
                    api.SetProvider(library.icon_provider)
                    api.SetIcon(instance, icon)
                end)
                if ok then
                    library:register_icon(instance, icon)
                    return instance
                end
            end

            -- Keep the name around so switching provider can retry it later.
            library:register_icon(instance, icon)
            instance.Image = library.default_icon
            instance.ImageRectOffset = vec2(0, 0)
            instance.ImageRectSize = vec2(0, 0)
            return instance
        end

        function library:set_icon_provider(provider)
            library._icon_api_failed = nil
            local api = library:icon_api()
            if not api then return false, "Icon provider unavailable" end
            local ok, err = pcall(api.SetProvider, provider)
            if not ok then return false, tostring(err) end

            library.icon_provider = provider
            for index = #library.icon_targets, 1, -1 do
                local target = library.icon_targets[index]
                if not target.instance or not target.instance.Parent then
                    remove(library.icon_targets, index)
                else
                    pcall(api.SetIcon, target.instance, target.icon, provider)
                end
            end
            return true, provider
        end

        function library:apply_theme(instance, theme, property)
            themes.utility[theme] = themes.utility[theme] or {}
            themes.utility[theme][property] = themes.utility[theme][property] or {}
            insert(themes.utility[theme][property], instance)
        end

        function library:update_theme(theme, new_color)
            local properties = themes.utility[theme]
            if not properties or not themes.preset[theme] then return false end
            local old_color = themes.preset[theme]
            for property, objects in pairs(properties) do
                for index = #objects, 1, -1 do
                    local object = objects[index]
                    if not object or not object.Parent then
                        table.remove(objects, index)
                    else
                        object[property] = new_color
                    end
                end
            end
            themes.preset[theme] = new_color
            return true
        end

        function library:connection(signal, callback)
            local connection = signal:Connect(callback)
            
            insert(library.connections, connection)

            return connection 
        end

        function library:close_element(new_path) 
            local open_element = library.current_open

            if open_element and new_path ~= open_element then
                open_element.set_visible(false)
                open_element.open = false;
            end 

            if new_path ~= open_element then 
                library.current_open = new_path or nil;
            end
        end 

        -- Popup host resolution: each element records its owning window, and popup frames
        -- parent into that window's ScreenGui instead of a global one (sub window support).
        function library:set_owner_gui(gui)
            library.owner_gui = gui
        end

        function library:popup_parent()
            return library.owner_gui or library[ "items" ]
        end

        function library:create(instance, options)
            local ins = Instance.new(instance)
            for prop, value in pairs(options) do
                for theme, properties in pairs(themes.utility) do
                    local matches = themes.preset[theme] == value
                    if theme == "surface" and prop == "BackgroundColor3" then
                        matches = matches or value == rgb(25, 25, 29) or value == rgb(23, 23, 25) or value == rgb(33, 33, 35) or value == rgb(22, 22, 24) or value == rgb(19, 19, 21)
                    elseif theme == "text" and prop == "TextColor3" then
                        matches = matches or value == rgb(255, 255, 255)
                    elseif theme == "muted" and prop == "TextColor3" then
                        matches = matches or value == rgb(86, 86, 87) or value == rgb(72, 72, 73)
                    end
                    if properties[prop] and matches then insert(properties[prop], ins) end
                end
                ins[prop] = value
            end
            return ins
        end

        function library:unload_menu() 
            if library[ "items" ] then 
                library[ "items" ]:Destroy()
            end

            if library[ "other" ] then library[ "other" ]:Destroy() end
            if library[ "mobile" ] then library[ "mobile" ]:Destroy() end
            
            for index, connection in library.connections do 
                connection:Disconnect() 
                connection = nil 
            end
            
            getgenv().library = nil
            library = nil
        end 
    --
    
    -- Library element functions
        function library:window(properties)
            local cfg = { 
                suffix = properties.suffix or properties.Suffix or "tech";
                name = properties.name or properties.Name or "nebula";
                game_name = properties.gameInfo or properties.game_info or properties.GameInfo or "Milenium for Counter-Strike: Global Offensive";
                size = properties.size or properties.Size or dim2(0, 700, 0, 565);
                selected_tab = nil;
                items = {};

                tween = nil;
            }
            
            library[ "items" ] = library:create( "ScreenGui" , {
                Parent = coregui;
                Name = "\0";
                Enabled = true;
                ZIndexBehavior = Enum.ZIndexBehavior.Global;
                IgnoreGuiInset = true;
            });
            
            library[ "other" ] = library:create( "ScreenGui" , {
                Parent = coregui;
                Name = "\0";
                Enabled = false;
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                IgnoreGuiInset = true;
            });
            library[ "mobile" ] = library:create("ScreenGui", {
                Parent = coregui; Name = "MileniumMobileToggle"; Enabled = true;
                DisplayOrder = 10000; ZIndexBehavior = Enum.ZIndexBehavior.Sibling; IgnoreGuiInset = true;
            })
            library:set_owner_gui(library[ "items" ])

            local items = cfg.items; do
                items[ "main" ] = library:create( "Frame" , {
                    Parent = library[ "items" ];
                    Size = cfg.size;
                    Name = "\0";
                    Position = dim2(0.5, -cfg.size.X.Offset / 2, 0.5, -cfg.size.Y.Offset / 2);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.background
                }); library:apply_theme(items[ "main" ], "background", "BackgroundColor3"); items[ "main" ].Position = dim2(0, items[ "main" ].AbsolutePosition.X, 0, items[ "main" ].AbsolutePosition.Y)
                items[ "ui_scale" ] = library:create("UIScale", {Parent = items[ "main" ]; Scale = 1})
                
                library:create( "UICorner" , {
                    Parent = items[ "main" ];
                    CornerRadius = dim(0, 10)
                });
                
                -- Hidden storage for tab pages that are not currently open.
                items[ "cache" ] = library:create( "Frame" , {
                    Parent = library[ "items" ];
                    Name = "\0";
                    Visible = false;
                    BackgroundTransparency = 1;
                    Size = dim2(0, 0, 0, 0);
                    BorderSizePixel = 0
                });
                
                items[ "side_frame" ] = library:create( "Frame" , {
                    Parent = items[ "main" ];
                    BackgroundTransparency = 1;
                    Name = "\0";
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 196, 1, -25);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(14, 14, 16)
                });
                
                library:create( "Frame" , {
                    AnchorPoint = vec2(1, 0);
                    Parent = items[ "side_frame" ];
                    Position = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 1, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(21, 21, 23)
                });
                
                items[ "button_holder" ] = library:create( "Frame" , {
                    Parent = items[ "side_frame" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 0, 0, 60);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 1, -60);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); cfg.button_holder = items[ "button_holder" ];
                
                library:create( "UIListLayout" , {
                    Parent = items[ "button_holder" ];
                    Padding = dim(0, 5);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UIPadding" , {
                    PaddingTop = dim(0, 16);
                    PaddingBottom = dim(0, 36);
                    Parent = items[ "button_holder" ];
                    PaddingRight = dim(0, 11);
                    PaddingLeft = dim(0, 10)
                });

                local accent = themes.preset.accent
                items[ "title" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = items[ "side_frame" ];
                    Name = "\0";
                    Text = string.format('<u>%s</u><font color = "rgb(255, 255, 255)">%s</font>', cfg.name, cfg.suffix);
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 70);
                    TextColor3 = themes.preset.accent;
                    BorderSizePixel = 0;
                    RichText = true;
                    TextSize = 30;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:apply_theme(items[ "title" ], "accent", "TextColor3");
                
                items[ "multi_holder" ] = library:create( "Frame" , {
                    Parent = items[ "main" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 196, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -196, 0, 56);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); cfg.multi_holder = items[ "multi_holder" ];
                
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = items[ "multi_holder" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(21, 21, 23)
                });
                
                items[ "global_fade" ] = library:create( "Frame" , {
                    Parent = items[ "main" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 196, 0, 56);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -196, 1, -81);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(14, 14, 16);
                    ZIndex = 2;
                });                

                items[ "info" ] = library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = items[ "main" ];
                    Name = "\0";
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 25);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.surface
                }); library:apply_theme(items[ "info" ], "surface", "BackgroundColor3");
                
                library:create( "UICorner" , {
                    Parent = items[ "info" ];
                    CornerRadius = dim(0, 10)
                });
                
                items[ "grey_fill" ] = library:create( "Frame" , {
                    Name = "\0";
                    Parent = items[ "info" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 6);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(23, 23, 25)
                });
                
                items[ "game" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    Parent = items[ "info" ];
                    TextColor3 = rgb(72, 72, 73);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.game_name;
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    AnchorPoint = vec2(0, 0.5);
                    Position = dim2(0, 10, 0.5, -1);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); 
                
                items[ "other_info" ] = library:create( "TextLabel" , {
                    Parent = items[ "info" ];
                    RichText = true;
                    Name = "\0";
                    TextColor3 = themes.preset.accent;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name .. cfg.suffix;
                    Size = dim2(1, 0, 0, 0);
                    Position = dim2(1, -28, 0.5, -1);
                    AnchorPoint = vec2(1, 0.5);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Right;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    FontFace = fonts.font;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:apply_theme(items[ "other_info" ], "accent", "TextColor3");        
            end 

            do -- Dragging, resizing and an always-available mobile toggle.
                library.current_window = cfg
                library:draggify(items[ "main" ])
                library:resizify(items[ "main" ], 320, 300, function(width, height)
                    cfg:set_size(width, height, true)
                end)
                items[ "mobile_toggle" ] = library:create("TextButton", {
                    Parent = library[ "mobile" ]; Name = "ToggleMenu"; AnchorPoint = vec2(1, 1);
                    Position = dim2(1, -18, 1, -90); Size = dim2(0, 54, 0, 54);
                    BackgroundColor3 = themes.preset.accent; Text = "☰"; TextColor3 = rgb(255, 255, 255);
                    TextSize = 24; Font = Enum.Font.GothamBold; AutoButtonColor = true;
                    Visible = uis.TouchEnabled; ZIndex = 100;
                }); library:apply_theme(items[ "mobile_toggle" ], "accent", "BackgroundColor3")
                library:create("UICorner", {Parent = items[ "mobile_toggle" ]; CornerRadius = dim(1, 0)})
                local button_drag, button_start, button_origin, button_type = false, nil, nil, nil
                items[ "mobile_toggle" ].InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
                        button_drag, button_start, button_origin, button_type = true, input.Position, items[ "mobile_toggle" ].Position, input.UserInputType
                    end
                end)
                library:connection(uis.InputChanged, function(input)
                    if button_drag and ((button_type == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseMovement)
                        or (button_type == Enum.UserInputType.Touch and input.UserInputType == Enum.UserInputType.Touch)) then
                        local delta = input.Position - button_start
                        items[ "mobile_toggle" ].Position = button_origin + dim_offset(delta.X, delta.Y)
                    end
                end)
                library:connection(uis.InputEnded, function(input)
                    if button_drag and input.UserInputType == button_type then
                        local delta = input.Position - button_start
                        button_drag = false
                        if delta.Magnitude < 12 then cfg.toggle_menu(not library[ "items" ].Enabled) end
                        button_type = nil
                    end
                end)
            end

            cfg.auto_resize = properties.autoResize ~= false and properties.auto_resize ~= false
            if flags.ui_auto_resize ~= nil then cfg.auto_resize = flags.ui_auto_resize end
            cfg.design_size = cfg.size
            cfg.default_size = cfg.size
            cfg.tabs = {}
            function cfg:set_size(width, height, keep_position)
                -- Design size is scaled to fit by apply_viewport, so do not clamp it to
                -- the raw viewport here; that made resizing jump backwards on small screens.
                width = clamp(width, 320, 4096)
                height = clamp(height, 300, 4096)
                cfg.design_size = dim2(0, width, 0, height)
                cfg.apply_viewport(keep_position)
            end
            cfg.apply_viewport = function(keep_position)
                local viewport = (ws.CurrentCamera or camera).ViewportSize
                local design_width, design_height = cfg.design_size.X.Offset, cfg.design_size.Y.Offset
                local scale = 1
                if cfg.auto_resize then
                    scale = min(1, max(1, viewport.X - 24) / design_width, max(1, viewport.Y - 24) / design_height)
                else
                    scale = min(1, viewport.X / design_width, viewport.Y / design_height)
                end
                items[ "main" ].Size = dim2(0, design_width, 0, design_height)
                items[ "ui_scale" ].Scale = scale
                if not keep_position then
                    local width, height = design_width * scale, design_height * scale
                    items[ "main" ].Position = dim2(0, max(0, (viewport.X - width) / 2), 0, max(0, (viewport.Y - height) / 2))
                end
            end
            cfg.apply_viewport()
            if ws.CurrentCamera then library:connection(ws.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), function() cfg.apply_viewport() end) end

            function cfg.toggle_menu(bool)
                library[ "items" ].Enabled = bool
            end

            function cfg:select()
                library:set_owner_gui(library[ "items" ])
            end
            cfg:select()

            -- Change a sidebar tab icon by name or index, e.g.
            -- window:set_tab_icon("Setup", "user-16-solid")
            function cfg:set_tab_icon(target, icon)
                local tab = type(target) == "number" and cfg.tabs[target] or nil
                if not tab then
                    for _, candidate in ipairs(cfg.tabs) do
                        if candidate.name == target then
                            tab = candidate
                            break
                        end
                    end
                end
                if not tab or not tab.set_icon then return false end
                tab:set_icon(icon)
                return true
            end

            -- Change a sub-tab (the row above a tab's sections) icon.
            -- window:set_subtab_icon("Settings", "Interface", "sliders-horizontal")
            function cfg:set_subtab_icon(tab_target, subtab_target, icon)
                local tab = type(tab_target) == "number" and cfg.tabs[tab_target] or nil
                if not tab then
                    for _, candidate in ipairs(cfg.tabs) do
                        if candidate.name == tab_target then
                            tab = candidate
                            break
                        end
                    end
                end
                if not tab or not tab.set_subtab_icon then return false end
                return tab:set_subtab_icon(subtab_target, icon)
            end

            library:connection(uis.InputBegan, function(input, game_event)
                if game_event then return end
                if input.KeyCode == Enum.KeyCode.Insert then
                    cfg.toggle_menu(not library[ "items" ].Enabled)
                end
            end)
                
            return setmetatable(cfg, library)
        end 

        function library:tab(properties)
            properties = properties or {}
            local cfg = {
                name = properties.name or properties.Name or "visuals"; 
                icon = properties.icon or properties.Icon or library.default_icon;
                iconSize = properties.iconSize or properties.IconSize or 22;
                
                -- multi 
                tabs = properties.tabs or properties.Tabs or {"Main", "Misc.", "Settings"};
                subTabIcons = properties.subTabIcons or properties.subtabIcons or {};
                pages = {}; -- data store for multi sections
                current_multi = nil;
                
                items = {};
            } 

            -- Popups (dropdowns, colour pickers) belong to the window this tab lives in.
            if self.items and self.items[ "main" ] and self.items[ "main" ].Parent then
                library:set_owner_gui(self.items[ "main" ].Parent)
            end
            self.tabs = self.tabs or {}
            insert(self.tabs, cfg)

            local items = cfg.items; do 
                items[ "tab_holder" ] = library:create( "Frame" , {
                    Parent = self.items[ "cache" ];
                    Name = "\0";
                    Visible = false;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 196, 0, 56);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -216, 1, -101);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                -- Tab buttons 
                    items[ "button" ] = library:create( "TextButton" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = self.items[ "button_holder" ];
                        AutoButtonColor = false;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Size = dim2(1, 0, 0, 35);
                        BorderSizePixel = 0;
                        TextSize = 16;
                        BackgroundColor3 = rgb(29, 29, 29)
                    });
                    
                    items[ "icon" ] = library:create( "ImageLabel" , {
                        ImageColor3 = rgb(72, 72, 73);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = items[ "button" ];
                        AnchorPoint = vec2(0, 0.5);
                        Image = "http://www.roblox.com/asset/?id=6034767608";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 10, 0.5, 0);
                        Name = "\0";
                        Size = dim2(0, cfg.iconSize, 0, cfg.iconSize);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    }); library:apply_icon(items[ "icon" ], cfg.icon); library:apply_theme(items[ "icon" ], "accent", "ImageColor3");
                    
                    items[ "name" ] = library:create( "TextLabel" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(72, 72, 73);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = cfg.name;
                        Parent = items[ "button" ];
                        Name = "\0";
                        Size = dim2(0, 0, 1, 0);
                        Position = dim2(0, 40, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "name" ];
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "button" ];
                        CornerRadius = dim(0, 7)
                    });
                    
                    library:create( "UIStroke" , {
                        Color = rgb(23, 23, 29);
                        Parent = items[ "button" ];
                        Enabled = false;
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    });
                -- 

                -- Multi Sections
                    items[ "multi_section_button_holder" ] = library:create( "Frame" , {
                        Parent = self.items[ "cache" ];
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Visible = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "multi_section_button_holder" ];
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        FillDirection = Enum.FillDirection.Horizontal
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingTop = dim(0, 8);
                        PaddingBottom = dim(0, 7);
                        Parent = items[ "multi_section_button_holder" ];
                        PaddingRight = dim(0, 7);
                        PaddingLeft = dim(0, 7)
                    });                        

                    for _, section in cfg.tabs do
                        local section_name = type(section) == "table" and (section.name or section.Name or "Main") or tostring(section)
                        local section_icon = type(section) == "table" and (section.icon or section.Icon)
                            or cfg.subTabIcons[section_name]
                            or library.default_subtab_icon
                        if section_icon == false then section_icon = nil end
                        local section_icon_size = type(section) == "table" and (section.iconSize or section.IconSize) or 16
                        local data = {items = {}, name = section_name, icon = section_icon, owner_gui = self.items["main"] and self.items["main"].Parent or library["items"]}
                        data.tab = cfg
                        -- Sidebar tab icon (the whole window tab). Use set_subtab_icon for this row.
                        data.set_icon = function(self_or_icon, maybe_icon)
                            local icon = maybe_icon
                            if icon == nil and type(self_or_icon) == "string" then icon = self_or_icon end
                            if icon ~= nil then cfg:set_icon(icon) end
                        end

                        local multi_items = data.items; do 
                            -- Button
                                multi_items[ "button" ] = library:create( "TextButton" , {
                                    FontFace = fonts.font;
                                    TextColor3 = rgb(255, 255, 255);
                                    BorderColor3 = rgb(0, 0, 0);
                                    AutoButtonColor = false;
                                    Text = "";
                                    Parent = items[ "multi_section_button_holder" ];
                                    Name = "\0";
                                    Size = dim2(0, 0, 0, 39);
                                    BackgroundTransparency = 1;
                                    ClipsDescendants = true;
                                    BorderSizePixel = 0;
                                    AutomaticSize = Enum.AutomaticSize.X;
                                    TextSize = 16;
                                    BackgroundColor3 = rgb(25, 25, 29)
                                });
                                
                                multi_items[ "name" ] = library:create( "TextLabel" , {
                                    FontFace = fonts.font;
                                    TextColor3 = rgb(62, 62, 63);
                                    BorderColor3 = rgb(0, 0, 0);
                                    Text = section_name;
                                    Parent = multi_items[ "button" ];
                                    Name = "\0";
                                    Size = dim2(0, 0, 1, 0);
                                    BackgroundTransparency = 1;
                                    TextXAlignment = Enum.TextXAlignment.Left;
                                    BorderSizePixel = 0;
                                    AutomaticSize = Enum.AutomaticSize.XY;
                                    TextSize = 16;
                                    BackgroundColor3 = rgb(255, 255, 255)
                                });
                                
                                multi_items[ "name_padding" ] = library:create( "UIPadding" , {
                                    Parent = multi_items[ "name" ];
                                    PaddingRight = dim(0, 5);
                                    PaddingLeft = dim(0, section_icon and 27 or 5)
                                });

                                multi_items[ "icon" ] = library:create( "ImageLabel" , {
                                    Parent = multi_items[ "button" ];
                                    AnchorPoint = vec2(0, 0.5);
                                    Position = dim2(0, 0, 0.5, 0);
                                    Name = "\0";
                                    Size = dim2(0, section_icon_size, 0, section_icon_size);
                                    BackgroundTransparency = 1;
                                    Image = library.default_icon;
                                    ImageColor3 = rgb(62, 62, 63);
                                    Visible = section_icon ~= nil;
                                    BorderSizePixel = 0;
                                    BackgroundColor3 = rgb(255, 255, 255)
                                });
                                if section_icon then library:apply_icon(multi_items[ "icon" ], section_icon) end
                                
                                multi_items[ "accent" ] = library:create( "Frame" , {
                                    BorderColor3 = rgb(0, 0, 0);
                                    AnchorPoint = vec2(0, 1);
                                    Parent = multi_items[ "button" ];
                                    BackgroundTransparency = 1;
                                    Position = dim2(0, 10, 1, 4);
                                    Name = "\0";
                                    Size = dim2(1, -20, 0, 6);
                                    BorderSizePixel = 0;
                                    BackgroundColor3 = themes.preset.accent
                                }); library:apply_theme(multi_items[ "accent" ], "accent", "BackgroundColor3");
                                
                                library:create( "UICorner" , {
                                    Parent = multi_items[ "accent" ];
                                    CornerRadius = dim(0, 999)
                                });
                                
                                library:create( "UIPadding" , {
                                    Parent = multi_items[ "button" ];
                                    PaddingRight = dim(0, 10);
                                    PaddingLeft = dim(0, 10)
                                });
                                
                                library:create( "UICorner" , {
                                    Parent = multi_items[ "button" ];
                                    CornerRadius = dim(0, 7)
                                }); 
                            --

                            -- Tab 
                                multi_items[ "tab" ] = library:create( "Frame" , {
                                    Parent = self.items[ "cache" ];
                                    BackgroundTransparency = 1;
                                    Name = "\0";
                                    BorderColor3 = rgb(0, 0, 0);
                                    Size = dim2(1, -20, 1, -20);
                                    BorderSizePixel = 0;
                                    Visible = false;
                                    BackgroundColor3 = rgb(255, 255, 255)
                                });
                                
                                library:create( "UIListLayout" , {
                                    FillDirection = Enum.FillDirection.Vertical;
                                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                                    Parent = multi_items[ "tab" ];
                                    Padding = dim(0, 7);
                                    SortOrder = Enum.SortOrder.LayoutOrder;
                                    VerticalFlex = Enum.UIFlexAlignment.Fill
                                });
                                
                                library:create( "UIPadding" , {
                                    PaddingTop = dim(0, 7);
                                    PaddingBottom = dim(0, 7);
                                    Parent = multi_items[ "tab" ];
                                    PaddingRight = dim(0, 7);
                                    PaddingLeft = dim(0, 7)
                                });
                            --
                        end

                        data.text = multi_items[ "name" ]
                        data.accent = multi_items[ "accent" ]
                        data.button = multi_items[ "button" ]
                        data.page = multi_items[ "tab" ]
                        data.parent = setmetatable(data, library):sub_tab({}).items[ "tab_parent" ]

                        -- Change this sub-tab's icon; accepts a provider name or asset URL.
                        function data.set_subtab_icon(self_or_icon, maybe_icon)
                            local icon = maybe_icon
                            if icon == nil and type(self_or_icon) == "string" then icon = self_or_icon end
                            if icon == false then
                                data.icon = nil
                                multi_items[ "icon" ].Visible = false
                                multi_items[ "name_padding" ].PaddingLeft = dim(0, 5)
                                return data
                            end
                            if type(icon) ~= "string" then return data end
                            data.icon = icon
                            multi_items[ "icon" ].Visible = true
                            multi_items[ "name_padding" ].PaddingLeft = dim(0, 27)
                            library:apply_icon(multi_items[ "icon" ], icon)
                            multi_items[ "icon" ].ImageColor3 = cfg.current_multi == data and themes.preset.accent or rgb(62, 62, 63)
                            return data
                        end
                        
                        -- Old column code
                        -- data.left = multi_items[ "left" ]
                        -- data.right = multi_items[ "right" ]

						function data.open_page()
							local page = cfg.current_multi; 
                            
                            if page and page.text ~= data.text then 
                                self.items[ "global_fade" ].BackgroundTransparency = 0
                                library:tween(self.items[ "global_fade" ], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
                                
                                local old_size = page.page.Size
                                page.page.Size = dim2(1, -20, 1, -20)
                            end

                            if page then
                                library:tween(page.text, {TextColor3 = rgb(62, 62, 63)})
                                library:tween(page.accent, {BackgroundTransparency = 1})
                                library:tween(page.button, {BackgroundTransparency = 1})
                                if page.items["icon"] then library:tween(page.items["icon"], {ImageColor3 = rgb(62, 62, 63)}) end

                                page.page.Visible = false
                                page.page.Parent = self.items[ "cache" ]
                            end 
                            
                            library:tween(data.text, {TextColor3 = rgb(255, 255, 255)})
                            library:tween(data.accent, {BackgroundTransparency = 0})
                            library:tween(data.button, {BackgroundTransparency = 0})
                            if multi_items["icon"] then library:tween(multi_items["icon"], {ImageColor3 = themes.preset.accent}) end
                            library:tween(data.page, {Size = dim2(1, 0, 1, 0)}, Enum.EasingStyle.Quad, 0.4)

                            data.page.Visible = true
                            data.page.Parent = items["tab_holder"]

                            cfg.current_multi = data

                            library:close_element()
						end

						multi_items[ "button" ].Activated:Connect(function()
							data.open_page() 
						end)

						cfg.pages[#cfg.pages + 1] = setmetatable(data, library)
                    end 

                    if cfg.pages[1] then cfg.pages[1].open_page() end
                --
            end 

            function cfg.open_tab() 
                local selected_tab = self.selected_tab
                
                if selected_tab then 
                    if selected_tab[ 4 ] ~= items[ "tab_holder" ] then 
                        self.items[ "global_fade" ].BackgroundTransparency = 0
                        
                        library:tween(self.items[ "global_fade" ], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
                        selected_tab[ 4 ].Size = dim2(1, -216, 1, -101)
                    end

                    library:tween(selected_tab[ 1 ], {BackgroundTransparency = 1})
                    library:tween(selected_tab[ 2 ], {ImageColor3 = rgb(72, 72, 73)})
                    library:tween(selected_tab[ 3 ], {TextColor3 = rgb(72, 72, 73)})

                    selected_tab[ 4 ].Visible = false
                    selected_tab[ 4 ].Parent = self.items[ "cache" ]
                    selected_tab[ 5 ].Visible = false
                    selected_tab[ 5 ].Parent = self.items[ "cache" ]
                end

                library:tween(items[ "button" ], {BackgroundTransparency = 0})
                library:tween(items[ "icon" ], {ImageColor3 = themes.preset.accent})
                library:tween(items[ "name" ], {TextColor3 = rgb(255, 255, 255)})
                library:tween(items[ "tab_holder" ], {Size = dim2(1, -196, 1, -81)}, Enum.EasingStyle.Quad, 0.4)
                
                items[ "tab_holder" ].Visible = true 
                items[ "tab_holder" ].Parent = self.items[ "main" ]
                items[ "multi_section_button_holder" ].Visible = true 
                items[ "multi_section_button_holder" ].Parent = self.items[ "multi_holder" ]

                self.selected_tab = {
                    items[ "button" ];
                    items[ "icon" ];
                    items[ "name" ];
                    items[ "tab_holder" ];
                    items[ "multi_section_button_holder" ];
                }

                library:close_element()
            end

            -- Change one of this tab's sub-tab icons by name or index.
            function cfg:set_subtab_icon(target, icon)
                local page = type(target) == "number" and cfg.pages[target] or nil
                if not page then
                    for _, candidate in ipairs(cfg.pages) do
                        if candidate.name == target then
                            page = candidate
                            break
                        end
                    end
                end
                if not page or not page.set_subtab_icon then return false end
                page:set_subtab_icon(icon)
                return true
            end

            -- Change this tab's icon at runtime. Accepts a provider icon name
            -- ("user-16-solid") or a Roblox asset ("rbxassetid://...").
            function cfg:set_icon(icon)
                cfg.icon = icon
                library:apply_icon(items[ "icon" ], icon)
            end

            items[ "button" ].Activated:Connect(function()
                cfg.open_tab()
            end)
            
            if not self.selected_tab then 
                cfg.open_tab(true) 
            end

            return unpack(cfg.pages)
        end

        function library:seperator(properties)
            local cfg = {items = {}, name = properties.Name or properties.name or "General"}

            local items = cfg.items do 
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(72, 72, 73);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = self.items[ "button_holder" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    Position = dim2(0, 40, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0; 
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });                
            end;    

            return setmetatable(cfg, library)
        end 

        -- Miscellaneous 
            function library:column(properties) 
                local cfg = {items = {}, size = properties.size or 1, owner_gui = self.owner_gui or library:popup_parent()}

                local items = cfg.items; do     
                    items[ "column" ] = library:create( "Frame" , {
                        Parent = self[ "parent" ] or self.items["tab_parent"];
                        BackgroundTransparency = 1;
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 0, cfg.size, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingBottom = dim(0, 10);
                        Parent = items[ "column" ]
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "column" ];
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        Padding = dim(0, 10);
                        FillDirection = Enum.FillDirection.Vertical;
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                end 

                return setmetatable(cfg, library)
            end 

            function library:sub_tab(properties) 
                local cfg = {items = {}, order = properties.order or 0; size = properties.size or 1}

                local items = cfg.items; do 
                    items[ "tab_parent" ] = library:create( "Frame" , {
                        Parent = self.items[ "tab" ];
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Size = dim2(0,0,cfg.size,0);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        Visible = true;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        VerticalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = items[ "tab_parent" ];
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                    });
                end

                return setmetatable(cfg, library)
            end 
        --

        function library:section(properties)
            local cfg = {
                name = properties.name or properties.Name or "section"; 
                side = properties.side or properties.Side or "left";
                default = properties.default or properties.Default or false;
                size = properties.size or properties.Size or self.size or 0.5; 
                icon = properties.icon or properties.Icon or library.default_section_icon;
                iconSize = properties.iconSize or properties.IconSize or 22;
                fading_toggle = properties.fading or properties.Fading or false;
                owner_gui = self.owner_gui or library:popup_parent();
                items = {};
            };
            
            local items = cfg.items; do 
                items[ "outline" ] = library:create( "Frame" , {
                    Name = "\0";
                    Parent = self.items[ "column" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, cfg.size, -3);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(25, 25, 29)
                });

                library:create( "UICorner" , {
                    Parent = items[ "outline" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "inline" ] = library:create( "Frame" , {
                    Parent = items[ "outline" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(22, 22, 24)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "inline" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "scrolling" ] = library:create( "ScrollingFrame" , {
                    ScrollBarImageColor3 = rgb(44, 44, 46);
                    Active = true;
                    AutomaticCanvasSize = Enum.AutomaticSize.Y;
                    ScrollBarThickness = 2;
                    Parent = items[ "inline" ];
                    Name = "\0";
                    Size = dim2(1, 0, 1, -40);
                    BackgroundTransparency = 1;
                    Position = dim2(0, 0, 0, 35);
                    BackgroundColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    CanvasSize = dim2(0, 0, 0, 0)
                });
                
                items[ "elements" ] = library:create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = items[ "scrolling" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 10, 0, 10);
                    Size = dim2(1, -20, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "elements" ];
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UIPadding" , {
                    PaddingBottom = dim(0, 15);
                    Parent = items[ "elements" ]
                });
                
                items[ "button" ] = library:create( "TextButton" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    AutoButtonColor = false;
                    Parent = items[ "outline" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    Size = dim2(1, -2, 0, 35);
                    BorderSizePixel = 0;
                    TextSize = 16;
                    BackgroundColor3 = rgb(19, 19, 21)
                });
                
                library:create( "UIStroke" , {
                    Color = rgb(23, 23, 29);
                    Parent = items[ "button" ];
                    Enabled = false;
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "button" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "Icon" ] = library:create( "ImageLabel" , {
                    ImageColor3 = themes.preset.accent;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = items[ "button" ];
                    AnchorPoint = vec2(0, 0.5);
                    Image = cfg.icon;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 10, 0.5, 0);
                    Name = "\0";
                    Size = dim2(0, cfg.iconSize, 0, cfg.iconSize);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:apply_icon(items[ "Icon" ], cfg.icon); library:apply_theme(items[ "Icon" ], "accent", "ImageColor3");
                
                items[ "section_title" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "button" ];
                    Name = "\0";
                    Size = dim2(0, 0, 1, 0);
                    Position = dim2(0, 40, 0, -1);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = items[ "button" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
                
                if cfg.fading_toggle then 
                    items[ "toggle" ] = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        AutoButtonColor = false;
                        Text = "";
                        AnchorPoint = vec2(1, 0.5);
                        Parent = items[ "button" ];
                        Name = "\0";
                        Position = dim2(1, -9, 0.5, 0);
                        Size = dim2(0, 36, 0, 18);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(58, 58, 62)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "toggle" ];
                        CornerRadius = dim(0, 999)
                    });
                    
                    items[ "toggle_outline" ] = library:create( "Frame" , {
                        Parent = items[ "toggle" ];
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        BorderMode = Enum.BorderMode.Inset;
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(0, 1, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(50, 50, 50)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "toggle_outline" ];
                        CornerRadius = dim(0, 999)
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))};
                        Parent = items[ "toggle_outline" ]
                    });
                    
                    items[ "toggle_circle" ] = library:create( "Frame" , {
                        Parent = items[ "toggle_outline" ];
                        Name = "\0";
                        Position = dim2(0, 2, 0, 2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 12, 0, 12);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(86, 86, 88)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "toggle_circle" ];
                        CornerRadius = dim(0, 999)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "outline" ];
                        CornerRadius = dim(0, 7)
                    });
                
                    items[ "fade" ] = library:create( "Frame" , {
                        Parent = items[ "outline" ];
                        BackgroundTransparency = 0.800000011920929;
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "fade" ];
                        CornerRadius = dim(0, 7)
                    });
                end 
            end;

            if cfg.fading_toggle then
                items[ "button" ].Activated:Connect(function()
                    cfg.default = not cfg.default 
                    cfg.toggle_section(cfg.default) 
                end)

                function cfg.toggle_section(bool)
                    library:tween(items[ "toggle" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(58, 58, 62)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "toggle_outline" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(50, 50, 50)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "toggle_circle" ], {BackgroundColor3 = bool and rgb(255, 255, 255) or rgb(86, 86, 88), Position = bool and dim2(1, -14, 0, 2) or dim2(0, 2, 0, 2)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "fade" ], {BackgroundTransparency = bool and 1 or 0.8}, Enum.EasingStyle.Quad)
                end 
                cfg.toggle_section(cfg.default)
            end 

            function cfg:set_icon(icon)
                cfg.icon = icon
                library:apply_icon(items[ "Icon" ], icon)
            end

            return setmetatable(cfg, library)
        end  

        function library:toggle(options) 
            local kind = options.type or options.kind
            if type(kind) == "string" then
                kind = string.lower(kind)
                if kind == "box" or kind == "check" or kind == "checkbox" then
                    kind = "checkbox"
                elseif kind == "switch" or kind == "toggle" then
                    kind = "toggle"
                else
                    kind = nil
                end
            else
                kind = nil
            end
            if not kind then
                kind = (options.box or options.checkbox) and "checkbox" or "toggle"
            end

            local cfg = {
                enabled = options.enabled or nil,
                name = options.name or "Toggle",
                info = options.info or nil,
                flag = options.flag or library:next_flag(),
                
                type = kind; -- "toggle" (switch) or "checkbox" (box)

                default = options.default or options.enabled or false,
                folding = options.folding or false, 
                callback = options.callback or function() end,

                items = {};
                seperator = options.seperator or options.Seperator or false;
            }

            flags[cfg.flag] = cfg.default

            local items = cfg.items; do
                items[ "toggle" ] = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "toggle" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                if cfg.info then 
                    items[ "info" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(130, 130, 130);
                        BorderColor3 = rgb(0, 0, 0);
                        TextWrapped = true;
                        Text = cfg.info;
                        Parent = items[ "toggle" ];
                        Name = "\0";
                        Position = dim2(0, 5, 0, 17);
                        Size = dim2(1, -10, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                end 
                
                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                items[ "right_components" ] = library:create( "Frame" , {
                    Parent = items[ "toggle" ];
                    Name = "\0";
                    Position = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    Parent = items[ "right_components" ];
                    Padding = dim(0, 9);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                -- Toggle
                    if cfg.type == "checkbox" then 
                        items[ "toggle_button" ] = library:create( "TextButton" , {
                            FontFace = fonts.small;
                            TextColor3 = rgb(0, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = "";
                            LayoutOrder = 2;
                            AutoButtonColor = false;
                            AnchorPoint = vec2(1, 0);
                            Parent = items[ "right_components" ];
                            Name = "\0";
                            Position = dim2(1, 0, 0, 0);
                            Size = dim2(0, 16, 0, 16);
                            BorderSizePixel = 0;
                            TextSize = 14;
                            BackgroundColor3 = rgb(67, 67, 68)
                        });
                        
                        library:create( "UICorner" , {
                            Parent = items[ "toggle_button" ];
                            CornerRadius = dim(0, 4)
                        });
                        
                        items[ "outline" ] = library:create( "Frame" , {
                            Parent = items[ "toggle_button" ];
                            Size = dim2(1, -2, 1, -2);
                            Name = "\0";
                            BorderMode = Enum.BorderMode.Inset;
                            BorderColor3 = rgb(0, 0, 0);
                            Position = dim2(0, 1, 0, 1);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(22, 22, 24)
                        });
                        
                        items[ "tick" ] = library:create( "ImageLabel" , {
                            ImageTransparency = 1;
                            BorderColor3 = rgb(0, 0, 0);
                            Image = "rbxassetid://111862698467575";
                            BackgroundTransparency = 1;
                            Position = dim2(0, -1, 0, 0);
                            Parent = items[ "outline" ];
                            Size = dim2(1, 2, 1, 2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255);
                            ZIndex = 1;
                        });

                        library:create( "UICorner" , {
                            Parent = items[ "outline" ];
                            CornerRadius = dim(0, 4)
                        });
                        
                        library:create( "UIGradient" , {
                            Enabled = false;
                            Parent = items[ "outline" ];
                            Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))}
                        });  
                    else 
                        items[ "toggle_button" ] = library:create( "TextButton" , {
                            FontFace = fonts.font;
                            TextColor3 = rgb(0, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = "";
                            LayoutOrder = 2;
                            AnchorPoint = vec2(1, 0.5);
                            Parent = items[ "right_components" ];
                            Name = "\0";
                            Position = dim2(1, -9, 0.5, 0);
                            Size = dim2(0, 36, 0, 18);
                            BorderSizePixel = 0;
                            TextSize = 14;
                            BackgroundColor3 = themes.preset.accent
                        });
                        
                        library:create( "UICorner" , {
                            Parent = items[ "toggle_button" ];
                            CornerRadius = dim(0, 999)
                        });
                        
                        items[ "inline" ] = library:create( "Frame" , {
                            Parent = items[ "toggle_button" ];
                            Size = dim2(1, -2, 1, -2);
                            Name = "\0";
                            BorderMode = Enum.BorderMode.Inset;
                            BorderColor3 = rgb(0, 0, 0);
                            Position = dim2(0, 1, 0, 1);
                            BorderSizePixel = 0;
                            BackgroundColor3 = themes.preset.accent
                        });
                        
                        library:create( "UICorner" , {
                            Parent = items[ "inline" ];
                            CornerRadius = dim(0, 999)
                        });
                        
                        library:create( "UIGradient" , {
                            Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))};
                            Parent = items[ "inline" ]
                        });
                        
                        items[ "circle" ] = library:create( "Frame" , {
                            Parent = items[ "inline" ];
                            Name = "\0";
                            Position = dim2(1, -14, 0, 2);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(0, 12, 0, 12);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        library:create( "UICorner" , {
                            Parent = items[ "circle" ];
                            CornerRadius = dim(0, 999)
                        });                        
                    end 
                --                
            end;

            -- Folding toggles hide every widget created after them in the section.
            local fold_target
            if cfg.folding then
                fold_target = library:create("Frame", {
                    Parent = self.items["elements"];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                })
                library:create("UIListLayout", {
                    Parent = fold_target;
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                })
                self.items["elements"] = fold_target
            end
            
            function cfg.set(bool)
                cfg.enabled = bool
                if cfg.type == "checkbox" then 
                    library:tween(items[ "tick" ], {Rotation = bool and 0 or 45, ImageTransparency = bool and 0 or 1})
                    library:tween(items[ "toggle_button" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(67, 67, 68)})
                    library:tween(items[ "outline" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(22, 22, 24)})
                else
                    library:tween(items[ "toggle_button" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(58, 58, 62)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "inline" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(50, 50, 50)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "circle" ], {BackgroundColor3 = bool and rgb(255, 255, 255) or rgb(86, 86, 88), Position = bool and dim2(1, -14, 0, 2) or dim2(0, 2, 0, 2)}, Enum.EasingStyle.Quad)
                end

                cfg.callback(bool)

                if fold_target then
                    fold_target.Visible = bool
                end

                flags[cfg.flag] = bool
            end 
            
            items[ "toggle" ].Activated:Connect(function()
                cfg.enabled = not cfg.enabled 
                cfg.set(cfg.enabled)
            end)

            items[ "toggle_button" ].Activated:Connect(function()
                cfg.enabled = not cfg.enabled 
                cfg.set(cfg.enabled)
            end)
            
            if cfg.seperator then -- ok bro my lua either sucks or this was a pain in the ass to make (simple if statement aswell 💔)
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = self.items[ "elements" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
            end

            cfg.set(cfg.default)

            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end 
        
        function library:slider(options) 
            local cfg = {
                name = options.name or nil,
                suffix = options.suffix or "",
                flag = options.flag or library:next_flag(),
                callback = options.callback or function() end, 
                info = options.info or nil; 

                -- value settings
                min = options.min or options.minimum or 0,
                max = options.max or options.maximum or 100,
                intervals = options.interval or options.decimal or 1,
                default = options.default or 10,
                value = options.default or 10, 
                seperator = options.seperator or options.Seperator or true;

                dragging = false,
                items = {}
            } 

            flags[cfg.flag] = cfg.default

            local items = cfg.items; do
                items[ "slider_object" ] = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "slider_object" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                if cfg.info then 
                    items[ "info" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(130, 130, 130);
                        BorderColor3 = rgb(0, 0, 0);
                        TextWrapped = true;
                        Text = cfg.info;
                        Parent = items[ "slider_object" ];
                        Name = "\0";
                        Position = dim2(0, 5, 0, 37);
                        Size = dim2(1, -10, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                end 

                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                items[ "right_components" ] = library:create( "Frame" , {
                    Parent = items[ "slider_object" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 4, 0, 23);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 12);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "right_components" ];
                    Padding = dim(0, 7);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Horizontal
                });
                
                items[ "slider" ] = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    AutoButtonColor = false;
                    AnchorPoint = vec2(1, 0);
                    Parent = items[ "right_components" ];
                    Name = "\0";
                    Position = dim2(1, 0, 0, 0);
                    Size = dim2(1, -4, 0, 4);
                    BorderSizePixel = 0;
                    TextSize = 14;
                    BackgroundColor3 = rgb(33, 33, 35)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "slider" ];
                    CornerRadius = dim(0, 999)
                });
                
                items[ "fill" ] = library:create( "Frame" , {
                    Name = "\0";
                    Parent = items[ "slider" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0.5, 0, 0, 4);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                });  library:apply_theme(items[ "fill" ], "accent", "BackgroundColor3");
                
                library:create( "UICorner" , {
                    Parent = items[ "fill" ];
                    CornerRadius = dim(0, 999)
                });
                
                items[ "circle" ] = library:create( "Frame" , {
                    AnchorPoint = vec2(0.5, 0.5);
                    Parent = items[ "fill" ];
                    Name = "\0";
                    Position = dim2(1, 0, 0.5, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 12, 0, 12);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(244, 244, 244)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "circle" ];
                    CornerRadius = dim(0, 999)
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "right_components" ];
                    PaddingTop = dim(0, 4)
                });
                
                items[ "value" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(72, 72, 73);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "50%";
                    Parent = items[ "slider_object" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    Position = dim2(0, 6, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Right;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "value" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });                
            end 

            -- Double click / double tap the value to type an exact number.
            items[ "value" ].Active = true
            items[ "value" ].AnchorPoint = vec2(1, 0)
            items[ "value" ].Position = dim2(1, -6, 0, 0)
            items[ "edit" ] = library:create( "TextBox" , {
                Parent = items[ "slider_object" ];
                Name = "\0";
                AnchorPoint = vec2(1, 0);
                Position = dim2(1, -4, 0, -2);
                Size = dim2(0, 86, 0, 22);
                BackgroundTransparency = 0;
                BackgroundColor3 = themes.preset.surface;
                TextColor3 = rgb(245, 245, 245);
                Text = "";
                PlaceholderText = "value";
                FontFace = fonts.small;
                TextSize = 16;
                TextXAlignment = Enum.TextXAlignment.Right;
                ClearTextOnFocus = false;
                Visible = false;
                ZIndex = 5;
                BorderSizePixel = 0;
            });
            library:create( "UICorner" , {
                Parent = items[ "edit" ];
                CornerRadius = dim(0, 4)
            });
            library:create( "UIPadding" , {
                Parent = items[ "edit" ];
                PaddingRight = dim(0, 6);
                PaddingLeft = dim(0, 6)
            });

            cfg.editing = false
            local last_value_click = 0

            local function close_value_editor(commit)
                if not items[ "edit" ].Visible then return end
                local typed = items[ "edit" ].Text
                items[ "edit" ].Visible = false
                items[ "value" ].TextTransparency = 0
                cfg.editing = false
                if not commit then return end
                local cleaned = (tostring(typed):gsub(",", "."):gsub("[^%d%.%-]", ""))
                local number = tonumber(cleaned)
                if number then cfg.set(number) end
            end

            local function open_value_editor()
                if cfg.editing then return end
                cfg.editing = true
                items[ "value" ].TextTransparency = 1
                items[ "edit" ].Text = tostring(cfg.value)
                items[ "edit" ].Visible = true
                items[ "edit" ]:CaptureFocus()
                items[ "edit" ].CursorPosition = #items[ "edit" ].Text + 1
                items[ "edit" ].SelectionStart = 1
            end

            items[ "value" ].InputBegan:Connect(function(input)
                if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
                local now = os.clock()
                if now - last_value_click <= 0.4 then
                    last_value_click = 0
                    open_value_editor()
                else
                    last_value_click = now
                end
            end)

            items[ "edit" ].FocusLost:Connect(function()
                close_value_editor(true)
            end)

            library:connection(uis.InputBegan, function(input)
                if not cfg.editing then return end
                if input.KeyCode == Enum.KeyCode.Return or input.KeyCode == Enum.KeyCode.KeypadEnter then
                    close_value_editor(true)
                    items[ "edit" ]:ReleaseFocus()
                end
            end)

            function cfg.set(value)
                cfg.value = clamp(library:round(value, cfg.intervals), cfg.min, cfg.max)

                library:tween(items[ "fill" ], {Size = dim2((cfg.value - cfg.min) / (cfg.max - cfg.min), cfg.value == cfg.min and 0 or -4, 0, 2)}, Enum.EasingStyle.Linear, 0.05)
                items[ "value" ].Text = tostring(cfg.value) .. cfg.suffix

                flags[cfg.flag] = cfg.value
                cfg.callback(flags[cfg.flag])
            end

            local slider_input_type
            local function update_slider(position)
                local size_x = (position.X - items[ "slider" ].AbsolutePosition.X) / items[ "slider" ].AbsoluteSize.X
                cfg.set(((cfg.max - cfg.min) * size_x) + cfg.min)
            end
            items[ "slider" ].InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    cfg.dragging = true
                    slider_input_type = input.UserInputType
                    update_slider(input.Position)
                    library:tween(items[ "value" ], {TextColor3 = rgb(255, 255, 255)}, Enum.EasingStyle.Quad, 0.2)
                end
            end)
            library:connection(uis.InputChanged, function(input)
                if cfg.dragging and ((slider_input_type == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseMovement)
                    or (slider_input_type == Enum.UserInputType.Touch and input.UserInputType == Enum.UserInputType.Touch)) then
                    update_slider(input.Position)
                end
            end)

            library:connection(uis.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    cfg.dragging = false
                    slider_input_type = nil
                    library:tween(items[ "value" ], {TextColor3 = rgb(72, 72, 73)}, Enum.EasingStyle.Quad, 0.2)
                end
            end)

            if cfg.seperator then 
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = self.items[ "elements" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
            end 

            cfg.set(cfg.default)
            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end 

        function library:dropdown(options) 
            local cfg = {
                name = options.name or nil;
                info = options.info or nil;
                flag = options.flag or library:next_flag();
                options = options.items or {""};
                callback = options.callback or function() end;
                multi = options.multi or false;
                scrolling = options.scrolling or false;

                width = options.width or 130;

                -- Ignore these 
                open = false;
                option_instances = {};
                multi_items = {};
                ignore = options.ignore or false;
                items = {};
                y_size = 0;
                seperator = options.seperator or options.Seperator or true;
            }   

            cfg.default = options.default or (cfg.multi and {cfg.options[1]}) or cfg.options[1] or "None"
            flags[cfg.flag] = cfg.default

            local popup_gui = self.owner_gui or library:popup_parent()
            local items = cfg.items; do 
                -- Element
                    items[ "dropdown_object" ] = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = self.items[ "elements" ];
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    items[ "name" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(245, 245, 245);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "Dropdown";
                        Parent = items[ "dropdown_object" ];
                        Name = "\0";
                        Size = dim2(1, 0, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    if cfg.info then 
                        items[ "info" ] = library:create( "TextLabel" , {
                            FontFace = fonts.small;
                            TextColor3 = rgb(130, 130, 130);
                            BorderColor3 = rgb(0, 0, 0);
                            TextWrapped = true;
                            Text = cfg.info;
                            Parent = items[ "dropdown_object" ];
                            Name = "\0";
                            Position = dim2(0, 5, 0, 17);
                            Size = dim2(1, -10, 0, 0);
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            TextSize = 16;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                    end 

                    library:create( "UIPadding" , {
                        Parent = items[ "name" ];
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    items[ "right_components" ] = library:create( "Frame" , {
                        Parent = items[ "dropdown_object" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalAlignment = Enum.HorizontalAlignment.Right;
                        Parent = items[ "right_components" ];
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    items[ "dropdown" ] = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 0);
                        Parent = items[ "right_components" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        Size = dim2(0, cfg.width, 0, 16);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(33, 33, 35)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "dropdown" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    items[ "sub_text" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(86, 86, 87);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "awdawdawdawdawdawdawdaw";
                        Parent = items[ "dropdown" ];
                        Name = "\0";
                        Size = dim2(1, -12, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        TextTruncate = Enum.TextTruncate.AtEnd;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "sub_text" ];
                        PaddingTop = dim(0, 1);
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    items[ "indicator" ] = library:create( "ImageLabel" , {
                        ImageColor3 = rgb(86, 86, 87);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = items[ "dropdown" ];
                        AnchorPoint = vec2(1, 0.5);
                        Image = "rbxassetid://101025591575185";
                        BackgroundTransparency = 1;
                        Position = dim2(1, -5, 0.5, 0);
                        Name = "\0";
                        Size = dim2(0, 12, 0, 12);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                -- 

                -- Element Holder
                    items[ "dropdown_holder" ] = library:create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = popup_gui;
                        Name = "\0";
                        Visible = true;
                        BackgroundTransparency = 1;
                        Size = dim2(0, 0, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0);
                        ZIndex = 10;
                    });
                    
                    items[ "outline" ] = library:create( "Frame" , {
                        Parent = items[ "dropdown_holder" ];
                        Size = dim2(1, 0, 1, 0);
                        ClipsDescendants = true;
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(33, 33, 35);
                        ZIndex = 10;
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingBottom = dim(0, 6);
                        PaddingTop = dim(0, 3);
                        PaddingLeft = dim(0, 3);
                        Parent = items[ "outline" ]
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "outline" ];
                        Padding = dim(0, 5);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "outline" ];
                        CornerRadius = dim(0, 4)
                    });
                -- 
            end 

            function cfg.render_option(text)
                local button = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(72, 72, 73);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = text;
                    Parent = items[ "outline" ];
                    Name = "\0";
                    Size = dim2(1, -12, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255);
                    ZIndex = 10;
                }); library:apply_theme(button, "accent", "TextColor3");
                
                library:create( "UIPadding" , {
                    Parent = button;
                    PaddingTop = dim(0, 1);
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                return button
            end
            
            function cfg.set_visible(bool)
                local a = bool and cfg.y_size or 0
                library:tween(items[ "dropdown_holder" ], {Size = dim_offset(items[ "dropdown" ].AbsoluteSize.X, a)})

                items[ "dropdown_holder" ].Position = dim2(0, items[ "dropdown" ].AbsolutePosition.X, 0, items[ "dropdown" ].AbsolutePosition.Y + items[ "dropdown" ].AbsoluteSize.Y + 4)
                if not (self.sanity and library.current_open == self) then 
                    library:close_element(cfg)
                end
            end
            
            function cfg.set(value)
                local selected = {}
                local isTable = type(value) == "table"

                for _, option in cfg.option_instances do 
                    if option.Text == value or (isTable and find(value, option.Text)) then 
                        insert(selected, option.Text)
                        cfg.multi_items = selected
                        option.TextColor3 = themes.preset.accent
                    else
                        option.TextColor3 = rgb(72, 72, 73)
                    end
                end

                items[ "sub_text" ].Text = isTable and concat(selected, ", ") or selected[1] or ""
                flags[cfg.flag] = isTable and selected or selected[1]
                
                cfg.callback(flags[cfg.flag]) 
            end
            
            function cfg.refresh_options(list) 
                cfg.y_size = 0

                for _, option in cfg.option_instances do 
                    option:Destroy() 
                end
                
                cfg.option_instances = {} 

                for _, option in list do 
                    local button = cfg.render_option(option)
                    cfg.y_size += button.AbsoluteSize.Y + 6 -- super annoying manual sizing but oh well
                    insert(cfg.option_instances, button)
                    
                    button.Activated:Connect(function()
                        if cfg.multi then 
                            local selected_index = find(cfg.multi_items, button.Text)
                            
                            if selected_index then 
                                remove(cfg.multi_items, selected_index)
                            else
                                insert(cfg.multi_items, button.Text)
                            end
                            
                            cfg.set(cfg.multi_items) 				
                        else 
                            cfg.set_visible(false)
                            cfg.open = false 
                            
                            cfg.set(button.Text)
                        end
                    end)
                end
            end

            items[ "dropdown" ].Activated:Connect(function()
                cfg.open = not cfg.open 
                
                cfg.set_visible(cfg.open)
            end)

            if cfg.seperator then 
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = self.items[ "elements" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
            end 

            flags[cfg.flag] = {} 
            config_flags[cfg.flag] = cfg.set
            
            cfg.refresh_options(cfg.options)
            cfg.set(cfg.default)
                
            return setmetatable(cfg, library)
        end

        function library:label(options)
            local cfg = {
                enabled = options.enabled or nil,
                name = options.name or "Label",
                seperator = options.seperator or options.Seperator or false;
                info = options.info or nil; 

                items = {};
            }

            local items = cfg.items; do 
                items[ "label" ] = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "label" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                if cfg.info then 
                    items[ "info" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(130, 130, 130);
                        BorderColor3 = rgb(0, 0, 0);
                        TextWrapped = true;
                        Text = cfg.info;
                        Parent = items[ "label" ];
                        Name = "\0";
                        Position = dim2(0, 5, 0, 17);
                        Size = dim2(1, -10, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                end 
                
                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                items[ "right_components" ] = library:create( "Frame" , {
                    Parent = items[ "label" ];
                    Name = "\0";
                    Position = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    Parent = items[ "right_components" ];
                    Padding = dim(0, 9);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });                
            end 

            if cfg.seperator then 
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = self.items[ "elements" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
            end 

            return setmetatable(cfg, library)
        end 
        
        function library:colorpicker(options) 
            local cfg = {
                name = options.name or "Color", 
                flag = options.flag or library:next_flag(),

                color = options.color or color(1, 1, 1), -- Default to white color if not provided
                alpha = options.alpha and 1 - options.alpha or 0,
                
                open = false, 
                callback = options.callback or function() end,
                items = {};

                seperator = options.seperator or options.Seperator or false;
            }

            local dragging_sat = false 
            local dragging_hue = false 
            local dragging_alpha = false 

            local h, s, v = cfg.color:ToHSV() 
            local a = cfg.alpha 

            flags[cfg.flag] = {Color = cfg.color, Transparency = cfg.alpha}

            local label; 
            if not self.items.right_components then 
                label = self:label({name = cfg.name, seperator = cfg.seperator})
            end

            local popup_gui = self.owner_gui or library:popup_parent()
            local items = cfg.items; do 
                -- Component
                    items[ "colorpicker" ] = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 0);
                        Parent = label and label.items.right_components or self.items[ "right_components" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        Size = dim2(0, 16, 0, 16);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(54, 31, 184)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "colorpicker" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    items[ "colorpicker_inline" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker" ];
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        BorderMode = Enum.BorderMode.Inset;
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(0, 1, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(54, 31, 184)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "colorpicker_inline" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))};
                        Parent = items[ "colorpicker_inline" ]
                    });         
                --
                
                -- Colorpicker
                    items[ "colorpicker_holder" ] = library:create( "Frame" , {
                        Parent = library[ "other" ];
                        Name = "\0";
                        Position = dim2(0.20000000298023224, 20, 0.296999990940094, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 166, 0, 197);
                        BorderSizePixel = 0;
                        Visible = true;
                        BackgroundColor3 = rgb(25, 25, 29)
                    });

                    items[ "colorpicker_fade" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker_holder" ];
                        Name = "\0";
                        BackgroundTransparency = 0;
                        Position = dim2(0, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        ZIndex = 100;
                        BackgroundColor3 = rgb(25, 25, 29)
                    });
                    
                    items[ "colorpicker_components" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker_holder" ];
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(22, 22, 24)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "colorpicker_components" ];
                        CornerRadius = dim(0, 6)
                    });
                    
                    items[ "saturation_holder" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker_components" ];
                        Name = "\0";
                        Position = dim2(0, 7, 0, 7);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -14, 1, -80);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 39, 39)
                    });
                    
                    items[ "sat" ] = library:create( "TextButton" , {
                        Parent = items[ "saturation_holder" ];
                        Name = "\0";
                        Size = dim2(1, 0, 1, 0);
                        Text = "";
                        AutoButtonColor = false;
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "sat" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    library:create( "UIGradient" , {
                        Rotation = 270;
                        Transparency = numseq{numkey(0, 0), numkey(1, 1)};
                        Parent = items[ "sat" ];
                        Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(0, 0, 0))}
                    });
                    
                    items[ "val" ] = library:create( "Frame" , {
                        Name = "\0";
                        Parent = items[ "saturation_holder" ];
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIGradient" , {
                        Parent = items[ "val" ];
                        Transparency = numseq{numkey(0, 0), numkey(1, 1)}
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "val" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "saturation_holder" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    items[ "satvalpicker" ] = library:create( "TextButton" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AutoButtonColor = false;
                        Text = "";
                        AnchorPoint = vec2(0, 1);
                        Parent = items[ "saturation_holder" ];
                        Name = "\0";
                        Position = dim2(0, 0, 4, 0);
                        Size = dim2(0, 8, 0, 8);
                        ZIndex = 5;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 0, 0)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "satvalpicker" ];
                        CornerRadius = dim(0, 9999)
                    });
                    
                    library:create( "UIStroke" , {
                        Color = rgb(255, 255, 255);
                        Parent = items[ "satvalpicker" ];
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    });
                    
                    items[ "hue_gradient" ] = library:create( "TextButton" , {
                        Parent = items[ "colorpicker_components" ];
                        Name = "\0";
                        Position = dim2(0, 10, 1, -64);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -20, 0, 8);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255);
                        AutoButtonColor = false;
                        Text = "";
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(255, 0, 0)), rgbkey(0.17, rgb(255, 255, 0)), rgbkey(0.33, rgb(0, 255, 0)), rgbkey(0.5, rgb(0, 255, 255)), rgbkey(0.67, rgb(0, 0, 255)), rgbkey(0.83, rgb(255, 0, 255)), rgbkey(1, rgb(255, 0, 0))};
                        Parent = items[ "hue_gradient" ]
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "hue_gradient" ];
                        CornerRadius = dim(0, 6)
                    });
                    
                    items[ "hue_picker" ] = library:create( "TextButton" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AutoButtonColor = false;
                        Text = "";
                        AnchorPoint = vec2(0, 0.5);
                        Parent = items[ "hue_gradient" ];
                        Name = "\0";
                        Position = dim2(0, 0, 0.5, 0);
                        Size = dim2(0, 8, 0, 8);
                        ZIndex = 5;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 0, 0)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "hue_picker" ];
                        CornerRadius = dim(0, 9999)
                    });
                    
                    library:create( "UIStroke" , {
                        Color = rgb(255, 255, 255);
                        Parent = items[ "hue_picker" ];
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    });
                    
                    items[ "alpha_gradient" ] = library:create( "TextButton" , {
                        Parent = items[ "colorpicker_components" ];
                        Name = "\0";
                        Position = dim2(0, 10, 1, -46);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -20, 0, 8);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(25, 25, 29);
                        AutoButtonColor = false;
                        Text = "";
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "alpha_gradient" ];
                        CornerRadius = dim(0, 6)
                    });
                    
                    items[ "alpha_picker" ] = library:create( "TextButton" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AutoButtonColor = false;
                        Text = "";
                        AnchorPoint = vec2(0, 0.5);
                        Parent = items[ "alpha_gradient" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0.5, 0);
                        Size = dim2(0, 8, 0, 8);
                        ZIndex = 5;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 0, 0)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "alpha_picker" ];
                        CornerRadius = dim(0, 9999)
                    });
                    
                    library:create( "UIStroke" , {
                        Color = rgb(255, 255, 255);
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                        Parent = items[ "alpha_picker" ]
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(255, 255, 255))};
                        Parent = items[ "alpha_gradient" ]
                    });
                    
                    items[ "alpha_indicator" ] = library:create( "ImageLabel" , {
                        ScaleType = Enum.ScaleType.Tile;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = items[ "alpha_gradient" ];
                        Image = "rbxassetid://18274452449";
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Size = dim2(1, 0, 1, 0);
                        TileSize = dim2(0, 6, 0, 6);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(112, 112, 112)), rgbkey(1, rgb(255, 0, 0))};
                        Transparency = numseq{numkey(0, 0.8062499761581421), numkey(1, 0)};
                        Parent = items[ "alpha_indicator" ]
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "alpha_indicator" ];
                        CornerRadius = dim(0, 6)
                    });
                    
                    library:create( "UIGradient" , {
                        Rotation = 90;
                        Parent = items[ "colorpicker_components" ];
                        Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(66, 66, 66))}
                    });

                    items[ "input" ] = library:create( "TextBox" , {
                        FontFace = fonts.font;
                        AnchorPoint = vec2(1, 1);
                        Text = "";
                        Parent = items[ "colorpicker_components" ];
                        Name = "\0";
                        TextTruncate = Enum.TextTruncate.AtEnd;
                        BorderSizePixel = 0;
                        PlaceholderColor3 = rgb(255, 255, 255);
                        CursorPosition = -1;
                        ClearTextOnFocus = false;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255);
                        TextColor3 = rgb(72, 72, 72);
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(1, -8, 1, -11);
                        Size = dim2(1, -16, 0, 18);
                        BackgroundColor3 = rgb(33, 33, 35)
                    }); 
                    
                    library:create( "UICorner" , {
                        Parent = items[ "input" ];
                        CornerRadius = dim(0, 3)
                    });
                    
                    items[ "UICorenr" ] = library:create( "UICorner" , { -- fire misstypo (im not fixing this RAWR)
                        Parent = items[ "colorpicker_holder" ];
                        Name = "\0";
                        CornerRadius = dim(0, 4)
                    });
                --                  
            end;

            function cfg.set_visible(bool)
                items[ "colorpicker_fade" ].BackgroundTransparency = 0
                items[ "colorpicker_holder" ].Parent = bool and popup_gui or library[ "other" ]
                items[ "colorpicker_holder" ].Position = dim_offset(items[ "colorpicker" ].AbsolutePosition.X, items[ "colorpicker" ].AbsolutePosition.Y + items[ "colorpicker" ].AbsoluteSize.Y + 4)

                library:tween(items[ "colorpicker_fade" ], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
                library:tween(items[ "colorpicker_holder" ], {Position = items[ "colorpicker_holder" ].Position + dim_offset(0, 20)}) -- p100 check
                
                if not (self.sanity and library.current_open == self and self.open) then 
                    library:close_element(cfg)
                end
            end

            function cfg.set(color, alpha)
                if type(color) == "boolean" then 
                    return
                end 

                if color then 
                    h, s, v = color:ToHSV()
                end
                
                if alpha then 
                    a = alpha
                end 
                
                local Color = hsv(h, s, v)

                -- Ok so quick story, should I cache any of this? no...?? anyways I know this code is very bad but its your fault for buying a ui with animations (on a serious note im too lazy to make this look nice)
                -- Also further note, yeah I kind of did this scale_factor * size-valuesize.plane because then I would have to do tomfoolery to make it clip properly.
                library:tween(items[ "hue_picker" ], {Position = dim2(0, (items[ "hue_gradient" ].AbsoluteSize.X - items[ "hue_picker" ].AbsoluteSize.X) * h, 0.5, 0)}, Enum.EasingStyle.Linear, 0.05)
                library:tween(items[ "alpha_picker" ], {Position = dim2(0, (items[ "alpha_gradient" ].AbsoluteSize.X - items[ "alpha_picker" ].AbsoluteSize.X) * (1 - a), 0.5, 0)}, Enum.EasingStyle.Linear, 0.05)
                library:tween(items[ "satvalpicker" ], {Position = dim2(0, s * (items[ "saturation_holder" ].AbsoluteSize.X - items[ "satvalpicker" ].AbsoluteSize.X), 1, 1 - v * (items[ "saturation_holder" ].AbsoluteSize.Y - items[ "satvalpicker" ].AbsoluteSize.Y))}, Enum.EasingStyle.Linear, 0.05)

                items[ "alpha_indicator" ]:FindFirstChildOfClass("UIGradient").Color = rgbseq{rgbkey(0, rgb(112, 112, 112)), rgbkey(1, hsv(h, 1, 1))}; -- shit code
                
                items[ "colorpicker" ].BackgroundColor3 = Color
                items[ "colorpicker_inline" ].BackgroundColor3 = Color
                items[ "saturation_holder" ].BackgroundColor3 = hsv(h, 1, 1)

                items[ "hue_picker" ].BackgroundColor3 = hsv(h, 1, 1)
                items[ "alpha_picker" ].BackgroundColor3 = hsv(h, 1, 1 - a)
                items[ "satvalpicker" ].BackgroundColor3 = hsv(h, s, v)

                flags[cfg.flag] = {
                    Color = Color;
                    Transparency = a 
                }
                
                local color = items[ "colorpicker" ].BackgroundColor3
                items[ "input" ].Text = string.format("%s, %s, %s, ", library:round(color.R * 255), library:round(color.G * 255), library:round(color.B * 255))
                items[ "input" ].Text ..= library:round(1 - a, 0.01)
                
                cfg.callback(Color, a)
            end
            
            function cfg.update_color(position)
                local pointer = position or uis:GetMouseLocation()
                local offset = vec2(pointer.X, pointer.Y - gui_offset)

                if dragging_sat then	
                    s = math.clamp((offset - items["sat"].AbsolutePosition).X / items["sat"].AbsoluteSize.X, 0, 1)
                    v = 1 - math.clamp((offset - items["sat"].AbsolutePosition).Y / items["sat"].AbsoluteSize.Y, 0, 1)
                elseif dragging_hue then
                    h = math.clamp((offset - items[ "hue_gradient" ].AbsolutePosition).X / items[ "hue_gradient" ].AbsoluteSize.X, 0, 1)
                elseif dragging_alpha then
                    a = 1 - math.clamp((offset - items[ "alpha_gradient" ].AbsolutePosition).X / items[ "alpha_gradient" ].AbsoluteSize.X, 0, 1)
                end

                cfg.set()
            end

            items[ "colorpicker" ].Activated:Connect(function()
                cfg.open = not cfg.open 

                cfg.set_visible(cfg.open)            
            end)

            library:connection(uis.InputChanged, function(input)
                if (dragging_sat or dragging_hue or dragging_alpha)
                    and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    cfg.update_color(input.Position)
                end
            end)

            library:connection(uis.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging_sat = false
                    dragging_hue = false
                    dragging_alpha = false
                end
            end)    

            local function begin_color_drag(surface, drag_kind)
                surface.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging_sat, dragging_hue, dragging_alpha = drag_kind == "sat", drag_kind == "hue", drag_kind == "alpha"
                        cfg.update_color(input.Position)
                    end
                end)
            end
            begin_color_drag(items[ "alpha_gradient" ], "alpha")
            begin_color_drag(items[ "hue_gradient" ], "hue")
            begin_color_drag(items[ "sat" ], "sat")

            items[ "input" ].FocusLost:Connect(function()
                local text = items[ "input" ].Text
                local r, g, b, a = library:convert(text)
                
                if r and g and b and a then 
                    cfg.set(rgb(r, g, b), 1 - a)
                end 
            end)

            items[ "input" ].Focused:Connect(function()
                library:tween(items[ "input" ], {TextColor3 = rgb(245, 245, 245)})
            end)

            items[ "input" ].FocusLost:Connect(function()
                library:tween(items[ "input" ], {TextColor3 = rgb(72, 72, 72)})
            end)
            
            cfg.set(cfg.color, cfg.alpha)
            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end 

        function library:textbox(options) 
            local cfg = {
                name = options.name or "TextBox",
                placeholder = options.placeholder or options.placeholdertext or options.holder or options.holdertext or "type here...",
                default = options.default or "",
                flag = options.flag or library:next_flag(),
                callback = options.callback or function() end,
                visible = options.visible or true,
                items = {};
            }

            flags[cfg.flag] = cfg.default

            local items = cfg.items; do 
                items[ "textbox" ] = library:create( "TextButton" , {
                    LayoutOrder = -1;
                    FontFace = fonts.font;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "textbox" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                items[ "right_components" ] = library:create( "Frame" , {
                    Parent = items[ "textbox" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 4, 0, 19);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 12);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "right_components" ];
                    Padding = dim(0, 7);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Horizontal
                });
                
                items[ "input" ] = library:create( "TextBox" , {
                    FontFace = fonts.font;
                    Text = "";
                    Parent = items[ "right_components" ];
                    Name = "\0";
                    TextTruncate = Enum.TextTruncate.AtEnd;
                    BorderSizePixel = 0;
                    PlaceholderColor3 = rgb(255, 255, 255);
                    CursorPosition = -1;
                    ClearTextOnFocus = false;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255);
                    TextColor3 = rgb(72, 72, 72);
                    BorderColor3 = rgb(0, 0, 0);
                    Position = dim2(1, 0, 0, 0);
                    Size = dim2(1, -4, 0, 30);
                    BackgroundColor3 = rgb(33, 33, 35)
                }); 

                library:create( "UICorner" , {
                    Parent = items[ "input" ];
                    CornerRadius = dim(0, 3)
                });                
                
                library:create( "UIPadding" , {
                    Parent = items[ "right_components" ];
                    PaddingTop = dim(0, 4);
                    PaddingRight = dim(0, 4)
                });
            end 
            
            function cfg.set(text) 
                flags[cfg.flag] = text

                items[ "input" ].Text = text

                cfg.callback(text)
            end 
            
            items[ "input" ]:GetPropertyChangedSignal("Text"):Connect(function()
                cfg.set(items[ "input" ].Text) 
            end)

            items[ "input" ].Focused:Connect(function()
                library:tween(items[ "input" ], {TextColor3 = rgb(245, 245, 245)})
            end)

            items[ "input" ].FocusLost:Connect(function()
                library:tween(items[ "input" ], {TextColor3 = rgb(72, 72, 72)})
            end)
                
            if cfg.default then 
                cfg.set(cfg.default) 
            end

            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end

        function library:keybind(options) 
            local cfg = {
                flag = options.flag or library:next_flag(),
                callback = options.callback or function() end,
                name = options.name or nil, 
                ignore_key = options.ignore or false, 

                key = options.key or nil, 
                mode = options.mode or "Toggle",
                active = options.default or false, 

                open = false,
                binding = nil, 

                hold_instances = {},
                items = {};
            }

            flags[cfg.flag] = {
                mode = cfg.mode,
                key = cfg.key, 
                active = cfg.active
            }

            local popup_gui = self.owner_gui or library:popup_parent()
            local items = cfg.items; do 
                -- Component
                    items[ "keybind_element" ] = library:create( "TextButton" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = self.items[ "elements" ];
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    items[ "name" ] = library:create( "TextLabel" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(245, 245, 245);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = cfg.name;
                        Parent = items[ "keybind_element" ];
                        Name = "\0";
                        Size = dim2(1, 0, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "name" ];
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    items[ "right_components" ] = library:create( "Frame" , {
                        Parent = items[ "keybind_element" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalAlignment = Enum.HorizontalAlignment.Right;
                        Parent = items[ "right_components" ];
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    items[ "keybind_holder" ] = library:create( "TextButton" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = items[ "right_components" ];
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 0);
                        Size = dim2(0, 0, 0, 16);
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        TextSize = 14;
                        BackgroundColor3 = rgb(33, 33, 35)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "keybind_holder" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    items[ "key" ] = library:create( "TextLabel" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(86, 86, 87);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "LSHIFT";
                        Parent = items[ "keybind_holder" ];
                        Name = "\0";
                        Size = dim2(1, -12, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "key" ];
                        PaddingTop = dim(0, 1);
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });                                  
                -- 
                
                -- Mode Holder
                    items[ "dropdown" ] = library:create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = popup_gui;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 0, 0);
                        Size = dim2(0, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    items[ "inline" ] = library:create( "Frame" , {
                        Parent = items[ "dropdown" ];
                        Size = dim2(1, 0, 1, 0);
                        Name = "\0";
                        ClipsDescendants = true;
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(22, 22, 24)
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingBottom = dim(0, 6);
                        PaddingTop = dim(0, 3);
                        PaddingLeft = dim(0, 3);
                        Parent = items[ "inline" ]
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "inline" ];
                        Padding = dim(0, 5);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "inline" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    local options = {"Hold", "Toggle", "Always"}
                    
                    cfg.y_size = 20
                    for _, option in options do                        
                        local name = library:create( "TextButton" , {
                            FontFace = fonts.font;
                            TextColor3 = rgb(72, 72, 73);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = option;
                            Parent = items[ "inline" ];
                            Name = "\0";
                            Size = dim2(0, 0, 0, 0);
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            TextSize = 14;
                            BackgroundColor3 = rgb(255, 255, 255)
                        }); cfg.hold_instances[option] = name
                        library:apply_theme(name, "accent", "TextColor3")
                        
                        cfg.y_size += name.AbsoluteSize.Y

                        library:create( "UIPadding" , {
                            Parent = name;
                            PaddingTop = dim(0, 1);
                            PaddingRight = dim(0, 5);
                            PaddingLeft = dim(0, 5)
                        });

                        name.Activated:Connect(function()
                            cfg.set(option)

                            cfg.set_visible(false)

                            cfg.open = false
                        end)
                    end
                -- 
            end 
            
            function cfg.modify_mode_color(path) -- ts so frikin tuff 💀
                for _, v in cfg.hold_instances do 
                    v.TextColor3 = rgb(72, 72, 72)
                end 

                cfg.hold_instances[path].TextColor3 = themes.preset.accent
            end

            function cfg.set_mode(mode) 
                cfg.mode = mode 

                if mode == "Always" then
                    cfg.set(true)
                elseif mode == "Hold" then
                    cfg.set(false)
                end

                flags[cfg.flag]["mode"] = mode
                cfg.modify_mode_color(mode)
            end 

            function cfg.set(input)
                if type(input) == "boolean" then 
                    cfg.active = input

                    if cfg.mode == "Always" then 
                        cfg.active = true
                    end
                elseif tostring(input):find("Enum") then 
                    input = input.Name == "Escape" and "NONE" or input
                    
                    cfg.key = input or "NONE"	
                elseif find({"Toggle", "Hold", "Always"}, input) then 
                    if input == "Always" then 
                        cfg.active = true 
                    end 

                    cfg.mode = input
                    cfg.set_mode(cfg.mode) 
                elseif type(input) == "table" then 
                    input.key = type(input.key) == "string" and input.key ~= "NONE" and library:convert_enum(input.key) or input.key
                    input.key = input.key == Enum.KeyCode.Escape and "NONE" or input.key

                    cfg.key = input.key or "NONE"
                    cfg.mode = input.mode or "Toggle"

                    if input.active ~= nil then
                        cfg.active = input.active
                    end

                    cfg.set_mode(cfg.mode) 
                end 

                cfg.callback(cfg.active)

                local text = tostring(cfg.key) ~= "Enums" and (keys[cfg.key] or tostring(cfg.key):gsub("Enum.", "")) or nil
                local __text = text and (tostring(text):gsub("KeyCode.", ""):gsub("UserInputType.", ""))
                
                items[ "key" ].Text = __text

                flags[cfg.flag] = {
                    mode = cfg.mode,
                    key = cfg.key, 
                    active = cfg.active
                }
            end

            function cfg.set_visible(bool)
                local size = bool and cfg.y_size or 0
                library:tween(items[ "dropdown" ], {Size = dim_offset(items[ "keybind_holder" ].AbsoluteSize.X, size)})

                items[ "dropdown" ].Position = dim_offset(items[ "keybind_holder" ].AbsolutePosition.X, items[ "keybind_holder" ].AbsolutePosition.Y + items[ "keybind_holder" ].AbsoluteSize.Y + 4)
            end
        
            items[ "keybind_holder" ].Activated:Connect(function()
                task.wait()
                items[ "key" ].Text = "..."	

                cfg.binding = library:connection(uis.InputBegan, function(keycode, game_event)  
                    cfg.set(keycode.KeyCode ~= Enum.KeyCode.Unknown and keycode.KeyCode or keycode.UserInputType)
                    
                    cfg.binding:Disconnect() 
                    cfg.binding = nil
                end)
            end)

            items[ "keybind_holder" ].MouseButton2Down:Connect(function()
                cfg.open = not cfg.open
                cfg.set_visible(cfg.open)
            end)
            if uis.TouchEnabled then
                items[ "mode_button" ] = library:create("TextButton", {
                    Parent = items[ "right_components" ]; Text = "⋯"; FontFace = fonts.font;
                    TextSize = 16; TextColor3 = rgb(180, 180, 180); BackgroundColor3 = rgb(33, 33, 35);
                    BorderSizePixel = 0; Size = dim2(0, 24, 0, 18); AutoButtonColor = true;
                })
                items[ "mode_button" ].Activated:Connect(function()
                    cfg.open = not cfg.open
                    cfg.set_visible(cfg.open)
                end)
            end

            library:connection(uis.InputBegan, function(input, game_event) 
                if not game_event then
                    local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType

                    if selected_key == cfg.key then 
                        if cfg.mode == "Toggle" then 
                            cfg.active = not cfg.active
                            cfg.set(cfg.active)
                        elseif cfg.mode == "Hold" then 
                            cfg.set(true)
                        end
                    end
                end
            end)    

            library:connection(uis.InputEnded, function(input, game_event) 
                if game_event then 
                    return 
                end 

                local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType
    
                if selected_key == cfg.key then
                    if cfg.mode == "Hold" then 
                        cfg.set(false)
                    end
                end
            end)
            
            cfg.set({mode = cfg.mode, active = cfg.active, key = cfg.key})           
            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end

        function library:button(options) 
            local cfg = {
                name = options.name or "Button",
                callback = options.callback or function() end,
                items = {};
            }
            
            local items = cfg.items; do 
                items[ "button_element" ] = library:create( "Frame" , {
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "button" ] = library:create( "TextButton" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    AutoButtonColor = false;
                    AnchorPoint = vec2(1, 0);
                    Parent = items[ "button_element" ];
                    Name = "\0";
                    Position = dim2(1, -4, 0, 0);
                    Size = dim2(1, -8, 0, 30);
                    BorderSizePixel = 0;
                    TextSize = 14;
                    BackgroundColor3 = rgb(33, 33, 35)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "button" ];
                    CornerRadius = dim(0, 3)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "button" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:apply_theme(items[ "name" ], "accent", "BackgroundColor3");                            
            end 

            items[ "button" ].Activated:Connect(function()
                cfg.callback()

                items[ "name" ].TextColor3 = themes.preset.accent 
                library:tween(items[ "name" ], {TextColor3 = rgb(245, 245, 245)})
            end)
            
            return setmetatable(cfg, library)
        end 

        function library:settings(options)  
            local cfg = {
                open = false; 
                items = {}; 
                sanity = true; -- made this for my own sanity.
            }

            local popup_gui = self.owner_gui or library:popup_parent()
            local items = cfg.items; do
                items[ "outline" ] = library:create( "Frame" , {
                    Name = "\0";
                    Visible = true;
                    Parent = popup_gui;
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 0, 0);
                    ClipsDescendants = true;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(25, 25, 29)
                });
                
                items[ "inline" ] = library:create( "Frame" , {
                    Parent = items[ "outline" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(22, 22, 24)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "inline" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "elements" ] = library:create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = items[ "inline" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 10, 0, 10);
                    Size = dim2(1, -20, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "elements" ];
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UIPadding" , {
                    PaddingBottom = dim(0, 15);
                    Parent = items[ "elements" ]
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "outline" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "tick" ] = library:create( "ImageButton" , {
                    Image = "rbxassetid://128797200442698";
                    Name = "\0";
                    AutoButtonColor = false;
                    Parent = self.items[ "right_components" ] or self.items[ "elements" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 16, 0, 16);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });                
            end 

            function cfg.set_visible(bool)                 
                library:tween(items[ "outline" ], {Size = dim_offset(bool and 240 or 0, 0)})
                items[ "outline" ].Position = dim_offset(items[ "tick" ].AbsolutePosition.X, items[ "tick" ].AbsolutePosition.Y + 90)
                library:close_element(cfg)
            end
            
            items[ "tick" ].Activated:Connect(function()
                cfg.open = not cfg.open

                cfg.set_visible(cfg.open)
            end)

            return setmetatable(cfg, library)
        end 

        function library:list(properties) 
            local cfg = {
                items = {};
                options = properties.options or {"1", "2", "3"};
                flag = properties.flag or library:next_flag();    
                callback = properties.callback or function() end;
                data_store = {};        
                current_element = nil;
            }

            local items = cfg.items; do
                items[ "list" ] = library:create( "Frame" , {
                    Parent = self.items[ "elements" ];
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "list" ];
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "list" ];
                    PaddingRight = dim(0, 4);
                    PaddingLeft = dim(0, 4)
                });
            end 

            function cfg.refresh_options(options_to_refresh)
                for _, option in ipairs(cfg.data_store) do
                    option:Destroy()
                end
                cfg.data_store = {}
                cfg.current_element = nil

                for _, option_data in options_to_refresh do
                    local button = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 0);
                        Parent = items[ "list" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        Size = dim2(1, 0, 0, 30);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(33, 33, 35)
                    }); cfg.data_store[#cfg.data_store + 1] = button;

                    local name = library:create( "TextLabel" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(72, 72, 73);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = option_data;
                        Parent = button;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = button;
                        CornerRadius = dim(0, 3)
                    });     

                    button.Activated:Connect(function()
                        local current = cfg.current_element 
                        if current and current ~= name then 
                            library:tween(current, {TextColor3 = rgb(72, 72, 72)})
                        end

                        flags[cfg.flag] = option_data
                        cfg.callback(option_data)
                        library:tween(name, {TextColor3 = rgb(245, 245, 245)})
                        cfg.current_element = name
                    end)
                    if flags[cfg.flag] == option_data then
                        name.TextColor3 = rgb(245, 245, 245)
                        cfg.current_element = name
                    end

                    name.MouseEnter:Connect(function()
                        if cfg.current_element == name then 
                            return 
                        end 

                        library:tween(name, {TextColor3 = rgb(140, 140, 140)})
                    end)

                    name.MouseLeave:Connect(function()
                        if cfg.current_element == name then 
                            return 
                        end 

                        library:tween(name, {TextColor3 = rgb(72, 72, 72)})
                    end)
                end
            end

            cfg.refresh_options(cfg.options)

            return setmetatable(cfg, library)
        end 

        -- Runtime icon sizing: call on a tab or section object, returns its ImageLabel.
        function library:set_icon_size(target, size)
            if not target or not target.items then return nil end
            local img = target.items["icon"] or target.items["Icon"]
            if img then img.Size = dim2(0, size, 0, size) end
            return img
        end

        -- Sub window: a second standalone window with full component support.
        -- Same API as the main window's returned object: ex:tab/ex:column/ex:section/...
        -- Draggable by its title bar, resizable by the corner handle, closable.
        function library:sub_window(properties)
            local cfg = {
                name = properties.name or properties.Name or "sub";
                suffix = properties.suffix or properties.Suffix or "";
                size = properties.size or properties.Size or dim2(0, 420, 0, 320);
                header_height = properties.headerHeight or properties.header_height or 34;
                min_width = properties.minWidth or properties.min_width or 320;
                min_height = properties.minHeight or properties.min_height or 220;
                icon = properties.icon or properties.Icon;
                popup_can_escape = properties.popupCanEscape or false;
                owner_gui = library:create("ScreenGui", {
                    Parent = coregui;
                    Name = "\0";
                    Enabled = true;
                    DisplayOrder = (library[ "items" ] and (library[ "items" ].DisplayOrder + 1) or 1);
                    ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                    IgnoreGuiInset = true;
                });
                pages = {};
                sub_windows = {};
                items = {};
            }

            -- Popups created inside this sub window stay inside it.
            library:set_owner_gui(cfg.owner_gui)

            local items = cfg.items; do
                items[ "main" ] = library:create( "Frame", {
                    Parent = cfg.owner_gui;
                    Size = cfg.size;
                    Name = "\0";
                    Position = properties.position or properties.Position or dim2(0.5, -cfg.size.X.Offset / 2, 0.5, -cfg.size.Y.Offset / 2);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.background;
                }); library:apply_theme(items[ "main" ], "background", "BackgroundColor3")
                library:create("UICorner", {Parent = items[ "main" ]; CornerRadius = dim(0, 8)})

                -- Title bar
                items[ "titlebar" ] = library:create( "Frame", {
                    Parent = items[ "main" ];
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Size = dim2(1, -58, 0, cfg.header_height);
                    Position = dim2(0, 8, 0, 4);
                    BorderSizePixel = 0;
                    ZIndex = 5;
                });
                items[ "title" ] = library:create( "TextLabel", {
                    FontFace = fonts.font;
                    Parent = items[ "titlebar" ];
                    Text = cfg.name .. cfg.suffix;
                    TextColor3 = themes.preset.text;
                    Name = "\0";
                    Size = dim2(1, 0, 1, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    TextSize = 16;
                    ZIndex = 6;
                });
                library:apply_theme(items[ "title" ], "text", "TextColor3")

                -- Page opener API mirrors window:tab(), minus multi-section switching.
                items[ "content" ] = nil
            end

            local function apply_title_icon(icon)
                if not icon then return end
                if not items[ "icon" ] then
                    items[ "icon" ] = library:create( "ImageLabel", {
                        Parent = items[ "titlebar" ];
                        AnchorPoint = vec2(0, 0.5);
                        Position = dim2(0, 0, 0.5, 0);
                        Size = dim2(0, 16, 0, 16);
                        BackgroundTransparency = 1;
                        Image = library.default_icon;
                        BorderSizePixel = 0;
                        ZIndex = 6;
                    });
                    items[ "title" ].Position = dim2(0, 22, 0, 0)
                    items[ "title" ].Size = dim2(1, -22, 1, 0)
                end
                cfg.icon = icon
                library:apply_icon(items[ "icon" ], icon)
            end
            apply_title_icon(cfg.icon)

            function cfg.apply_viewport()
                local viewport = (ws.CurrentCamera or camera).ViewportSize
                local w = min(cfg.size.X.Offset, max(1, viewport.X - 12))
                local h = min(cfg.size.Y.Offset, max(1, viewport.Y - 12))
                cfg.size = dim2(0, w, 0, h)
                items[ "main" ].Size = cfg.size
                local pos = items[ "main" ].Position
                local x, y = pos.X.Offset, pos.Y.Offset
                if pos.X.Scale ~= 0 then x = pos.X.Scale * viewport.X + pos.X.Offset end
                if pos.Y.Scale ~= 0 then y = pos.Y.Scale * viewport.Y + pos.Y.Offset end
                items[ "main" ].Position = dim2(0, clamp(x, 0, max(0, viewport.X - w)),
                    0, clamp(y, 0, max(0, viewport.Y - h)))
            end

            function cfg:set_size(width, height)
                local viewport = (ws.CurrentCamera or camera).ViewportSize
                width = clamp(width, cfg.min_width, max(cfg.min_width, viewport.X - 12))
                height = clamp(height, cfg.min_height, max(cfg.min_height, viewport.Y - 12))
                cfg.size = dim2(0, width, 0, height)
                items[ "main" ].Size = cfg.size
            end

            library:draggify(items[ "main" ], cfg.header_height + 4)
            library:resizify(items[ "main" ], cfg.min_width, cfg.min_height, function(width, height)
                cfg.size = dim2(0, width, 0, height)
                items[ "main" ].Size = cfg.size
            end)

            -- Mini tab pages: same behavior as main window tabs (mini tab bar), tiny canvas.
            local page_switcher = library:create( "Frame", {
                Parent = items[ "main" ];
                BackgroundTransparency = 1;
                Name = "\0";
                Position = dim2(0, 10, 0, cfg.header_height + 8);
                Size = dim2(1, -20, 0, 26);
                BorderSizePixel = 0;
                ZIndex = 7;
            });
            library:create("UIListLayout", {Parent = page_switcher; FillDirection = Enum.FillDirection.Horizontal; Padding = dim(0, 6); SortOrder = Enum.SortOrder.LayoutOrder});

            local page_body = library:create( "Frame", {
                Parent = items[ "main" ];
                BackgroundTransparency = 1;
                Name = "\0";
                Position = dim2(0, 10, 0, cfg.header_height + 38);
                Size = dim2(1, -20, 1, -(cfg.header_height + 48));
                BorderSizePixel = 0;
            });
            library:create("UIListLayout", {FillDirection = Enum.FillDirection.Vertical; HorizontalFlex = Enum.UIFlexAlignment.Fill; VerticalFlex = Enum.UIFlexAlignment.Fill; Parent = page_body; Padding = dim(0, 7); SortOrder = Enum.SortOrder.LayoutOrder});

            items["page_switcher"] = page_switcher
            items["page_body"] = page_body

            function cfg:tab(options)
                options = options or {}
                local label = options.name or options.Name or "tab"
                local icon = options.icon or options.Icon or library.default_subtab_icon
                if icon == false then icon = nil end
                local icon_size = options.iconSize or options.IconSize or 16
                local padding_left = icon and (7 + icon_size + 5) or 10
                local page = {enabled = true; items = {}; name = label; icon = icon; sub_pages = {}; owner_gui = cfg.owner_gui}
                local btn = library:create( "TextButton", {
                    FontFace = fonts.font;
                    TextColor3 = themes.preset.muted;
                    Text = label;
                    Parent = page_switcher;
                    Name = "\0";
                    AutoButtonColor = false;
                    Size = dim2(0, 0, 1, 0);
                    BackgroundTransparency = 1;
                    AutomaticSize = Enum.AutomaticSize.X;
                    TextSize = 14;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    LayoutOrder = #cfg.pages + 1;
                });
                library:apply_theme(btn, "muted", "TextColor3")

                local icon_label = library:create("ImageLabel", {
                    Parent = btn;
                    AnchorPoint = vec2(0, 0.5);
                    Position = dim2(0, 10 - padding_left, 0.5, 0);
                    Name = "\0";
                    Size = dim2(0, icon_size, 0, icon_size);
                    BackgroundTransparency = 1;
                    Image = library.default_icon;
                    ImageColor3 = themes.preset.muted;
                    Visible = icon ~= nil;
                    BorderSizePixel = 0;
                })
                if icon then library:apply_icon(icon_label, icon) end

                local padding = library:create("UIPadding", {
                    Parent = btn;
                    PaddingLeft = dim(0, padding_left);
                    PaddingRight = dim(0, 10);
                })

                local body = library:create( "Frame", {
                    Parent = page_body;
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Visible = false;
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                });
                library:create("UIListLayout", {FillDirection = Enum.FillDirection.Vertical; HorizontalFlex = Enum.UIFlexAlignment.Fill; VerticalFlex = Enum.UIFlexAlignment.Fill; Parent = body; Padding = dim(0, 7); SortOrder = Enum.SortOrder.LayoutOrder});

                page.items["body"] = body
                page.items["button"] = btn
                page.items["icon"] = icon_label
                page.column = cfg.column

                function page.open_page()
                    for _, other in ipairs(cfg.pages) do
                        other.items["body"].Visible = false
                        other.items["button"].TextColor3 = themes.preset.muted
                        other.items["icon"].ImageColor3 = themes.preset.muted
                    end
                    body.Visible = true
                    btn.TextColor3 = themes.preset.accent
                    icon_label.ImageColor3 = themes.preset.accent
                    cfg.current_page = page
                end

                -- Change this page tab's icon at runtime, e.g. page:set_icon("settings").
                function page.set_icon(self_or_icon, maybe_icon)
                    local new_icon = maybe_icon
                    if new_icon == nil and type(self_or_icon) == "string" then new_icon = self_or_icon end
                    if new_icon == false then
                        page.icon = nil
                        icon_label.Visible = false
                        padding.PaddingLeft = dim(0, 10)
                        icon_label.Position = dim2(0, 0, 0.5, 0)
                        return page
                    end
                    if type(new_icon) ~= "string" then return page end
                    page.icon = new_icon
                    icon_label.Visible = true
                    padding.PaddingLeft = dim(0, 7 + icon_size + 5)
                    icon_label.Position = dim2(0, 10 - (7 + icon_size + 5), 0.5, 0)
                    library:apply_icon(icon_label, new_icon)
                    icon_label.ImageColor3 = (cfg.current_page == page) and themes.preset.accent or themes.preset.muted
                    return page
                end

                btn.Activated:Connect(page.open_page)

                -- Widget parents: sections/columns route through setmetatable(cfg, library),
                -- so :column/:section work with no additional plumbing.
                local page_meta = setmetatable(page, library)
                table.insert(cfg.pages, page_meta)
                if #cfg.pages == 1 then page.open_page() end
                return page_meta
            end

            function cfg:column(properties)
                properties = properties or {}
                local col = {items = {}; size = properties.size or 1; owner_gui = cfg.owner_gui}
                local f = library:create("Frame", {
                    Parent = self.items["body"];
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Size = dim2(0, 0, col.size, 0);
                    BorderSizePixel = 0;
                });
                library:create("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical;
                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                    Parent = f;
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                })
                col.items["column"] = f
                return setmetatable(col, library)
            end

            -- Close button and popups-inside-owner support.
            local close_btn = library:create( "TextButton", {
                FontFace = fonts.font;
                Parent = items[ "main" ];
                Text = "×";
                TextColor3 = themes.preset.muted;
                Name = "\0";
                AutoButtonColor = true;
                Size = dim2(0, 22, 0, 22);
                Position = dim2(1, -24, 0, 5);
                BackgroundTransparency = 1;
                TextSize = 18;
                ZIndex = 6;
                BorderSizePixel = 0;
            });
            local function release_owner()
                if library.owner_gui == cfg.owner_gui then
                    library:set_owner_gui(library[ "items" ])
                end
            end

            close_btn.Activated:Connect(function() cfg:close() end)

            function cfg:open()
                library:set_owner_gui(cfg.owner_gui)
                cfg.owner_gui.Enabled = true
            end

            function cfg:close()
                cfg.owner_gui.Enabled = false
                release_owner()
            end

            function cfg:destroy()
                cfg.owner_gui:Destroy()
                release_owner()
            end

            function cfg:set_title(text)
                cfg.name = text or cfg.name
                items[ "title" ].Text = cfg.name .. cfg.suffix
            end

            function cfg:set_icon(icon)
                apply_title_icon(icon)
            end

            -- Change one of this window's page tabs by name or index.
            -- notes:set_tab_icon("Page A", "settings")
            function cfg:set_tab_icon(target, icon)
                local tab = type(target) == "number" and cfg.pages[target] or nil
                if not tab then
                    for _, candidate in ipairs(cfg.pages) do
                        if candidate.name == target then
                            tab = candidate
                            break
                        end
                    end
                end
                if not tab or not tab.set_icon then return false end
                tab:set_icon(icon)
                return true
            end

            cfg.apply_viewport()

            return setmetatable(cfg, library)
        end

        -- Mini window: the same window API in a compact, collapsible frame.
        function library:mini_window(properties)
            properties = properties or {}
            local mini = library:sub_window({
                name = properties.name or properties.Name or "mini";
                suffix = properties.suffix or properties.Suffix or "";
                size = properties.size or properties.Size or dim2(0, 250, 0, 190);
                position = properties.position or properties.Position;
                headerHeight = properties.headerHeight or properties.header_height or 30;
                minWidth = properties.minWidth or properties.min_width or 180;
                minHeight = properties.minHeight or properties.min_height or 110;
                icon = properties.icon or properties.Icon;
            })

            mini.is_mini = true
            mini.collapsed = false
            mini.expanded_size = mini.size
            mini.items["main"].Size = mini.size

            local main = mini.items["main"]
            local switcher = mini.items["page_switcher"]
            local body = mini.items["page_body"]

            local collapse_btn = library:create("TextButton", {
                FontFace = fonts.font;
                Parent = main;
                Text = "−";
                TextColor3 = themes.preset.muted;
                Name = "\0";
                AutoButtonColor = false;
                Size = dim2(0, 22, 0, 22);
                Position = dim2(1, -46, 0, 4);
                BackgroundTransparency = 1;
                TextSize = 18;
                ZIndex = 7;
                BorderSizePixel = 0;
            });
            library:apply_theme(collapse_btn, "muted", "TextColor3")

            local function set_collapsed(collapsed)
                collapsed = collapsed and true or false
                if mini.collapsed == collapsed then return end
                mini.collapsed = collapsed

                if collapsed then
                    mini.expanded_size = dim2(0, main.Size.X.Offset, 0, main.Size.Y.Offset)
                    switcher.Visible = false
                    body.Visible = false
                    main.Size = dim2(0, mini.expanded_size.X.Offset, 0, mini.header_height + 10)
                    collapse_btn.Text = "+"
                else
                    local size = mini.expanded_size or mini.size
                    main.Size = size
                    mini.size = size
                    switcher.Visible = true
                    body.Visible = true
                    collapse_btn.Text = "−"
                end
            end

            function mini:set_collapsed(collapsed)
                set_collapsed(collapsed)
            end

            function mini:toggle_collapsed()
                set_collapsed(not mini.collapsed)
            end

            function mini:minimize()
                set_collapsed(true)
            end

            function mini:expand()
                set_collapsed(false)
            end

            collapse_btn.Activated:Connect(function()
                set_collapsed(not mini.collapsed)
            end)

            return mini
        end

        -- Tab box: a horizontal strip of tabs whose pages live side-by-side.
        -- Useful to stack left/middle/right groups of tabs inside one window or sub window.
        function library:tabbox(properties)
            properties = properties or {}
            local cfg = {
                side = properties.side or properties.Side or "left"; -- "left" | "middle" | "right"
                tabs = {};
                current = nil;
                items = {};
            }

            -- Where the tab buttons sit: left/middle/right affects alignment only.
            local alignment = cfg.side == "left" and Enum.HorizontalAlignment.Left
                or cfg.side == "right" and Enum.HorizontalAlignment.Right
                or Enum.HorizontalAlignment.Center

            local popup_gui
            local host
            do
                -- Parent: the widget host when called on a page/section, otherwise the current tab.
                local parent_frame = self.items and (self.items["body"] or self.items["column"] or self.items["tab_parent"] or self.items["elements"]) or nil
                if not parent_frame and self.items and self.items["global_fade"] then parent_frame = self.items["global_fade"] end
                if not parent_frame and self.selected_tab then parent_frame = self.selected_tab[4] end
                if not parent_frame and self.items and self.items["main"] then parent_frame = self.items["main"] end

                host = library:create("Frame", {
                    Parent = parent_frame;
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                });
                popup_gui = host:FindFirstAncestorOfClass("ScreenGui") or self.owner_gui or library:popup_parent()

                -- Tab strip
                cfg.items["strip"] = library:create("Frame", {
                    Parent = host;
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Size = dim2(1, 0, 0, 30);
                    BorderSizePixel = 0;
                });
                library:create("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalAlignment = alignment;
                    Padding = dim(0, 8);
                    Parent = cfg.items["strip"];
                    SortOrder = Enum.SortOrder.LayoutOrder;
                })

                -- Body
                cfg.items["body"] = library:create("Frame", {
                    Parent = host;
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Position = dim2(0, 0, 0, 32);
                    Size = dim2(1, 0, 1, -32);
                    BorderSizePixel = 0;
                });
                library:create("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical;
                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                    VerticalFlex = Enum.UIFlexAlignment.Fill;
                    Parent = cfg.items["body"];
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                })

            end

            function cfg:tab(options)
                options = options or {}
                local label = options.name or options.Name or "tab"
                local icon = options.icon or options.Icon or library.default_subtab_icon
                if icon == false then icon = nil end
                local icon_size = options.iconSize or options.IconSize or 16
                local padding_left = icon and (7 + icon_size + 5) or 10
                local page = {items = {}; name = label; icon = icon; owner_gui = popup_gui}
                local btn = library:create("TextButton", {
                    FontFace = fonts.font;
                    Text = label;
                    TextColor3 = themes.preset.muted;
                    Parent = cfg.items["strip"];
                    AutoButtonColor = false;
                    BackgroundTransparency = 1;
                    Size = dim2(0, 0, 1, 0);
                    AutomaticSize = Enum.AutomaticSize.X;
                    TextSize = 14;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    LayoutOrder = #cfg.tabs + 1;
                });
                library:apply_theme(btn, "muted", "TextColor3")
                library:create("UICorner", {Parent = btn; CornerRadius = dim(0, 6)})

                local icon_label = library:create("ImageLabel", {
                    Parent = btn;
                    AnchorPoint = vec2(0, 0.5);
                    Position = dim2(0, 10 - padding_left, 0.5, 0);
                    Name = "\0";
                    Size = dim2(0, icon_size, 0, icon_size);
                    BackgroundTransparency = 1;
                    Image = library.default_icon;
                    ImageColor3 = themes.preset.muted;
                    Visible = icon ~= nil;
                    BorderSizePixel = 0;
                })
                if icon then library:apply_icon(icon_label, icon) end

                local padding = library:create("UIPadding", {
                    Parent = btn;
                    PaddingLeft = dim(0, padding_left);
                    PaddingRight = dim(0, 10);
                })

                local body = library:create("Frame", {
                    Parent = cfg.items["body"];
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Visible = false;
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                });
                library:create("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical;
                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                    VerticalFlex = Enum.UIFlexAlignment.Fill;
                    Parent = body;
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                })

                page.items["body"] = body
                page.items["button"] = btn
                page.items["icon"] = icon_label
                page.column = cfg.column

                function page.open_page()
                    for _, other in ipairs(cfg.tabs) do
                        other.items["body"].Visible = false
                        other.items["button"].TextColor3 = themes.preset.muted
                        other.items["icon"].ImageColor3 = themes.preset.muted
                    end
                    body.Visible = true
                    btn.TextColor3 = themes.preset.accent
                    icon_label.ImageColor3 = themes.preset.accent
                    cfg.current = page
                end

                -- Change this sub-tab's icon at runtime, e.g. page:set_icon("settings").
                function page.set_icon(self_or_icon, maybe_icon)
                    local new_icon = maybe_icon
                    if new_icon == nil and type(self_or_icon) == "string" then new_icon = self_or_icon end
                    if new_icon == false then
                        page.icon = nil
                        icon_label.Visible = false
                        padding.PaddingLeft = dim(0, 10)
                        icon_label.Position = dim2(0, 0, 0.5, 0)
                        return page
                    end
                    if type(new_icon) ~= "string" then return page end
                    page.icon = new_icon
                    icon_label.Visible = true
                    padding.PaddingLeft = dim(0, 7 + icon_size + 5)
                    icon_label.Position = dim2(0, 10 - (7 + icon_size + 5), 0.5, 0)
                    library:apply_icon(icon_label, new_icon)
                    icon_label.ImageColor3 = (cfg.current == page) and themes.preset.accent or themes.preset.muted
                    return page
                end

                btn.Activated:Connect(page.open_page)

                local page_meta = setmetatable(page, library)
                table.insert(cfg.tabs, page_meta)
                if #cfg.tabs == 1 then page.open_page() end
                return page_meta
            end

            function cfg:column(properties)
                properties = properties or {}
                local col = {items = {}; size = properties.size or 1; owner_gui = popup_gui}
                local frame = library:create("Frame", {
                    Parent = self.items["body"];
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Size = dim2(0, 0, col.size, 0);
                    BorderSizePixel = 0;
                });
                library:create("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical;
                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                    Parent = frame;
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                })
                col.items["column"] = frame
                return setmetatable(col, library)
            end

            -- Change a tab-box sub-tab icon by name or index.
            -- box:set_tab_icon("Box Left", "settings")
            function cfg:set_tab_icon(target, icon)
                local tab = type(target) == "number" and cfg.tabs[target] or nil
                if not tab then
                    for _, candidate in ipairs(cfg.tabs) do
                        if candidate.name == target then
                            tab = candidate
                            break
                        end
                    end
                end
                if not tab or not tab.set_icon then return false end
                tab:set_icon(icon)
                return true
            end

            return setmetatable(cfg, library)
        end

        function library:init_config(window)
            window:seperator({name = "Settings"})
            local cfgPage, ifPage, thPage = window:tab({name = "Settings", tabs = {"Configs", "Interface", "Theme"}})

            local cfgCol = cfgPage:column({})
            local cfgSection = cfgCol:section({name = "Saved Configs", size = 1, default = true, icon = "rbxassetid://139628202576511"})
            config_holder = cfgSection:list({options = {}, callback = function(name) flags.config_name_list = name end, flag = "config_name_list"})
            library:update_config_list()

            local mgrCol = cfgPage:column({})
            local mgrSection = mgrCol:section({name = "Config Manager", side = "right", size = 1, default = true, icon = "rbxassetid://129380150574313"})
            mgrSection:textbox({name = "Config name:", flag = "config_name_text", placeholder = "Name for a new config"})
            local function notify(message) notifications:create_notification({name = "Settings", info = message}) end
            local function selected_name() return library:clean_config_name(flags.config_name_list) end
            local function report(ok, value, action) notify(ok and (action .. tostring(value or "")) or tostring(value)) end

            mgrSection:button({name = "Create config", callback = function()
                local ok, value = library:save_named_config(flags.config_name_text, false)
                report(ok, value, "Created: ")
            end})
            mgrSection:button({name = "Save / overwrite selected", callback = function()
                local name = selected_name()
                if not name then notify("Select a config to overwrite") return end
                local ok, value = library:save_named_config(name, true)
                report(ok, value, "Saved: ")
            end})
            mgrSection:button({name = "Load selected", callback = function()
                local ok, value = library:load_named_config(selected_name())
                report(ok, value, "Loaded: ")
            end})
            mgrSection:button({name = "Delete selected", callback = function()
                local ok, value = library:delete_named_config(selected_name())
                report(ok, value, "Deleted: ")
            end})
            mgrSection:button({name = "Refresh config list", callback = function()
                library:update_config_list()
                notify("Config list refreshed")
            end})
            mgrSection:button({name = "Set selected as auto load", callback = function()
                local ok, value = library:set_autoload(selected_name())
                report(ok, value, "Auto-load set to: ")
            end})
            mgrSection:button({name = "Remove auto load", callback = function()
                local ok, value = library:clear_autoload()
                notify(ok and "Auto-load removed" or tostring(value))
            end})
            mgrSection:button({name = "Copy selected to clipboard", callback = function()
                local path = library:config_path(selected_name())
                if not path or not isfile(path) then notify("Select an existing config first") return end
                local ok, data = pcall(readfile, path)
                if not ok then notify("Could not read selected config") return end
                local copied = false
                if type(setclipboard) == "function" then copied = pcall(setclipboard, data) end
                if not copied and type(toclipboard) == "function" then copied = pcall(toclipboard, data) end
                if not copied and type(writeclipboard) == "function" then copied = pcall(writeclipboard, data) end
                notify(copied and "Selected config copied to clipboard" or "Clipboard write is unavailable")
            end})
            mgrSection:button({name = "Paste config from clipboard", callback = function()
                local get_clipboard = getclipboard or readclipboard
                if type(get_clipboard) ~= "function" then notify("Clipboard read is unavailable") return end
                local ok, data = pcall(get_clipboard)
                if not ok or type(data) ~= "string" or data == "" then notify("Clipboard does not contain config data") return end
                local loaded, err = pcall(library.load_config, library, data)
                notify(loaded and "Clipboard config loaded" or ("Invalid config: " .. tostring(err)))
            end})

            -- Interface sub-page: window behavior + icon sizing controls.
            local ifCol = ifPage:column({})
            local ifSection = ifCol:section({name = "Interface", size = 1, default = true, icon = "rbxassetid://139628202576511"})

            ifSection:toggle({name = "Auto resize for screen", flag = "ui_auto_resize", default = window.auto_resize, callback = function(enabled)
                window.auto_resize = enabled
                window.apply_viewport()
            end})
            ifSection:button({name = "Re-fit to viewport", callback = function() window.apply_viewport() end})
            ifSection:button({name = "Reset to default size", callback = function()
                if window.default_size then
                    window:set_size(window.default_size.X.Offset, window.default_size.Y.Offset)
                end
            end})

            local function each_tab_icon(callback)
                if not (window.items and window.items.button_holder) then return end
                for _, child in ipairs(window.items.button_holder:GetChildren()) do
                    if child:IsA("TextButton") then
                        for _, descendant in ipairs(child:GetDescendants()) do
                            if descendant:IsA("ImageLabel") then callback(descendant) end
                        end
                    end
                end
            end

            ifSection:slider({name = "Icon size", min = 12, max = 40, default = 22, interval = 1, seperator = true, callback = function(value)
                each_tab_icon(function(img) img.Size = dim2(0, value, 0, value) end)
                library.icon_size = value
            end})
            ifSection:toggle({name = "Show tab icons", seperator = true, default = true, callback = function(shown)
                each_tab_icon(function(img) img.Visible = shown end)
                library.icons_visible = shown
            end})
            ifSection:dropdown({name = "Icon provider", items = library.icon_providers, default = library.icon_provider, seperator = true, callback = function(provider)
                local applied, err = library:set_icon_provider(provider)
                if not applied then notify(tostring(err)) end
            end})
            ifSection:keybind({name = "Menu Bind", key = Enum.KeyCode.RightShift, mode = "Toggle", callback = function(bool)
                if bool ~= nil then window.toggle_menu(bool) end
            end, default = true})

            -- Theme sub-page: color pickers for each role.
            local thCol = thPage:column({})
            local thSection = thCol:section({name = "Theme", size = 1, default = true, icon = "rbxassetid://129380150574313"})
            thSection:colorpicker({name = "Accent color", callback = function(value) library:update_theme("accent", value) end, color = themes.preset.accent})
            thSection:colorpicker({name = "Window background", callback = function(value) library:update_theme("background", value) end, color = themes.preset.background})
            thSection:colorpicker({name = "Surface color", callback = function(value) library:update_theme("surface", value) end, color = themes.preset.surface})
            thSection:colorpicker({name = "Text color", callback = function(value) library:update_theme("text", value) end, color = themes.preset.text})
            thSection:colorpicker({name = "Muted text color", callback = function(value) library:update_theme("muted", value) end, color = themes.preset.muted})

            local ok, autoload_name = pcall(readfile, autoload_file)
            if ok and type(autoload_name) == "string" and library:clean_config_name(autoload_name) then
                library.autoload_config = library:clean_config_name(autoload_name)
                local loaded, err = library:load_named_config(library.autoload_config)
                if not loaded then notify("Auto-load config unavailable: " .. tostring(err)) end
            end
        end
    --

    -- Notification Library
        function notifications:refresh_notifs() 
            local offset = 50

            for i, v in notifications.notifs do
                local Position = vec2(20, offset)
                library:tween(v, {Position = dim_offset(Position.X, Position.Y)}, Enum.EasingStyle.Quad, 0.4)
                offset += (v.AbsoluteSize.Y + 10)
            end

            return offset
        end
        
        function notifications:fade(path, is_fading)
            local fading = is_fading and 1 or 0 
            
            library:tween(path, {BackgroundTransparency = fading}, Enum.EasingStyle.Quad, 1)

            for _, instance in path:GetDescendants() do 
                if not instance:IsA("GuiObject") then 
                    if instance:IsA("UIStroke") then
                        library:tween(instance, {Transparency = fading}, Enum.EasingStyle.Quad, 1)
                    end
        
                    continue
                end 
        
                if instance:IsA("TextLabel") then
                    library:tween(instance, {TextTransparency = fading})
                elseif instance:IsA("Frame") then
                    library:tween(instance, {BackgroundTransparency = instance.Transparency and 0.6 and is_fading and 1 or 0.6}, Enum.EasingStyle.Quad, 1)
                end
            end
        end 
        
        function notifications:create_notification(options)
            local cfg = {
                name = options.name or "This is a title!";
                info = options.info or "This is extra info!";
                lifetime = options.lifetime or 3;
                items = {};
                outline = nil;
            }

            local items = cfg.items; do 
                items[ "notification" ] = library:create( "Frame" , {
                    Parent = library[ "items" ];
                    Size = dim2(0, 210, 0, 53);
                    Name = "\0";
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    AnchorPoint = vec2(1, 0);
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(14, 14, 16)
                });
                
                library:create( "UIStroke" , {
                    Color = rgb(23, 23, 29);
                    Parent = items[ "notification" ];
                    Transparency = 1;
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                });
                
                items[ "title" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "notification" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 7, 0, 6);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "notification" ];
                    CornerRadius = dim(0, 3)
                });
                
                items[ "info" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(145, 145, 145);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.info;
                    Parent = items[ "notification" ];
                    Name = "\0";
                    Position = dim2(0, 9, 0, 22);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    TextWrapped = true;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , {
                    PaddingBottom = dim(0, 17);
                    PaddingRight = dim(0, 8);
                    Parent = items[ "info" ]
                });
                
                items[ "bar" ] = library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = items[ "notification" ];
                    Name = "\0";
                    Position = dim2(0, 8, 1, -6);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 0, 5);
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "bar" ];
                    CornerRadius = dim(0, 999)
                });
                
                library:create( "UIPadding" , {
                    PaddingRight = dim(0, 8);
                    Parent = items[ "notification" ]
                });
            end
            
            local index = #notifications.notifs + 1
            notifications.notifs[index] = items[ "notification" ]

            notifications:fade(items[ "notification" ], false)
            
            local offset = notifications:refresh_notifs()

            items[ "notification" ].Position = dim_offset(20, offset)

            library:tween(items[ "notification" ], {AnchorPoint = vec2(0, 0)}, Enum.EasingStyle.Quad, 1)
            library:tween(items[ "bar" ], {Size = dim2(1, -8, 0, 5)}, Enum.EasingStyle.Quad, cfg.lifetime)

            task.spawn(function()
                task.wait(cfg.lifetime)
                
                notifications.notifs[index] = nil
                
                notifications:fade(items[ "notification" ], true)
                
                library:tween(items[ "notification" ], {AnchorPoint = vec2(1, 0)}, Enum.EasingStyle.Quad, 1)

                task.wait(1)
        
                items[ "notification" ]:Destroy() 
            end)
        end
    --
-- 

return library
