--[[
    Milenium Library example (updated with the v2 features)

    What the new Library.lua gives you out of the box:
      * Floating touch toggle (mobile)  -> shows on touch devices, drag to reposition.
      * Auto resize                    -> window fits the viewport; toggle lives in
                                          the "Configs" tab under the Auto Resize section.
      * Manual resize                  -> grab the visible corner grip at the window's
                                          bottom-right, or call window:set_size(width, height).
      * Icon provider                  -> library:set_icon_provider("heroicons") plus provider
                                          icon names on tabs/sections, or
                                          window:set_tab_icon("Setup", "user-16-solid").
                                          Icons can be changed later with section:set_icon,
                                          window:set_subtab_icon, or tabbox:set_tab_icon.
                                          Providers: lucide, tabler, heroicons, solar,
                                          material, fluent, phosphor.
      * Mini windows                   -> library:mini_window{...}: same widget API as a
                                          window, compact, and collapsible from its title bar.
      * Toggle styles                  -> type = "toggle" (switch) or "checkbox" (box).
      * Config manager                 -> "Configs" tab: create / overwrite / load / delete
                                          / refresh / auto-load / clipboard integrate / share.
      * Theme customizer               -> "Configs" tab: Accent, Window background, Surface,
                                          Text, and Muted text colors. Colors persist into
                                          saved configs via __theme.

    This example builds a demo window so you can exercise every feature in-game.
    All the library's own controls (configs, interface/resize, theme, icon sizing)
    now live under one "Settings" tab, built by library:init_config(window).
    The built-in API surface it exercises:
      library:window(cfg)        -> returns a window object
      window:set_size(w, h)      -> manual resize (auto-resize wins over manual widths)
      window:auto_resize         -> boolean you can flip directly
      window:apply_viewport()    -> re-fit to the current camera's viewport
      library:update_theme(k, c) -> recolor a named theme role (accent, background, surface, text, muted)
      library.themes.preset      -> current theme colors (read-only reference)
      library:init_config(win)   -> builds the Configs tab (leave this last)

    The demo widgets below are pure UI (toggle / slider / dropdown / colorpicker /
    keybind / label) so nothing here touches gameplay.
]]

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/sickletone/sillylua/refs/heads/main/Library.lua"))()

-- Optional: load the molto icon provider. Tab/section icons can then be provider
-- icon names (e.g. "user-16-solid") instead of Roblox asset URLs.
library:set_icon_provider("heroicons")

-- Icon names used by the demo. Change these three strings to restyle the demo's
-- tabs, group boxes/sections, and sub tabs from one place in the source.
local ICONS = {
    tab = "user-16-solid",
    section = "user-16-solid",
    subtab = "user-16-solid",
}

-- Tracked so the provider-switch button can give these provider-appropriate names.
local iconTargets = {}
local function trackIcon(target)
    iconTargets[#iconTargets + 1] = target
end

local DESKTOP_SIZE  = {X = 700, Y = 565}
local MOBILE_SIZE   = {X = 320, Y = 300}

local window = library:window({
    name     = "silly",
    suffix   = ".lua",
    gameInfo = "Milenium Library demo",
    autoResize = true,
})

-- Read back the auto-resize state so we can flip it regardless of what the UI says.
local initialAutoResize = window.auto_resize

local function demoWindow()
    window:seperator({name = "Setup"})
    local setupTab = window:tab({name = "Setup", tabs = {"Main"}, icon = ICONS.tab})

    local col = setupTab:column({})
    local general = col:section({name = "Widget Demo", size = 0.5, default = true, icon = ICONS.section})
    trackIcon(general)

    -- Toggle / Slider / Dropdown / Colorpicker / Keybind / Label
    general:toggle({
        name = "Demo Toggle (switch)",
        type = "toggle",
        seperator = true,
        callback = function(bool)
            print("[Milenium demo] toggle set to", bool)
        end,
    })
    general:toggle({
        name = "Demo Toggle (checkbox)",
        type = "checkbox",
        seperator = true,
        callback = function(bool)
            print("[Milenium demo] checkbox set to", bool)
        end,
    })
    general:slider({
        name = "Demo Slider",
        min = 0, max = 100,
        default = 50, interval = 1,
        seperator = true,
        callback = function(value)
            print("[Milenium demo] slider =", value)
        end,
    })
    general:dropdown({
        name = "Demo Dropdown",
        items = {"One", "Two", "Three"},
        default = "One",
        seperator = true,
        callback = function(value)
            print("[Milenium demo] dropdown =", value)
        end,
    })
    general:keybind({
        name = "Demo Keybind",
        callback = function()
            print("[Milenium demo] keybind fired")
        end,
    })
    general:label({
        name = "Widget Demo",
        info = "Toggle, slider, dropdown, keybind, and label above all write to the output window so you can see the callbacks fire.",
    })

    local themePreview = col:section({name = "Theme Preview", size = 0.5, default = true, icon = ICONS.section})
    trackIcon(themePreview)
    -- Exposes the current theme colors so you can see the layout react to
    -- update_theme() edits made from the Configs tab.
    themePreview:label({
        name = "Live Theme",
        info = table.concat({
            "Accent      = rgb(" .. tostring(math.floor(library.themes.preset.accent.R * 255))     .. ", " .. tostring(math.floor(library.themes.preset.accent.G * 255))     .. ", " .. tostring(math.floor(library.themes.preset.accent.B * 255))     .. ")",
            "Background  = rgb(" .. tostring(math.floor(library.themes.preset.background.R * 255)) .. ", " .. tostring(math.floor(library.themes.preset.background.G * 255)) .. ", " .. tostring(math.floor(library.themes.preset.background.B * 255)) .. ")",
            "Surface     = rgb(" .. tostring(math.floor(library.themes.preset.surface.R * 255))    .. ", " .. tostring(math.floor(library.themes.preset.surface.G * 255))    .. ", " .. tostring(math.floor(library.themes.preset.surface.B * 255))    .. ")",
            "Text        = rgb(" .. tostring(math.floor(library.themes.preset.text.R * 255))       .. ", " .. tostring(math.floor(library.themes.preset.text.G * 255))       .. ", " .. tostring(math.floor(library.themes.preset.text.B * 255))       .. ")",
            "Muted       = rgb(" .. tostring(math.floor(library.themes.preset.muted.R * 255))      .. ", " .. tostring(math.floor(library.themes.preset.muted.G * 255))      .. ", " .. tostring(math.floor(library.themes.preset.muted.B * 255))      .. ")",
        }, "\n"),
    })
end

local function resizeSection()
    window:seperator({name = "Resize"})
    local resizeTab = window:tab({name = "Resize", tabs = {"Main"}, icon = ICONS.tab})

    local col = resizeTab:column({})
    local section = col:section({name = "Window Sizing", size = 1, default = true, icon = ICONS.section})
    trackIcon(section)

    section:label({
        name = "How to resize",
        info = "Drag the visible corner grip at the window's bottom-right for a manual resize. "
            .. "The Auto Resize toggle in the Configs tab decides whether the window fits "
            .. "the current viewport automatically. window.tabs[index]:set_icon(name) changes "
            .. "a tab icon at runtime.",
    })
    section:label({
        name = "Icon APIs",
        info = "section:set_icon(name) changes a group box icon. "
            .. "window:set_tab_icon(tab, name) changes a sidebar tab. "
            .. "window:set_subtab_icon(tab, subtab, name) changes a sub tab. "
            .. "box:set_tab_icon(tab, name) changes a tab-box tab.",
    })

    section:button({
        name = "Desktop (700 x 565)",
        callback = function()
            window:set_size(DESKTOP_SIZE.X, DESKTOP_SIZE.Y)
            window.apply_viewport()
        end,
    })
    section:button({
        name = "Compact (480 x 400)",
        callback = function()
            window:set_size(480, 400)
            window.apply_viewport()
        end,
    })
    section:button({
        name = "Small (320 x 300)",
        callback = function()
            window:set_size(MOBILE_SIZE.X, MOBILE_SIZE.Y)
            window.apply_viewport()
        end,
    })
    section:button({
        name = "Re-fit to viewport",
        callback = function()
            window.apply_viewport()
        end,
    })
    section:toggle({
        name = "Auto resize",
        seperator = true,
        default = initialAutoResize,
        callback = function(bool)
            window.auto_resize = bool
            window.apply_viewport()
        end,
    })
    section:button({
        name = "Switch tab icons to Lucide",
        seperator = true,
        callback = function()
            library:set_icon_provider("lucide")
            local icons = {"settings", "move", "layout-dashboard", "sliders-horizontal"}
            for index, tab in ipairs(window.tabs) do
                window:set_tab_icon(tab.name, icons[index] or "circle")
            end
            for _, target in ipairs(iconTargets) do
                target:set_icon("user")
            end
            window:set_subtab_icon("Tab Box", "Main", "layout-dashboard")
        end,
    })
end

demoWindow()
resizeSection()

-- Sub windows: standalone drag/resize windows with the same component API as the main window.
local notes = library:sub_window({
    name = "Notes", suffix = ".lua",
    position = UDim2.new(0, 40, 0, 220),
})

do
    local page = notes:tab({name = "Page A", icon = ICONS.subtab})
    trackIcon(page)
    local col = page:column({})
    local section = col:section({name = "Sub Window Section", size = 1, default = true, icon = ICONS.section})
    trackIcon(section)
    section:toggle({name = "Works Like Main", seperator = true, callback = function(b) print("[sub A]", b) end})
    section:slider({name = "Sub Slider", min = 0, max = 100, default = 30, interval = 1, seperator = true, callback = function(v) print("[sub A]", v) end})
end

do
    local page2 = notes:tab({name = "Page B", icon = ICONS.subtab})
    trackIcon(page2)
    local col2 = page2:column({})
    local s2 = col2:section({name = "Second Page", size = 1, default = true, icon = ICONS.section})
    trackIcon(s2)
    s2:label({name = "Sub window info", info = "This window is draggable by its title bar, resizable at the bottom-right, and closable with the × button. Popups (dropdowns, color pickers) open inside this window, not the main one."})
end

-- Mini windows: a compact version of the same window API. Collapse it with "−"
-- in its title bar, expand it with "+". Mini windows share the main window's widgets.
local mini = library:mini_window({
    name = "Mini", suffix = ".lua",
    position = UDim2.new(0, 40, 0, 560),
})

do
    local page = mini:tab({name = "Quick", icon = ICONS.subtab})
    trackIcon(page)
    local col = page:column({})
    local section = col:section({name = "Mini Window", size = 1, default = true, icon = ICONS.section})
    trackIcon(section)
    section:toggle({name = "Mini checkbox", type = "checkbox", seperator = true, callback = function(b) print("[mini]", b) end})
    section:slider({name = "Mini slider", min = 0, max = 100, default = 40, interval = 1, seperator = true, callback = function(v) print("[mini]", v) end})
    section:label({name = "Collapse me", info = "Use the − button in the title bar to collapse this mini window and + to bring it back."})
end

-- Tab boxes: horizontal tab strips (left/middle/right alignment) inside one content area.
-- Creating the tab box on a page keeps it inside that tab instead of floating over others.
local boxTab = window:tab({name = "Tab Box", tabs = {"Main"}, subTabIcons = {Main = ICONS.subtab}})
local boxCol = boxTab:column({})
local box = boxCol:tabbox({side = "middle"})
local leftPage = box:tab({name = "Box Left", icon = ICONS.subtab})
local rightPage = box:tab({name = "Box Right"})
rightPage:set_icon(ICONS.subtab) -- runtime sub-tab icon edit

trackIcon(leftPage)
trackIcon(rightPage)

do
    local col = leftPage:column({})
    local sec = col:section({name = "Tab Box Left", size = 1, default = true, icon = ICONS.section})
    trackIcon(sec)
    sec:label({name = "Left tab box", info = "Each tab box has its own independent tab set, just like the main window."})
end

do
    local col = rightPage:column({})
    local sec = col:section({name = "Tab Box Right", size = 1, default = true, icon = ICONS.section})
    trackIcon(sec)
    sec:toggle({name = "Box Toggle", seperator = true, callback = function(b) print("[box right]", b) end})
end

-- Builds the "Settings" tab: config manager + interface (resize/icon) + theme pages.
-- Always call this last so the config list refreshes after every widget is created.
library:init_config(window)
